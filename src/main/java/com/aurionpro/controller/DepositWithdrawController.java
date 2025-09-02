package com.aurionpro.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.BankAccount;
import com.aurionpro.model.Transaction;
import com.aurionpro.service.BankAccountService;

@WebServlet("/DepositWithdrawController")
public class DepositWithdrawController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankAccountService accountService;

	@Override
	public void init() throws ServletException {
		accountService = new BankAccountService();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		int accountId = Integer.parseInt(request.getParameter("accountId"));
		String action = request.getParameter("action");
		BigDecimal amount = new BigDecimal(request.getParameter("amount"));
		BankAccount account = accountService.getAccountById(accountId);
		String message = "";
		boolean transactionSuccess = false;

		// 1. Only allow on "active" accounts
		if (!"active".equalsIgnoreCase(account.getStatus())) {
			message = "This account is not approved. Deposits and withdrawals are not permitted.";
		}
		// 2. Amount must be positive
		else if (amount.compareTo(BigDecimal.ZERO) <= 0) {
			message = "Amount must be positive.";
		}
		// 3. Withdrawal validation
		else if ("withdraw".equals(action)) {
			if (amount.compareTo(account.getBalance()) > 0) {
				message = "Insufficient balance.";
			} else {
				accountService.updateBalance(accountId, account.getBalance().subtract(amount));
				// Add withdrawal transaction
				Transaction txn = new Transaction();
				txn.setSenderAccountId(accountId); // Money is going out
				txn.setReceiverAccountId(null); // No other party
				txn.setAmount(amount);
				txn.setType("withdraw");
				txn.setDescription("User withdrawal");
				txn.setTransactionDate(new Timestamp(System.currentTimeMillis()));
				txn.setDeleted(false);
				accountService.saveTransaction(txn);
				message = "Withdrawal successful.";
				transactionSuccess = true;
			}
		}
		// 4. Deposit
		else if ("deposit".equals(action)) {
			accountService.updateBalance(accountId, account.getBalance().add(amount));
			Transaction txn = new Transaction();
			txn.setSenderAccountId(null); // No sender for deposit
			txn.setReceiverAccountId(accountId); // Money is received into this account
			txn.setAmount(amount);
			txn.setType("deposit");
			txn.setDescription("User deposit");
			txn.setTransactionDate(new Timestamp(System.currentTimeMillis()));
			txn.setDeleted(false);
			accountService.saveTransaction(txn);
			message = "Deposit successful.";
			transactionSuccess = true;
		} else {
			message = "Invalid action.";
		}

		// Reload updated account & show result
		BankAccount updatedAccount = accountService.getAccountById(accountId);
		request.setAttribute("message", message);
		request.setAttribute("account", updatedAccount);
		request.getRequestDispatcher("account-details.jsp").forward(request, response);
	}
}
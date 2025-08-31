package com.aurionpro.controller;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.BankAccount;
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
				message = "Withdrawal successful.";
			}
		}
		// 4. Deposit
		else if ("deposit".equals(action)) {
			accountService.updateBalance(accountId, account.getBalance().add(amount));
			message = "Deposit successful.";
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
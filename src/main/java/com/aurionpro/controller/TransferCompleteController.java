package com.aurionpro.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.BankAccount;
import com.aurionpro.model.Transaction;
import com.aurionpro.service.BankAccountService;

@WebServlet("/TransferCompleteController")
public class TransferCompleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankAccountService accountService;

	@Override
	public void init() throws ServletException {
		accountService = new BankAccountService();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int senderAccountId = Integer.parseInt(request.getParameter("senderAccountId"));
		int receiverAccountId = Integer.parseInt(request.getParameter("receiverAccountId"));
		BigDecimal amount = new BigDecimal(request.getParameter("amount"));
		String description = request.getParameter("description");

		BankAccount senderAccount = accountService.getAccountById(senderAccountId);
		BankAccount receiverAccount = accountService.getAccountById(receiverAccountId);
		String message = "";

		if (receiverAccount == null || !"active".equalsIgnoreCase(receiverAccount.getStatus())) {
			message = "Recipient account not found or not active.";
		} else if (!"active".equalsIgnoreCase(senderAccount.getStatus())) {
			message = "Your account is not active.";
		} else if (amount.compareTo(BigDecimal.ZERO) <= 0) {
			message = "Amount must be positive.";
		} else if (amount.compareTo(senderAccount.getBalance()) > 0) {
			message = "Insufficient balance.";
		} else {
			accountService.updateBalance(senderAccountId, senderAccount.getBalance().subtract(amount));
			accountService.updateBalance(receiverAccountId, receiverAccount.getBalance().add(amount));
			Transaction transaction = new Transaction();
			transaction.setSenderAccountId(senderAccountId);
			transaction.setReceiverAccountId(receiverAccountId);
			transaction.setAmount(amount);
			transaction.setType("transfer");
			transaction.setDescription((description == null || description.trim().isEmpty()) ? "User initiated transfer"
					: description.trim());
			transaction.setTransactionDate(new Timestamp(System.currentTimeMillis()));
			transaction.setDeleted(false);
			accountService.saveTransaction(transaction); // SERVICE method
			message = "Transfer completed successfully.";
		}
		request.setAttribute("message", message);
		request.getRequestDispatcher("DashboardController").forward(request, response);
	}
}
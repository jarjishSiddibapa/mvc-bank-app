package com.aurionpro.controller;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.BankAccount;
import com.aurionpro.model.User;
import com.aurionpro.service.BankAccountService;
import com.aurionpro.service.UserService;

@WebServlet("/TransferInitiateController")
public class TransferInitiateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankAccountService accountService;
	private UserService userService;

	@Override
	public void init() throws ServletException {
		accountService = new BankAccountService();
		userService = new UserService();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int senderAccountId = Integer.parseInt(request.getParameter("senderAccountId"));
		String receiverAccountNumber = request.getParameter("receiverAccountNumber");
		BigDecimal amount = new BigDecimal(request.getParameter("amount"));

		BankAccount senderAccount = accountService.getAccountById(senderAccountId);
		BankAccount receiverAccount = accountService.getAccountByNumber(receiverAccountNumber);
		String message = "";

		if (receiverAccount == null || !"active".equalsIgnoreCase(receiverAccount.getStatus())) {
			message = "Recipient account not found or not active.";
		} else if (amount.compareTo(BigDecimal.ZERO) <= 0) {
			message = "Amount must be positive.";
		} else if (!"active".equalsIgnoreCase(senderAccount.getStatus())) {
			message = "Your account is not active.";
		} else if (amount.compareTo(senderAccount.getBalance()) > 0) {
			message = "Insufficient balance.";
		}

		// Fetch recipient user details
		User recipientUser = null;
		if (receiverAccount != null) {
			recipientUser = userService.getUserById(receiverAccount.getUserId());
		}

		request.setAttribute("message", message);
		request.setAttribute("senderAccount", senderAccount);
		request.setAttribute("receiverAccount", receiverAccount);
		request.setAttribute("recipientUser", recipientUser);
		request.setAttribute("amount", amount);

		RequestDispatcher rd = request.getRequestDispatcher("transfer-confirm.jsp");
		rd.forward(request, response);
	}
}
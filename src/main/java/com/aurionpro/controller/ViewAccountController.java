package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.BankAccount;
import com.aurionpro.service.BankAccountService;

@WebServlet("/ViewAccountController")
public class ViewAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankAccountService accountService;

	public ViewAccountController() {
		super();
		accountService = new BankAccountService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check login/session
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Get account id from param (expecting ?id=...)
		String idStr = request.getParameter("id");
		if (idStr == null || idStr.trim().isEmpty()) {
			request.setAttribute("message", "No account specified.");
			request.getRequestDispatcher("customer-frontend.jsp").forward(request, response);
			return;
		}

		int accountId;
		try {
			accountId = Integer.parseInt(idStr.trim());
		} catch (NumberFormatException e) {
			request.setAttribute("message", "Invalid account id.");
			request.getRequestDispatcher("customer-frontend.jsp").forward(request, response);
			return;
		}

		BankAccount account = accountService.getAccountById(accountId);
		if (account == null) {
			request.setAttribute("message", "Account not found.");
			request.getRequestDispatcher("customer-frontend.jsp").forward(request, response);
			return;
		}

		// All good, show details page
		request.setAttribute("account", account);
		RequestDispatcher rd = request.getRequestDispatcher("account-details.jsp");
		rd.forward(request, response);
	}
}
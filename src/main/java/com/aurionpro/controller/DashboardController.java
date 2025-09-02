package com.aurionpro.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.BankAccount;
import com.aurionpro.model.User;
import com.aurionpro.service.BankAccountService;

/**
 * Servlet implementation class DashboardController
 */
@WebServlet("/DashboardController")
public class DashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankAccountService accountService = new BankAccountService();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		User user = (User) session.getAttribute("user");
		// Load up-to-date accounts from DB for this user
		List<BankAccount> accounts = accountService.getAccountsForUser(user.getUserId());
		request.setAttribute("accounts", accounts);

		// Handle message parameter (useful for redirect-after-mutation)
		String message = request.getParameter("message");
		if (message != null && !message.trim().isEmpty()) {
			request.setAttribute("message", message);
		}

		// Forward to dashboard JSP
		RequestDispatcher rd = request.getRequestDispatcher("customer-frontend.jsp");
		rd.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response); // Simply redirect POST to GET for safety
	}
}

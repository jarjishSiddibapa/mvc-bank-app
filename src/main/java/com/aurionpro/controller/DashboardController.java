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
	private BankAccountService accountService;

	public DashboardController() {
		super();
		accountService = new BankAccountService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		User user = (User) session.getAttribute("user");

		// Load user's accounts
		List<BankAccount> accounts = accountService.getAccountsForUser(user.getUserId());
		request.setAttribute("accounts", accounts);

		// Handle message parameter and set as attribute
		String message = request.getParameter("message");
		if (message != null) {
			request.setAttribute("message", message);
		}

		// Forward to JSP
		RequestDispatcher rd = request.getRequestDispatcher("customer-frontend.jsp");
		rd.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
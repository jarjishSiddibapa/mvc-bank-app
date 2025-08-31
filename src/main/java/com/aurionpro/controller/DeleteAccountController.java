package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.service.BankAccountService;

@WebServlet("/DeleteAccountController")
public class DeleteAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankAccountService accountService;

	public DeleteAccountController() {
		super();
		accountService = new BankAccountService();
	}

//	@Override
//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int accountId = Integer.parseInt(request.getParameter("accountId"));
		boolean deleted = accountService.deleteAccount(accountId); // implement this method

		if (deleted) {
			response.sendRedirect("DashboardController?message=account_deleted");
		} else {
			response.sendRedirect("DashboardController?message=delete_failed");
		}
	}

}

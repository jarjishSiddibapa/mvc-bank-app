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
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int accountId = Integer.parseInt(request.getParameter("accountId"));
		BankAccount account = accountService.getAccountById(accountId); // implement this method

		request.setAttribute("account", account);
		RequestDispatcher rd = request.getRequestDispatcher("account-details.jsp");
		rd.forward(request, response);
	}
}
package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.service.BankAccountService;

@WebServlet("/ApproveAccountController")
public class ApproveAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankAccountService accountService;

	@Override
	public void init() throws ServletException {
		accountService = new BankAccountService();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int accountId = Integer.parseInt(request.getParameter("accountId"));
		String status = request.getParameter("status");
		accountService.updateAccountStatus(accountId, status);
		response.sendRedirect("AdminDashboardController");
	}
}
package com.aurionpro.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.BankAccount;
import com.aurionpro.model.Transaction;
import com.aurionpro.model.User;
import com.aurionpro.service.BankAccountService;
import com.aurionpro.service.UserService;

@WebServlet("/AdminDashboardController")
public class AdminDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService;
	private BankAccountService accountService;

	public AdminDashboardController() {
	}

	@Override
	public void init() throws ServletException {
		userService = new UserService();
		accountService = new BankAccountService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			List<User> users = userService.getAllUsers();
			List<BankAccount> pendingAccounts = accountService.getAllPendingAccounts();
			List<Transaction> transactions = accountService.getAllTransactions();
			List<BankAccount> allAccounts = accountService.getAllAccounts();
			Map<Integer, String> accountNumberMap = new HashMap<>();
			for (BankAccount acc : allAccounts) {
				accountNumberMap.put(acc.getAccountId(), acc.getAccountNumber());
			}
			request.setAttribute("users", users);
			request.setAttribute("pendingAccounts", pendingAccounts);
			request.setAttribute("transactions", transactions);
			request.setAttribute("accountNumberMap", accountNumberMap);
			request.setAttribute("allAccounts", allAccounts); // <-- ADDED so dashboard count works
		} catch (Exception e) {
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("admin-dashboard.jsp");
		rd.forward(request, response);
	}
}
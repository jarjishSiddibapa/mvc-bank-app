package com.aurionpro.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.BankAccount;
import com.aurionpro.model.Transaction;
import com.aurionpro.service.BankAccountService;

@WebServlet("/PassbookController")
public class PassbookController extends HttpServlet {
	private BankAccountService accountService;

	@Override
	public void init() {
		accountService = new BankAccountService();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idStr = req.getParameter("accountId");
		if (idStr == null || idStr.trim().isEmpty()) {
			req.setAttribute("message", "No account selected for passbook.");
			req.getRequestDispatcher("customer-frontend.jsp").forward(req, resp);
			return;
		}
		int accountId = Integer.parseInt(idStr.trim());
		BankAccount account = accountService.getAccountById(accountId);
		List<Transaction> transactions = accountService.getTransactionsForAccount(accountId);

		// Fetch account numbers for all unique sender/receiver IDs found in
		// transactions
		Map<Integer, String> accountNumberMap = new HashMap<>();
		for (Transaction txn : transactions) {
			if (txn.getSenderAccountId() != null && !accountNumberMap.containsKey(txn.getSenderAccountId())) {
				BankAccount acc = accountService.getAccountById(txn.getSenderAccountId());
				if (acc != null) {
					accountNumberMap.put(txn.getSenderAccountId(), acc.getAccountNumber());
				}
			}
			if (txn.getReceiverAccountId() != null && !accountNumberMap.containsKey(txn.getReceiverAccountId())) {
				BankAccount acc = accountService.getAccountById(txn.getReceiverAccountId());
				if (acc != null) {
					accountNumberMap.put(txn.getReceiverAccountId(), acc.getAccountNumber());
				}
			}
		}

		req.setAttribute("account", account);
		req.setAttribute("transactions", transactions);
		req.setAttribute("accountNumberMap", accountNumberMap);
		req.getRequestDispatcher("passbook.jsp").forward(req, resp);
	}
}
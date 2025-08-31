package com.aurionpro.service;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.dao.BankAccountDao;
import com.aurionpro.model.BankAccount;
import com.aurionpro.model.Transaction;

public class BankAccountService {
	private BankAccountDao dao;

	public BankAccountService() {
		dao = new BankAccountDao();
	}

	public boolean createAccount(int userId, String accountType) {
		try {
			return dao.createAccount(userId, accountType);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public List<BankAccount> getAccountsForUser(int userId) {
		try {
			return dao.getAccountsForUser(userId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public boolean deleteAccount(int accountId) {
		try {
			return dao.deleteAccount(accountId); // implement in DAO
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public BankAccount getAccountById(int accountId) {
		try {
			return dao.getAccountById(accountId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<BankAccount> getAllPendingAccounts() {
		try {
			return dao.getAllPendingAccounts();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateAccountStatus(int accountId, String status) {
		try {
			return dao.updateAccountStatus(accountId, status);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateBalance(int accountId, BigDecimal newBalance) {
		try {
			return dao.updateBalance(accountId, newBalance);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public BankAccount getAccountByNumber(String accountNumber) {
		try {
			return dao.getAccountByNumber(accountNumber);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public boolean recordTransaction(int senderId, int receiverId, BigDecimal amount, String type, String description) {
		try {
			return dao.insertTransaction(senderId, receiverId, amount, type, description);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean saveTransaction(Transaction transaction) {
		try {
			return dao.saveTransaction(transaction);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<Transaction> getTransactionsForAccount(int accountId) {
		try {
			return dao.getTransactionsForAccount(accountId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}

	public List<BankAccount> getAllAccounts() {
		try {
			return dao.getAllAccounts();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}

	public List<Transaction> getAllTransactions() {
		try {
			return dao.getAllTransactions();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}

}

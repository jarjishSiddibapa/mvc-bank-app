package com.aurionpro.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.model.BankAccount;
import com.aurionpro.model.Transaction;
import com.aurionpro.util.Database;

public class BankAccountDao {
	private Connection connection = null;

	public BankAccountDao() {
		connection = Database.getInstance().getConnection();
	}

	public boolean createAccount(int userId, String accountType) throws SQLException {
		String sql = "INSERT INTO bank_accounts (user_id, account_type, account_number, status, created_at, is_deleted, balance) VALUES (?, ?, ?, 'pending', CURRENT_TIMESTAMP, FALSE, 0.00)";
		String accountNumber = generateAccountNumber(accountType);

		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setString(2, accountType);
			stmt.setString(3, accountNumber);
			int rows = stmt.executeUpdate();
			return rows > 0;
		}
	}

	public String generateAccountNumber(String accountType) throws SQLException {
		String seqSql = "SELECT nextval('account_number_seq')";
		int seqNum = 0;
		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(seqSql)) {
			if (rs.next()) {
				seqNum = rs.getInt(1);
			}
		}
		String accountPrefix = accountType.equals("savings") ? "SB" : "CU";
		return accountPrefix + String.format("%08d", seqNum);
	}

	public List<BankAccount> getAccountsForUser(int userId) throws SQLException {
		List<BankAccount> accounts = new ArrayList<>();
		String sql = "SELECT * FROM bank_accounts WHERE user_id = ? AND is_deleted = FALSE";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					BankAccount account = new BankAccount();
					account.setAccountId(rs.getInt("account_id"));
					account.setUserId(rs.getInt("user_id"));
					account.setAccountType(rs.getString("account_type"));
					account.setAccountNumber(rs.getString("account_number"));
					account.setStatus(rs.getString("status"));
					account.setCreatedAt(rs.getTimestamp("created_at"));
					account.setApprovedAt(rs.getTimestamp("approved_at"));
					account.setDeleted(rs.getBoolean("is_deleted"));
					account.setBalance(rs.getBigDecimal("balance")); // ADDED
					accounts.add(account);
				}
			}
		}
		return accounts;
	}

	public boolean deleteAccount(int accountId) throws SQLException {
		String sql = "UPDATE bank_accounts SET is_deleted = TRUE WHERE account_id = ?";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, accountId);
			int rows = stmt.executeUpdate();
			return rows > 0;
		}
	}

	public BankAccount getAccountById(int accountId) throws SQLException {
		String sql = "SELECT * FROM bank_accounts WHERE account_id = ?";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, accountId);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					BankAccount account = new BankAccount();
					account.setAccountId(rs.getInt("account_id"));
					account.setUserId(rs.getInt("user_id"));
					account.setAccountType(rs.getString("account_type"));
					account.setAccountNumber(rs.getString("account_number"));
					account.setStatus(rs.getString("status"));
					account.setCreatedAt(rs.getTimestamp("created_at"));
					account.setApprovedAt(rs.getTimestamp("approved_at"));
					account.setDeleted(rs.getBoolean("is_deleted"));
					account.setBalance(rs.getBigDecimal("balance"));
					return account;
				}
			}
		}
		return null;
	}

	public List<BankAccount> getAllPendingAccounts() throws SQLException {
		List<BankAccount> accounts = new ArrayList<>();
		String sql = "SELECT * FROM bank_accounts WHERE status = 'pending' AND is_deleted=FALSE";
		try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				BankAccount account = new BankAccount();
				account.setAccountId(rs.getInt("account_id"));
				account.setUserId(rs.getInt("user_id"));
				account.setAccountType(rs.getString("account_type"));
				account.setAccountNumber(rs.getString("account_number"));
				account.setStatus(rs.getString("status"));
				account.setCreatedAt(rs.getTimestamp("created_at"));
				account.setApprovedAt(rs.getTimestamp("approved_at"));
				account.setDeleted(rs.getBoolean("is_deleted"));
				account.setBalance(rs.getBigDecimal("balance"));
				accounts.add(account);
			}
		}
		return accounts;
	}

	public boolean updateAccountStatus(int accountId, String status) throws SQLException {
		String sql = "UPDATE bank_accounts SET status = ? WHERE account_id = ?";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, status);
			stmt.setInt(2, accountId);
			return stmt.executeUpdate() > 0;
		}
	}

	public boolean updateBalance(int accountId, BigDecimal newBalance) throws SQLException {
		String sql = "UPDATE bank_accounts SET balance = ? WHERE account_id = ?";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setBigDecimal(1, newBalance);
			stmt.setInt(2, accountId);
			return stmt.executeUpdate() > 0;
		}
	}

	public BankAccount getAccountByNumber(String accountNumber) throws SQLException {
		String sql = "SELECT * FROM bank_accounts WHERE account_number = ? AND is_deleted = FALSE";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, accountNumber);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					BankAccount account = new BankAccount();
					account.setAccountId(rs.getInt("account_id"));
					account.setUserId(rs.getInt("user_id"));
					account.setAccountType(rs.getString("account_type"));
					account.setAccountNumber(rs.getString("account_number"));
					account.setStatus(rs.getString("status"));
					account.setCreatedAt(rs.getTimestamp("created_at"));
					account.setApprovedAt(rs.getTimestamp("approved_at"));
					account.setDeleted(rs.getBoolean("is_deleted"));
					account.setBalance(rs.getBigDecimal("balance"));
					return account;
				}
			}
		}
		return null;
	}

	public boolean insertTransaction(int senderId, int receiverId, BigDecimal amount, String type, String description)
			throws SQLException {
		String sql = "INSERT INTO transactions (sender_account_id, receiver_account_id, amount, type, description, transaction_date, is_deleted) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, FALSE)";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setObject(1, senderId > 0 ? senderId : null);
			stmt.setObject(2, receiverId > 0 ? receiverId : null);
			stmt.setBigDecimal(3, amount);
			stmt.setString(4, type);
			stmt.setString(5, description);
			return stmt.executeUpdate() > 0;
		}
	}

	public List<Transaction> getAllTransactions() throws SQLException {
		List<Transaction> transactions = new ArrayList<>();
		String sql = "SELECT * FROM transactions WHERE is_deleted = FALSE ORDER BY transaction_date DESC";
		try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Transaction t = new Transaction();
				t.setTransactionId(rs.getInt("transaction_id"));
				t.setSenderAccountId(rs.getInt("sender_account_id"));
				t.setReceiverAccountId(rs.getInt("receiver_account_id"));
				t.setAmount(rs.getBigDecimal("amount"));
				t.setType(rs.getString("type"));
				t.setDescription(rs.getString("description"));
				t.setTransactionDate(rs.getTimestamp("transaction_date"));
				transactions.add(t);
			}
		}
		return transactions;
	}

	public boolean saveTransaction(Transaction transaction) throws SQLException {
		String sql = "INSERT INTO transactions (sender_account_id, receiver_account_id, amount, type, description, transaction_date, is_deleted) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setObject(1, transaction.getSenderAccountId());
			stmt.setObject(2, transaction.getReceiverAccountId());
			stmt.setBigDecimal(3, transaction.getAmount());
			stmt.setString(4, transaction.getType());
			stmt.setString(5, transaction.getDescription());
			stmt.setTimestamp(6, transaction.getTransactionDate());
			stmt.setBoolean(7, transaction.isDeleted());
			return stmt.executeUpdate() > 0;
		}
	}

	public List<Transaction> getTransactionsForAccount(int accountId) throws SQLException {
		List<Transaction> txns = new ArrayList<>();
		String sql = "SELECT * FROM transactions WHERE (sender_account_id = ? OR receiver_account_id = ?) "
				+ "AND is_deleted = FALSE ORDER BY transaction_date DESC";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, accountId);
			stmt.setInt(2, accountId);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					Transaction t = new Transaction();
					t.setTransactionId(rs.getInt("transaction_id"));
					// Correctly handle nullable fields with getObject (returns null if DB field is
					// NULL)
					Object senderIdObj = rs.getObject("sender_account_id");
					Object receiverIdObj = rs.getObject("receiver_account_id");
					t.setSenderAccountId(senderIdObj != null ? rs.getInt("sender_account_id") : null);
					t.setReceiverAccountId(receiverIdObj != null ? rs.getInt("receiver_account_id") : null);
					t.setAmount(rs.getBigDecimal("amount"));
					t.setType(rs.getString("type"));
					t.setDescription(rs.getString("description"));
					t.setTransactionDate(rs.getTimestamp("transaction_date"));
					t.setDeleted(rs.getBoolean("is_deleted"));
					txns.add(t);
				}
			}
		}
		return txns;
	}

	public List<BankAccount> getAllAccounts() throws SQLException {
		List<BankAccount> accounts = new ArrayList<>();
		String sql = "SELECT * FROM bank_accounts WHERE is_deleted = FALSE";
		try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				BankAccount account = new BankAccount();
				account.setAccountId(rs.getInt("account_id"));
				account.setUserId(rs.getInt("user_id"));
				account.setAccountType(rs.getString("account_type"));
				account.setAccountNumber(rs.getString("account_number"));
				account.setStatus(rs.getString("status"));
				account.setCreatedAt(rs.getTimestamp("created_at"));
				account.setApprovedAt(rs.getTimestamp("approved_at"));
				account.setDeleted(rs.getBoolean("is_deleted"));
				account.setBalance(rs.getBigDecimal("balance"));
				accounts.add(account);
			}
		}
		return accounts;
	}

}

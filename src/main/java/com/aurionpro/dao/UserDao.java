package com.aurionpro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.model.User;
import com.aurionpro.util.Database;

public class UserDao {
	private Connection connection;

	public UserDao() {
		connection = Database.getInstance().getConnection();
	}

	public User authenticate(String username, String password) throws SQLException {
		String sql = "SELECT * FROM users WHERE username = ? AND password = ? AND is_deleted = FALSE";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, username);
			stmt.setString(2, password); // Make sure to hash passwords in actual applications!
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					User user = new User();
					user.setUserId(rs.getInt("user_id"));
					user.setUsername(rs.getString("username"));
					user.setPassword(rs.getString("password"));
					user.setFullName(rs.getString("full_name"));
					user.setEmail(rs.getString("email"));
					user.setPhone(rs.getString("phone"));
					user.setAdmin(rs.getBoolean("is_admin"));
					user.setCreatedAt(rs.getTimestamp("created_at"));
					user.setDeleted(rs.getBoolean("is_deleted"));
					return user;
				}
			}
		}
		return null;
	}

	public List<User> getAllUsers() throws SQLException {
		List<User> users = new ArrayList<>();
		String sql = "SELECT * FROM users WHERE is_deleted=FALSE";
		try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				User u = new User();
				u.setUserId(rs.getInt("user_id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setFullName(rs.getString("full_name"));
				u.setEmail(rs.getString("email"));
				u.setPhone(rs.getString("phone"));
				u.setAdmin(rs.getBoolean("is_admin")); // Note: Maps to isAdmin getter/setter
				u.setCreatedAt(rs.getTimestamp("created_at"));
				u.setDeleted(rs.getBoolean("is_deleted"));
				users.add(u);
			}
		}
		return users;
	}

	public boolean deleteUser(int userId) throws SQLException {
		String sql = "UPDATE users SET is_deleted = TRUE WHERE user_id = ?";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			return stmt.executeUpdate() > 0;
		}
	}

	public User getUserByUsername(String username) throws SQLException {
		String sql = "SELECT * FROM users WHERE username = ? AND is_deleted = FALSE";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, username);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					User user = new User();
					user.setUserId(rs.getInt("user_id"));
					user.setUsername(rs.getString("username"));
					user.setPassword(rs.getString("password"));
					user.setFullName(rs.getString("full_name"));
					user.setEmail(rs.getString("email"));
					user.setPhone(rs.getString("phone"));
					user.setAdmin(rs.getBoolean("is_admin"));
					user.setCreatedAt(rs.getTimestamp("created_at"));
					user.setDeleted(rs.getBoolean("is_deleted"));
					return user;
				}
			}
		}
		return null;
	}

	public boolean insertUser(User user) throws SQLException {
		String sql = "INSERT INTO users (username, password, full_name, email, phone, is_admin, created_at, is_deleted) VALUES (?, ?, ?, ?, ?, FALSE, CURRENT_TIMESTAMP, FALSE)";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, user.getUsername());
			stmt.setString(2, user.getPassword()); // Hash in real app!
			stmt.setString(3, user.getFullName());
			stmt.setString(4, user.getEmail());
			stmt.setString(5, user.getPhone());
			return stmt.executeUpdate() > 0;
		}
	}

	public User getUserById(int userId) throws SQLException {
		String sql = "SELECT * FROM users WHERE user_id = ? AND is_deleted = FALSE";
		try (PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					User user = new User();
					user.setUserId(rs.getInt("user_id"));
					user.setUsername(rs.getString("username"));
					user.setPassword(rs.getString("password"));
					user.setFullName(rs.getString("full_name"));
					user.setEmail(rs.getString("email"));
					user.setPhone(rs.getString("phone"));
					user.setAdmin(rs.getBoolean("is_admin"));
					user.setCreatedAt(rs.getTimestamp("created_at"));
					user.setDeleted(rs.getBoolean("is_deleted"));
					return user;
				}
			}
		}
		return null;
	}
}

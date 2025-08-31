package com.aurionpro.service;

import java.sql.SQLException;
import java.util.List;

import com.aurionpro.dao.UserDao;
import com.aurionpro.model.User;

public class UserService {
	UserDao dao;

	public UserService() {
		this.dao = new UserDao();
	}

	public User authenticate(String username, String password) {
		try {
			return dao.authenticate(username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<User> getAllUsers() {
		try {
			return dao.getAllUsers();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean deleteUser(int userId) {
		try {
			return dao.deleteUser(userId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean userExists(String username) {
		try {
			return dao.getUserByUsername(username) != null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean registerUser(User user) {
		try {
			return dao.insertUser(user);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public User getUserById(int userId) {
		try {
			return dao.getUserById(userId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}

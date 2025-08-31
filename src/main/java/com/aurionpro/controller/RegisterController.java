package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.User;
import com.aurionpro.service.UserService;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService;

	@Override
	public void init() throws ServletException {
		userService = new UserService();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");

		String message = "";
		// Check if username already exists
		if (userService.userExists(username)) {
			message = "Username already taken. Please choose another.";
			request.setAttribute("message", message);
			request.getRequestDispatcher("register.jsp").forward(request, response);
			return;
		}

		// Never allow admin registration here
		User newUser = new User();
		newUser.setUsername(username);
		newUser.setPassword(password); // Consider hashing!
		newUser.setFullName(fullName);
		newUser.setEmail(email);
		newUser.setPhone(phone);
		newUser.setAdmin(false); // Always false for self-registration
		newUser.setDeleted(false);

		boolean success = userService.registerUser(newUser);
		if (success) {
			message = "Account created! Please login.";
			request.setAttribute("message", message);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		} else {
			message = "Account creation failed. Please try again.";
			request.setAttribute("message", message);
			request.getRequestDispatcher("register.jsp").forward(request, response);
		}
	}
}
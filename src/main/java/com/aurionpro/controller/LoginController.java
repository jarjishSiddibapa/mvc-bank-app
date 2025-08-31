package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.User;
import com.aurionpro.service.UserService;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
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

		User user = userService.authenticate(username, password);

		if (user != null) {
			// Create new session and store user
			HttpSession session = request.getSession(true);
			session.setAttribute("user", user);

			// Redirect based on user type
			if (user.isAdmin()) {
				response.sendRedirect("AdminDashboardController");
			} else {
				response.sendRedirect("DashboardController");
			}
		} else {
			// Login failed
			request.setAttribute("message", "Invalid username or password");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// If already logged in, redirect to appropriate dashboard
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			if (user.isAdmin()) {
				response.sendRedirect("AdminDashboardController");
			} else {
				response.sendRedirect("DashboardController");
			}
		} else {
			// Show login page
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
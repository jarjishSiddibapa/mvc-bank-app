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

@WebServlet("/EditProfileController")
public class EditProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Forward to edit profile page
		request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		User user = (User) session.getAttribute("user");

		// Get form data - only allow editing of basic information
		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");

		// Validate input
		if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty() || phone == null
				|| phone.trim().isEmpty()) {
			request.setAttribute("errorMessage", "All fields are required.");
			request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
			return;
		}

		// Update only if values have changed (selective update)
		boolean needsUpdate = false;

		if (!fullName.equals(user.getFullName()) || !email.equals(user.getEmail()) || !phone.equals(user.getPhone())) {
			needsUpdate = true;
		}

		if (!needsUpdate) {
			request.setAttribute("infoMessage", "No changes detected.");
			request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
			return;
		}

		// Update profile
		boolean success = userService.updateUserProfile(user.getUserId(), fullName.trim(), email.trim(), phone.trim());

		if (success) {
			// Update session user object
			user.setFullName(fullName.trim());
			user.setEmail(email.trim());
			user.setPhone(phone.trim());
			session.setAttribute("user", user);

			// Redirect to dashboard with success message
			response.sendRedirect("DashboardController?message="
					+ java.net.URLEncoder.encode("Profile updated successfully!", "UTF-8"));
		} else {
			request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
			request.getRequestDispatcher("edit-profile.jsp").forward(request, response);
		}
	}
}
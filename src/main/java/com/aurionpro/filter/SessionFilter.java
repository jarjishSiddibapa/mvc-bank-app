package com.aurionpro.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.User;

@WebFilter("/SessionFilter")
public class SessionFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession(false);

		String requestURI = httpRequest.getRequestURI();
		String contextPath = httpRequest.getContextPath();

		// Public pages that don't require authentication
		boolean isPublicPage = requestURI.endsWith("index.jsp") || requestURI.endsWith("login.jsp")
				|| requestURI.endsWith("register.jsp") || requestURI.contains("LoginController")
				|| requestURI.contains("RegisterController") || requestURI.contains("LogoutController")
				|| requestURI.contains(".css") || requestURI.contains(".js") || requestURI.contains(".png")
				|| requestURI.contains(".jpg");

		// Check if user is logged in
		User user = null;
		if (session != null) {
			user = (User) session.getAttribute("user");
		}

		if (isPublicPage || user != null) {
			// Allow access to public pages or authenticated users
			chain.doFilter(request, response);
		} else {
			// Redirect to login page
			httpResponse.sendRedirect(contextPath + "/login.jsp");
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void destroy() {
	}
}

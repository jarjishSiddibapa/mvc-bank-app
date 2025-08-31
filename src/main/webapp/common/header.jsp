<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Custom CSS for Modern Banking Theme -->
<style>
:root {
    --primary-color: #e63946;
    --secondary-color: #457b9d;
    --accent-color: #a8dadc;
    --light-color: #f1faee;
    --dark-color: #1d3557;
    --success-color: #198754;
    --warning-color: #ffc107;
    --danger-color: #dc3545;
}

.navbar-banking {
    background: linear-gradient(135deg, var(--dark-color) 0%, var(--secondary-color) 100%);
    box-shadow: 0 2px 15px rgba(29, 53, 87, 0.2);
    backdrop-filter: blur(10px);
}

.btn-banking-primary {
    background: linear-gradient(135deg, var(--primary-color), #c62d38);
    border: none;
    color: white;
    transition: all 0.3s ease;
    border-radius: 8px;
}

.btn-banking-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(230, 57, 70, 0.4);
    color: white;
}

.btn-banking-secondary {
    background: linear-gradient(135deg, var(--secondary-color), #356a84);
    border: none;
    color: white;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.btn-banking-secondary:hover {
    transform: translateY(-2px);
    color: white;
}

.card-banking {
    border: none;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
}

.card-banking:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.12);
}

body {
    background: linear-gradient(135deg, var(--light-color) 0%, rgba(168, 218, 220, 0.2) 100%);
    font-family: 'Inter', sans-serif;
    min-height: 100vh;
}

.text-banking-primary { color: var(--primary-color) !important; }
.text-banking-secondary { color: var(--secondary-color) !important; }
.text-banking-dark { color: var(--dark-color) !important; }

.alert-banking-success {
    background: linear-gradient(135deg, rgba(25, 135, 84, 0.1), rgba(168, 218, 220, 0.15));
    border: 1px solid var(--success-color);
    color: var(--dark-color);
    border-radius: 10px;
}

.alert-banking-danger {
    background: linear-gradient(135deg, rgba(230, 57, 70, 0.1), rgba(168, 218, 220, 0.15));
    border: 1px solid var(--primary-color);
    color: var(--dark-color);
    border-radius: 10px;
}

.navbar-brand {
    font-weight: 700;
    font-size: 1.5rem;
}

.nav-link {
    font-weight: 500;
    transition: all 0.3s ease;
}

.nav-link:hover {
    transform: translateY(-1px);
}
</style>

<nav class="navbar navbar-expand-lg navbar-banking sticky-top">
    <div class="container">
        <a class="navbar-brand text-white" href="index.jsp">
            <i class="fas fa-university me-2"></i>Auro Bank
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:if test="${not empty user}">
                    <c:choose>
                        <c:when test="${user.admin}">
                            <!-- Admin Navigation -->
                            <li class="nav-item">
                                <a class="nav-link text-white" href="AdminDashboardController">
                                    <i class="fas fa-chart-line me-1"></i>Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="AdminDashboardController#users">
                                    <i class="fas fa-users me-1"></i>Users
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="AdminDashboardController#accounts">
                                    <i class="fas fa-credit-card me-1"></i>Accounts
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <!-- Customer Navigation -->
                            <li class="nav-item">
                                <a class="nav-link text-white" href="DashboardController">
                                    <i class="fas fa-home me-1"></i>Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="DashboardController#accounts">
                                    <i class="fas fa-wallet me-1"></i>My Accounts
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </ul>
            
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty user}">
                        <!-- Logged in user -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-1"></i>${user.fullName}
                                <c:if test="${user.admin}">
                                    <span class="badge bg-danger ms-1">Admin</span>
                                </c:if>
                            </a>
                            <ul class="dropdown-menu">
                                <c:if test="${!user.admin}">
                                    <li><a class="dropdown-item" href="DashboardController">
                                        <i class="fas fa-home me-2"></i>Dashboard
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li><a class="dropdown-item text-danger" href="LogoutController">
                                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                                </a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- Not logged in -->
                        <li class="nav-item me-2">
                            <a href="login.jsp" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-sign-in-alt me-1"></i>Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="register.jsp" class="btn btn-banking-primary btn-sm">
                                <i class="fas fa-user-plus me-1"></i>Register
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

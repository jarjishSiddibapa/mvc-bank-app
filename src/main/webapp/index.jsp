<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Auro Bank - Modern Digital Banking</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<!-- Theme CSS - ONLY here, before header include -->
<link id="theme-style" rel="stylesheet" href="light.css">
<jsp:include page="common/header.jsp" />
</head>
<body>
<!-- Check if user is already logged in and redirect -->
<c:if test="${not empty user}">
<c:choose>
<c:when test="${user.admin}">
<c:redirect url="AdminDashboardController" />
</c:when>
<c:otherwise>
<c:redirect url="DashboardController" />
</c:otherwise>
</c:choose>
</c:if>

<!-- Logout message -->
<c:if test="${param.message == 'logged_out'}">
<div class="container mt-3">
<div class="alert alert-success alert-dismissible fade show">
<i class="fas fa-check-circle me-2"></i>You have been logged out successfully.
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
</div>
</c:if>

<!-- Hero Section -->
<section class="hero-section" style="background: linear-gradient(135deg, #1d3557 0%, #457b9d 100%); color: white; min-height: 85vh; display: flex; align-items: center;">
<div class="container">
<div class="row align-items-center">
<div class="col-lg-6">
<h1 class="display-4 fw-bold mb-4">Welcome to Modern Banking</h1>
<p class="lead mb-4">Experience seamless digital banking with Auro Bank. Fast, secure, and designed for your convenience.</p>
<div class="d-flex gap-3 flex-wrap">
<a href="login.jsp" class="btn btn-banking-primary btn-lg">
<i class="fas fa-sign-in-alt me-2"></i>Login
</a>
<a href="register.jsp" class="btn btn-outline-light btn-lg">
<i class="fas fa-user-plus me-2"></i>Register User
</a>
</div>
</div>
<div class="col-lg-6">
<div class="card card-banking bg-white text-dark p-4 mt-4">
<h3 class="text-banking-dark mb-4">Why Choose Auro Bank?</h3>
<div class="row">
<div class="col-6 mb-3">
<i class="fas fa-shield-alt text-banking-primary me-2"></i>
<span>Secure Banking</span>
</div>
<div class="col-6 mb-3">
<i class="fas fa-mobile-alt text-banking-primary me-2"></i>
<span>Mobile First</span>
</div>
<div class="col-6 mb-3">
<i class="fas fa-clock text-banking-primary me-2"></i>
<span>24/7 Service</span>
</div>
<div class="col-6 mb-3">
<i class="fas fa-chart-line text-banking-primary me-2"></i>
<span>Smart Analytics</span>
</div>
</div>
</div>
</div>
</div>
</div>
</section>

<!-- Features Section -->
<section class="py-5">
<div class="container">
<div class="row text-center mb-5">
<div class="col-12">
<h2 class="display-6 fw-bold text-banking-dark">Banking Made Simple</h2>
<p class="lead text-muted">Everything you need for your financial journey</p>
</div>
</div>
<div class="row g-4">
<div class="col-md-4">
<div class="card card-banking h-100 text-center p-4">
<div class="card-body">
<i class="fas fa-university fa-3x text-banking-primary mb-3"></i>
<h5 class="text-banking-dark">Multiple Account Types</h5>
<p class="text-muted">Savings and current accounts tailored to your needs</p>
</div>
</div>
</div>
<div class="col-md-4">
<div class="card card-banking h-100 text-center p-4">
<div class="card-body">
<i class="fas fa-exchange-alt fa-3x text-banking-secondary mb-3"></i>
<h5 class="text-banking-dark">Instant Transfers</h5>
<p class="text-muted">Send money instantly with our secure transfer system</p>
</div>
</div>
</div>
<div class="col-md-4">
<div class="card card-banking h-100 text-center p-4">
<div class="card-body">
<i class="fas fa-file-invoice fa-3x text-banking-primary mb-3"></i>
<h5 class="text-banking-dark">Digital Statements</h5>
<p class="text-muted">Access your transaction history anytime, anywhere</p>
</div>
</div>
</div>
</div>
</div>
</section>

<jsp:include page="common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

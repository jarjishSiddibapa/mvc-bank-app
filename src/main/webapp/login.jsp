<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Auro Bank</title>
    <link id="theme-style" rel="stylesheet" href="light.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <jsp:include page="common/header.jsp" />
</head>
<body>
    <div class="container-fluid">
        <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
            <div class="col-md-6 col-lg-4">
                <!-- Back Button -->
                <div class="mb-3">
                    <a href="index.jsp" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-arrow-left me-1"></i>Back to Home
                    </a>
                </div>
                
                <div class="card card-banking shadow-lg">
                    <div class="card-header bg-transparent text-center py-4">
                        <i class="fas fa-sign-in-alt fa-3x text-banking-primary mb-3"></i>
                        <h2 class="text-banking-dark mb-0">Welcome Back</h2>
                        <p class="text-muted mb-0">Sign in to your account</p>
                    </div>
                    <div class="card-body p-4">
                        <!-- Proper success/error banner -->
                        <c:if test="${not empty message}">
                            <div class="alert
                                ${message eq 'Account created! Please login.' ? 'alert-banking-success' : 'alert-banking-danger'}">
                                <i class="fas
                                    ${message eq 'Account created! Please login.' ? 'fa-check-circle' : 'fa-exclamation-triangle'}
                                me-2"></i>
                                ${message}
                            </div>
                        </c:if>
                        
                        <form action="LoginController" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label fw-semibold">
                                    <i class="fas fa-user me-1"></i>Username
                                </label>
                                <input type="text" class="form-control" name="username" id="username" required>
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label fw-semibold">
                                    <i class="fas fa-lock me-1"></i>Password
                                </label>
                                <input type="password" class="form-control" name="password" id="password" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-banking-primary btn-lg">
                                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer bg-transparent text-center">
                        <p class="mb-0">New to Auro Bank? 
                            <a href="register.jsp" class="text-banking-primary text-decoration-none fw-semibold">
                                Create Account
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Auro Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <jsp:include page="common/header.jsp" />
</head>
<body>
    <div class="container py-4">
        <!-- Back Button -->
        <div class="row">
            <div class="col-12 mb-3">
                <a href="index.jsp" class="btn btn-outline-secondary btn-sm">
                    <i class="fas fa-arrow-left me-1"></i>Back to Home
                </a>
            </div>
        </div>
        
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card card-banking shadow-lg">
                    <div class="card-header text-center py-4" style="background: linear-gradient(135deg, var(--secondary-color), var(--dark-color)); color: white;">
                        <i class="fas fa-user-plus fa-3x mb-3"></i>
                        <h2 class="mb-2">Join Auro Bank</h2>
                        <p class="mb-0">Create your user account in minutes</p>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${not empty message}">
                            <div class="alert alert-banking-danger">
                                <i class="fas fa-exclamation-triangle me-2"></i>${message}
                            </div>
                        </c:if>

                        <form action="RegisterController" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="username" class="form-label fw-semibold">
                                        <i class="fas fa-user me-1"></i>Username
                                    </label>
                                    <input type="text" name="username" id="username" class="form-control" 
                                           required maxlength="30" placeholder="Choose a unique username">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="password" class="form-label fw-semibold">
                                        <i class="fas fa-lock me-1"></i>Password
                                    </label>
                                    <input type="password" name="password" id="password" class="form-control" 
                                           required maxlength="50" placeholder="Create a strong password">
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="fullName" class="form-label fw-semibold">
                                        <i class="fas fa-id-card me-1"></i>Full Name
                                    </label>
                                    <input type="text" name="fullName" id="fullName" class="form-control" 
                                           required maxlength="100" placeholder="Enter your full legal name">
                                </div>
                                <div class="col-md-7 mb-3">
                                    <label for="email" class="form-label fw-semibold">
                                        <i class="fas fa-envelope me-1"></i>Email Address
                                    </label>
                                    <input type="email" name="email" id="email" class="form-control" 
                                           required maxlength="100" placeholder="your@email.com">
                                </div>
                                <div class="col-md-5 mb-3">
                                    <label for="phone" class="form-label fw-semibold">
                                        <i class="fas fa-phone me-1"></i>Phone Number
                                    </label>
                                    <input type="text" name="phone" id="phone" class="form-control" 
                                           required maxlength="15" placeholder="+91 9876543210">
                                </div>
                            </div>

                            <div class="mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="terms" required>
                                    <label class="form-check-label" for="terms">
                                        I agree to the <a href="#" class="text-banking-primary">Terms and Conditions</a>
                                    </label>
                                </div>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-banking-primary btn-lg">
                                    <i class="fas fa-user-plus me-2"></i>Create My Account
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer bg-transparent text-center">
                        <p class="mb-0">Already have an account? 
                            <a href="login.jsp" class="text-banking-primary text-decoration-none fw-semibold">
                                Sign In Here
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

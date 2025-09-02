<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Profile - Auro Bank</title>
<link id="theme-style" rel="stylesheet" href="light.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<jsp:include page="common/header.jsp" />
</head>
<body>
<div class="container py-4">
    <!-- Back Button -->
    <div class="row mb-3">
        <div class="col-12">
            <a href="DashboardController" class="btn btn-outline-secondary btn-sm">
                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
            </a>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card card-banking shadow-lg">
                <div class="card-header text-center py-4" style="background: linear-gradient(135deg, var(--secondary-color), var(--dark-color)); color: white;">
                    <i class="fas fa-user-edit fa-3x mb-3"></i>
                    <h2 class="mb-0">Edit My Profile</h2>
                    <p class="mb-0">Update your basic information</p>
                </div>
                <div class="card-body p-4">
                    <!-- Success/Error Messages -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-banking-danger">
                            <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty infoMessage}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>${infoMessage}
                        </div>
                    </c:if>

                    <form action="EditProfileController" method="post" id="profileForm">
                        <!-- Read-only fields (sensitive info) -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-muted">
                                    <i class="fas fa-user me-1"></i>Username
                                </label>
                                <input type="text" class="form-control" value="${user.username}" disabled>
                                <div class="form-text">Username cannot be changed</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-muted">
                                    <i class="fas fa-calendar me-1"></i>Member Since
                                </label>
                                <input type="text" class="form-control" value="${user.createdAt}" disabled>
                                <div class="form-text">Account creation date</div>
                            </div>
                        </div>

                        <hr class="my-4">
                        <h5 class="text-banking-dark mb-3">
                            <i class="fas fa-edit me-2"></i>Editable Information
                        </h5>

                        <!-- Editable fields -->
                        <div class="mb-3">
                            <label for="fullName" class="form-label fw-semibold">
                                <i class="fas fa-id-card me-1"></i>Full Name
                            </label>
                            <input type="text" id="fullName" name="fullName" 
                                   value="${user.fullName}" class="form-control" 
                                   required maxlength="100" placeholder="Enter your full name">
                            <div class="form-text">Your full legal name</div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">
                                <i class="fas fa-envelope me-1"></i>Email Address
                            </label>
                            <input type="email" id="email" name="email" 
                                   value="${user.email}" class="form-control" 
                                   required maxlength="100" placeholder="your@email.com">
                            <div class="form-text">We'll use this for important notifications</div>
                        </div>

                        <div class="mb-4">
                            <label for="phone" class="form-label fw-semibold">
                                <i class="fas fa-phone me-1"></i>Phone Number
                            </label>
                            <input type="text" id="phone" name="phone" 
                                   value="${user.phone}" class="form-control" 
                                   required maxlength="15" placeholder="+91 9876543210">
                            <div class="form-text">Include country code if international</div>
                        </div>

                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Note:</strong> For security reasons, username and account creation date cannot be modified. 
                            To change your password, please contact customer support.
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-banking-primary btn-lg">
                                <i class="fas fa-save me-2"></i>Save Changes
                            </button>
                        </div>
                    </form>
                </div>
                <div class="card-footer bg-transparent text-center">
                    <small class="text-muted">
                        <i class="fas fa-shield-alt me-1"></i>
                        Your information is encrypted and secure
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Form validation
document.getElementById('profileForm').addEventListener('submit', function(e) {
    const fullName = document.getElementById('fullName').value.trim();
    const email = document.getElementById('email').value.trim();
    const phone = document.getElementById('phone').value.trim();
    
    if (!fullName || !email || !phone) {
        e.preventDefault();
        alert('Please fill in all required fields.');
        return;
    }
    
    // Basic email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        e.preventDefault();
        alert('Please enter a valid email address.');
        return;
    }
    
    // Basic phone validation (numbers, +, spaces, hyphens)
    const phoneRegex = /^[\d\s\-\+\(\)]+$/;
    if (!phoneRegex.test(phone)) {
        e.preventDefault();
        alert('Please enter a valid phone number.');
        return;
    }
});
</script>
</body>
</html>

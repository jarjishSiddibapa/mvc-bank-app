<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Error - Auro Bank</title>
    <link id="theme-style" rel="stylesheet" href="light.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <jsp:include page="common/header.jsp" />
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card card-banking text-center shadow-lg">
                    <div class="card-body py-5">
                        <i class="fas fa-exclamation-triangle fa-4x text-warning mb-4"></i>
                        <h3 class="text-banking-dark mb-3">Oops! Something went wrong</h3>
                        <p class="text-muted mb-4">
                            It looks like there was an issue with your login attempt. 
                            Please try again or contact support if the problem persists.
                        </p>
                        <div class="d-grid gap-2">
                            <a href="login.jsp" class="btn btn-banking-primary">
                                <i class="fas fa-arrow-left me-2"></i>Try Login Again
                            </a>
                            <a href="index.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-home me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="common/footer.jsp" />
</body>
</html>

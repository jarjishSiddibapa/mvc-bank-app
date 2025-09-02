<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Privacy Policy - Auro Bank</title>
    <link id="theme-style" rel="stylesheet" href="light.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <jsp:include page="common/header.jsp" />
</head>
<body>
    <div class="container my-5">
        <div class="card card-banking shadow-lg">
            <div class="card-body px-5 py-4">
                <h2 class="text-banking-primary text-center fw-bold mb-3">
                    <i class="fas fa-user-shield me-1"></i>Privacy Policy
                </h2>
                <p class="mb-4 text-center">
                    At <strong>Auro Bank</strong>, your privacy is our top priority (right after fresh samosas in meetings).
                </p>
                <ul class="list-unstyled fs-5">
                    <li class="mb-3">
                        <i class="fas fa-lock text-success me-2"></i>
                        We encrypt everything—even our jokes (okay, maybe just your data).
                    </li>
                    <li class="mb-3">
                        <i class="fas fa-hand-point-right text-banking-secondary me-2"></i>
                        We never sell your data, not even for the world’s best pav bhaji.
                    </li>
                    <li class="mb-3">
                        <i class="fas fa-bug text-danger me-2"></i>
                        If you find a bug, we’ll fix it faster than you can say “compound interest”!
                    </li>
                </ul>
                <hr>
                <p class="fs-6">
                    <em>
                        We collect only the bare minimum to help you bank smoothly—no stalking, no spam, and absolutely no “are you still there?” popups.<br>
                        Thank you for trusting us with your precious coins and occasional dad jokes. <br>
                        Happy banking!
                    </em>
                </p>
                <div class="text-center mt-4">
                    <a href="index.jsp" class="btn btn-banking-secondary"><i class="fas fa-arrow-left me-1"></i>Back to Home</a>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="common/footer.jsp" />
</body>
</html>

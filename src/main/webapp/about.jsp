<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us - Auro Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <jsp:include page="common/header.jsp" />
</head>
<body>
    <div class="container my-5">
        <div class="card card-banking shadow-lg">
            <div class="card-body text-center py-5">
                <h2 class="text-banking-primary fw-bold mb-3"><i class="fas fa-heart me-1"></i>About Us</h2>
                <p class="lead mb-4">
                    Welcome to <strong>Auro Bank</strong>, your trusted partner in finance and a big fan of stress-free banking!
                </p>
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmhhpAZ2rpSu2k4FoOTpxBhjKu9GKz_exwvA&s" alt="Piggy Bank" style="width:700px;">
                <p class="mt-4 fs-5">
                    We started in a small Mumbai street corner in 2025, fueled by dreams, good chai, and the belief that <strong>banking should feel like a warm hug 🚀☕️.</strong>
                </p>
                <ul class="list-unstyled text-start mx-auto" style="max-width:480px;">
                    <li><i class="fas fa-check-circle text-success me-2"></i>Zero queue frustration</li>
                    <li><i class="fas fa-check-circle text-success me-2"></i>Account numbers longer than monsoon chats</li>
                    <li><i class="fas fa-check-circle text-success me-2"></i>Customer service so friendly they'd lend you a pen <em>(not just a form)</em></li>
                </ul>
                <p class="mt-4">
                    Whether you’re saving for your dream, paying rent, or just checking if you can finally order that extra cheese burst, <strong>we’ve got you covered</strong>.<br>
                    Thank you for being part of our journey. Your money is safe, your jokes are welcome, and your chai is (probably) on us!
                </p>
            </div>
        </div>
        <div class="text-center my-4">
            <a href="index.jsp" class="btn btn-banking-secondary"><i class="fas fa-arrow-left me-1"></i>Back to Home</a>
        </div>
    </div>
    <jsp:include page="common/footer.jsp" />
</body>
</html>

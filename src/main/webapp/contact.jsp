<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact - Auro Bank</title>
    <link id="theme-style" rel="stylesheet" href="light.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <jsp:include page="common/header.jsp" />
</head>
<body>
    <div class="container my-5">
        <div class="card card-banking shadow-lg">
            <div class="card-body text-center py-5">
                <h2 class="text-banking-primary fw-bold mb-3"><i class="fas fa-envelope-open-text me-1"></i>Contact Us</h2>
                <p class="fs-5 mb-4">Have a question, a suggestion, or want to tell us your favorite banking joke?</p>
                <p>
                  <i class="fas fa-phone text-banking-primary"></i> <strong>1800-AURO-BANK</strong> (call us anytime, we love a good chat!)<br>
                  <i class="fas fa-envelope text-banking-secondary"></i> <strong>support@aurobank.com</strong>
                </p>
                <p class="mt-4">
                  Our offices are open from <strong>9am - 6pm IST</strong>. <br>
                  Our email support never sleeps (it’s powered by coffee ☕ and friendship).
                </p>
                <hr class="my-4">
                <h5>Fancy Online Contact Form?</h5>
                <form>
                    <div class="mb-3">
                        <input type="text" class="form-control" placeholder="Your Name (or superhero alias)">
                    </div>
                    <div class="mb-3">
                        <input type="email" class="form-control" placeholder="you@email.com">
                    </div>
                    <div class="mb-3">
                        <textarea class="form-control" rows="4" placeholder="Your message (feel free to add emojis 😊)"></textarea>
                    </div>
                    <button type="button" class="btn btn-banking-primary" disabled>
                        <i class="fas fa-paper-plane"></i> Send (Actually, this is a dummy form)
                    </button>
                    <div class="form-text mt-2">We promise to pretend your message was heart-warming 🐱‍🏍</div>
                </form>
            </div>
        </div>
        <div class="text-center my-4">
            <a href="index.jsp" class="btn btn-banking-secondary"><i class="fas fa-arrow-left me-1"></i>Back to Home</a>
        </div>
    </div>
    <jsp:include page="common/footer.jsp" />
</body>
</html>

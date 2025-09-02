<% 
    if (session.getAttribute("user") == null || request.getAttribute("accounts") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Money - Auro Bank</title>
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
            <div class="col-lg-8">
                <div class="card card-banking shadow-lg">
                    <div class="card-header text-center py-4" style="background: linear-gradient(135deg, var(--primary-color), #c62d38); color: white;">
                        <i class="fas fa-exchange-alt fa-3x mb-3"></i>
                        <h2 class="mb-0">Transfer Money</h2>
                        <p class="mb-0">Send money to any account instantly</p>
                    </div>
                    <div class="card-body p-4">
                        <form action="TransferInitiateController" method="post" id="transferForm">
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-wallet me-1"></i>From Account
                                    </label>
                                    <select name="senderAccountId" class="form-select" required id="fromAccount">
                                        <option value="">Select your account...</option>
                                        <c:forEach var="account" items="${accounts}">
                                            <c:if test="${account.status == 'active'}">
                                                <option value="${account.accountId}" data-balance="${account.balance != null ? account.balance : 0}">
                                                    ${account.accountNumber} (${account.accountType}) - ₹${account.balance}
                                                </option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <div class="form-text">Only active accounts are shown</div>
                                </div>

                                <div class="col-md-6 mb-4">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-user me-1"></i>To Account Number
                                    </label>
                                    <input type="text" name="receiverAccountNumber" class="form-control" 
                                           placeholder="Enter recipient account number" required>
                                    <div class="form-text">Enter the full account number</div>
                                </div>

                                <div class="col-md-6 mb-4">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-rupee-sign me-1"></i>Amount
                                    </label>
                                    <input type="number" step="0.01" name="amount" class="form-control" 
                                           placeholder="0.00" required min="0.01" id="amount">
                                    <div class="form-text" id="balanceInfo">Select an account to see available balance</div>
                                </div>

                                <div class="col-md-6 mb-4 d-flex align-items-end">
                                    <button type="submit" class="btn btn-banking-primary btn-lg w-100">
                                        <i class="fas fa-arrow-right me-2"></i>Continue Transfer
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Transfer Tips -->
                <div class="card card-banking mt-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-lightbulb me-2"></i>Transfer Tips</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success me-2"></i>Transfers are processed instantly</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Verify recipient details carefully</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Keep transaction reference for records</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-shield-alt text-primary me-2"></i>All transfers are secured with encryption</li>
                                    <li><i class="fas fa-clock text-info me-2"></i>Available 24/7</li>
                                    <li><i class="fas fa-mobile-alt text-secondary me-2"></i>Mobile-optimized interface</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateBalanceInfo() {
            const select = document.getElementById('fromAccount');
            const balanceInfo = document.getElementById('balanceInfo');
            const amountInput = document.getElementById('amount');
            
            if (select.selectedIndex === 0) {
                // No account selected
                balanceInfo.innerHTML = 'Select an account to see available balance';
                balanceInfo.className = 'form-text text-muted';
                amountInput.removeAttribute('max');
                return;
            }
            
            let balance = select.options[select.selectedIndex].dataset.balance;
            if (!balance || balance === '') balance = '0';
            
            balanceInfo.innerHTML = `Available balance: ₹${balance}`;
            balanceInfo.className = 'form-text text-success';
            amountInput.max = balance;
        }
        
        // Attach event listener and run on page load
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('fromAccount').addEventListener('change', updateBalanceInfo);
            updateBalanceInfo(); // Run initially
        });
    </script>
</body>
</html>

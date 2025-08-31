<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Transfer - Auro Bank</title>
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
                <a href="transfer.jsp" class="btn btn-outline-secondary btn-sm">
                    <i class="fas fa-arrow-left me-1"></i>Back to Transfer
                </a>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card card-banking shadow-lg">
                    <div class="card-header text-center py-4" style="background: linear-gradient(135deg, var(--success-color), #146c43); color: white;">
                        <i class="fas fa-check-circle fa-3x mb-3"></i>
                        <h2 class="mb-0">Confirm Transfer</h2>
                        <p class="mb-0">Please review the transfer details carefully</p>
                    </div>
                    <div class="card-body p-4">
                        <!-- Error Messages -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-banking-danger">
                                <i class="fas fa-exclamation-triangle me-2"></i>${message}
                            </div>
                        </c:if>

                        <!-- Transfer Success Flow -->
                        <c:if test="${receiverAccount != null && empty message}">
                            <!-- Transfer Amount Display -->
                            <div class="text-center mb-4">
                                <div class="card bg-light border-0">
                                    <div class="card-body py-4">
                                        <h1 class="display-4 text-banking-primary fw-bold mb-2">₹${amount}</h1>
                                        <p class="text-muted mb-3">Transfer Amount</p>
                                        <div class="d-flex justify-content-center align-items-center">
                                            <span class="badge bg-primary me-2">${senderAccount.accountNumber}</span>
                                            <i class="fas fa-arrow-right text-banking-secondary mx-3 fa-2x"></i>
                                            <span class="badge bg-primary ms-2">${receiverAccount.accountNumber}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Account Details Comparison -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="card h-100 border-start border-danger border-4">
                                        <div class="card-header bg-light">
                                            <h5 class="mb-0 text-danger">
                                                <i class="fas fa-arrow-up me-2"></i>From Account
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <table class="table table-sm table-borderless">
                                                <tr>
                                                    <td><strong>Account:</strong></td>
                                                    <td><span class="badge bg-secondary">${senderAccount.accountNumber}</span></td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Type:</strong></td>
                                                    <td>
                                                        <span class="badge ${senderAccount.accountType == 'savings' ? 'bg-success' : 'bg-info'}">
                                                            <i class="fas ${senderAccount.accountType == 'savings' ? 'fa-piggy-bank' : 'fa-briefcase'} me-1"></i>
                                                            ${senderAccount.accountType}
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Status:</strong></td>
                                                    <td><span class="badge bg-success">${senderAccount.status}</span></td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Balance After:</strong></td>
                                                    <td class="text-warning fw-bold">₹${senderAccount.balance - amount}</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card h-100 border-start border-success border-4">
                                        <div class="card-header bg-light">
                                            <h5 class="mb-0 text-success">
                                                <i class="fas fa-arrow-down me-2"></i>To Account
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <table class="table table-sm table-borderless">
                                                <tr>
                                                    <td><strong>Account:</strong></td>
                                                    <td><span class="badge bg-secondary">${receiverAccount.accountNumber}</span></td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Type:</strong></td>
                                                    <td>
                                                        <span class="badge ${receiverAccount.accountType == 'savings' ? 'bg-success' : 'bg-info'}">
                                                            <i class="fas ${receiverAccount.accountType == 'savings' ? 'fa-piggy-bank' : 'fa-briefcase'} me-1"></i>
                                                            ${receiverAccount.accountType}
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Status:</strong></td>
                                                    <td><span class="badge bg-success">${receiverAccount.status}</span></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Recipient Information -->
                            <c:if test="${recipientUser != null}">
                                <div class="card bg-light border-0 mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">
                                            <i class="fas fa-user-circle me-2"></i>Recipient Information
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <i class="fas fa-user me-2 text-primary"></i>
                                                <strong>Name:</strong> ${recipientUser.fullName}
                                            </div>
                                            <div class="col-md-4">
                                                <i class="fas fa-envelope me-2 text-primary"></i>
                                                <strong>Email:</strong> ${recipientUser.email}
                                            </div>
                                            <div class="col-md-4">
                                                <i class="fas fa-phone me-2 text-primary"></i>
                                                <strong>Phone:</strong> ${recipientUser.phone}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Transfer Form -->
                            <form action="TransferCompleteController" method="post" id="confirmForm">
                                <input type="hidden" name="senderAccountId" value="${senderAccount.accountId}">
                                <input type="hidden" name="receiverAccountId" value="${receiverAccount.accountId}">
                                <input type="hidden" name="amount" value="${amount}">
                                
                                <div class="mb-4">
                                    <label for="description" class="form-label fw-semibold">
                                        <i class="fas fa-comment me-1"></i>Transaction Notes (Optional)
                                    </label>
                                    <textarea name="description" id="description" class="form-control" rows="3" 
                                              placeholder="Add a note for this transfer..." maxlength="255"></textarea>
                                    <div class="form-text">
                                        <span id="charCount">0</span>/255 characters
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <button type="submit" class="btn btn-banking-primary btn-lg w-100" id="confirmBtn">
                                            <i class="fas fa-check me-2"></i>Confirm Transfer
                                        </button>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <a href="DashboardController" class="btn btn-outline-secondary btn-lg w-100">
                                            <i class="fas fa-times me-2"></i>Cancel
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </c:if>

                        <!-- Error State -->
                        <c:if test="${receiverAccount == null}">
                            <div class="text-center py-5">
                                <i class="fas fa-exclamation-triangle fa-4x text-danger mb-3"></i>
                                <h4>Transfer Failed</h4>
                                <p class="text-muted">Unable to process transfer. Please try again.</p>
                                <div class="btn-group">
                                    <a href="transfer.jsp" class="btn btn-banking-primary">Try Again</a>
                                    <a href="DashboardController" class="btn btn-outline-secondary">Back to Dashboard</a>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const description = document.getElementById('description');
            const charCount = document.getElementById('charCount');
            const confirmBtn = document.getElementById('confirmBtn');
            
            if (description) {
                description.addEventListener('input', function() {
                    charCount.textContent = this.value.length;
                });
            }

            // Add confirmation dialog
            document.getElementById('confirmForm')?.addEventListener('submit', function(e) {
                if (!confirm('Are you sure you want to proceed with this transfer? This action cannot be undone.')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>

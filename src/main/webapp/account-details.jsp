<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${account == null}">
  <div class="container py-4">
      <div class="alert alert-danger mt-5">
          Account details could not be loaded. <a href="DashboardController">Back to Dashboard</a>
      </div>
  </div>
</c:if>
<c:if test="${account != null}">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Details - Auro Bank</title>
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
        <!-- Account Header -->
        <div class="card card-banking mb-4 shadow-lg">
            <div class="card-body" style="background: linear-gradient(135deg, var(--secondary-color), var(--dark-color)); color: white;">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <i class="fas ${account.accountType == 'savings' ? 'fa-piggy-bank' : 'fa-briefcase'} fa-3x mb-3"></i>
                        <h2 class="fw-bold mb-2">Account Details</h2>
                        <h4 class="mb-1">${account.accountNumber}</h4>
                        <p class="mb-0">
                            <span class="badge bg-light text-dark me-2">${account.accountType} Account</span>
                            <span class="badge ${account.status == 'active' ? 'bg-success' : 'bg-warning'}">${account.status}</span>
                        </p>
                    </div>
                    <div class="col-md-4 text-end">
                        <div class="bg-white text-dark rounded p-3">
                            <h6 class="mb-1">Current Balance</h6>
                            <h2 class="text-banking-primary fw-bold mb-0">₹${account.balance}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Alert Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-banking-success alert-dismissible fade show">
                <i class="fas fa-check-circle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <!-- Account Information & Actions -->
        <div class="row">
            <div class="col-md-8">
                <div class="card card-banking mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Account Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Account Number:</strong></td>
                                        <td><span class="badge bg-secondary">${account.accountNumber}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Account Type:</strong></td>
                                        <td>
                                            <span class="badge ${account.accountType == 'savings' ? 'bg-success' : 'bg-info'}">
                                                <i class="fas ${account.accountType == 'savings' ? 'fa-piggy-bank' : 'fa-briefcase'} me-1"></i>
                                                ${account.accountType}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Status:</strong></td>
                                        <td>
                                            <span class="badge ${account.status == 'active' ? 'bg-success' : account.status == 'pending' ? 'bg-warning' : 'bg-danger'}">
                                                ${account.status}
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Current Balance:</strong></td>
                                        <td class="text-banking-primary fw-bold fs-5">₹${account.balance}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Account Created:</strong></td>
                                        <td class="text-muted">${account.createdAt}</td>
                                    </tr>
                                    <c:if test="${account.approvedAt != null}">
                                        <tr>
                                            <td><strong>Account Approved:</strong></td>
                                            <td class="text-muted">${account.approvedAt}</td>
                                        </tr>
                                    </c:if>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-banking">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <c:if test="${account.status == 'active'}">
                                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#depositModal">
                                    <i class="fas fa-plus-circle me-2"></i>Deposit Money
                                </button>
                                <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#withdrawModal">
                                    <i class="fas fa-minus-circle me-2"></i>Withdraw Money
                                </button>
                                <a href="PassbookController?accountId=${account.accountId}" class="btn btn-banking-secondary">
                                    <i class="fas fa-file-invoice me-2"></i>View Statement
                                </a>
                            </c:if>
                            <c:if test="${account.status != 'active'}">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Account is ${account.status}. Actions are limited.
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Deposit Modal -->
    <div class="modal fade" id="depositModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-plus-circle me-2"></i>Deposit Money
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="DepositWithdrawController" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="accountId" value="${account.accountId}">
                        <input type="hidden" name="action" value="deposit">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Deposit Amount</label>
                            <div class="input-group">
                                <span class="input-group-text">₹</span>
                                <input type="number" step="0.01" name="amount" class="form-control" placeholder="0.00" required min="0.01">
                            </div>
                        </div>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Amount will be credited to your account immediately.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-plus-circle me-1"></i>Deposit
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Withdraw Modal -->
    <div class="modal fade" id="withdrawModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-minus-circle me-2"></i>Withdraw Money
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="DepositWithdrawController" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="accountId" value="${account.accountId}">
                        <input type="hidden" name="action" value="withdraw">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Withdraw Amount</label>
                            <div class="input-group">
                                <span class="input-group-text">₹</span>
                                <input type="number" step="0.01" name="amount" class="form-control" placeholder="0.00" required min="0.01" max="${account.balance}">
                            </div>
                            <div class="form-text">Available balance: ₹${account.balance}</div>
                        </div>
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            Ensure you have sufficient balance before withdrawal.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-warning">
                            <i class="fas fa-minus-circle me-1"></i>Withdraw
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
</c:if>

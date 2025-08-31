<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Statement - Auro Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css"/>
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

        <!-- Account Statement Header -->
        <div class="card card-banking mb-4 shadow-lg">
            <div class="card-body" style="background: linear-gradient(135deg, var(--secondary-color), var(--dark-color)); color: white;">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <i class="fas fa-file-invoice fa-3x mb-3"></i>
                        <h2 class="fw-bold mb-2">Account Statement</h2>
                        <h4 class="mb-1">${account.accountNumber} 
                            <span class="badge bg-light text-dark ms-2">
                                <i class="fas ${account.accountType == 'savings' ? 'fa-piggy-bank' : 'fa-briefcase'} me-1"></i>
                                ${account.accountType == 'savings' ? 'Savings' : 'Current'}
                            </span>
                        </h4>
                        <p class="mb-0">Status: <span class="badge bg-success">${account.status}</span></p>
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

        <!-- Account Summary -->
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="card card-banking h-100">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Account Information</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-6 mb-2">
                                <strong>Account Number:</strong><br>
                                <span class="badge bg-secondary">${account.accountNumber}</span>
                            </div>
                            <div class="col-6 mb-2">
                                <strong>Account Type:</strong><br>
                                <span class="badge ${account.accountType == 'savings' ? 'bg-success' : 'bg-info'}">
                                    <i class="fas ${account.accountType == 'savings' ? 'fa-piggy-bank' : 'fa-briefcase'} me-1"></i>
                                    ${account.accountType}
                                </span>
                            </div>
                            <div class="col-6 mb-2">
                                <strong>Status:</strong><br>
                                <span class="badge bg-success">${account.status}</span>
                            </div>
                            <div class="col-6 mb-2">
                                <strong>Created:</strong><br>
                                <small class="text-muted">${account.createdAt}</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-banking h-100">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Quick Stats</h5>
                    </div>
                    <div class="card-body text-center">
                        <div class="row">
                            <div class="col-12 mb-3">
                                <h4 class="text-banking-primary fw-bold">${transactions.size()}</h4>
                                <small class="text-muted">Total Transactions</small>
                            </div>
                            <div class="col-12">
                                <h4 class="text-banking-secondary fw-bold">₹${account.balance}</h4>
                                <small class="text-muted">Available Balance</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Transaction History -->
        <div class="card card-banking">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h4 class="mb-0">
                    <i class="fas fa-history me-2"></i>Transaction History
                </h4>
                <div class="btn-group">
                    <button class="btn btn-banking-secondary btn-sm" onclick="window.print()">
                        <i class="fas fa-print me-1"></i>Print
                    </button>
                    <button class="btn btn-banking-primary btn-sm" disabled>
                        <i class="fas fa-download me-1"></i>Download PDF
                    </button>
                </div>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty transactions}">
                        <div class="table-responsive">
                            <table id="transactionTable" class="table table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Date & Time</th>
                                        <th>Type</th>
                                        <th>Description</th>
                                        <th>Amount</th>
                                        <th>From Account</th>
                                        <th>To Account</th>
                                        <th>Balance Impact</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="txn" items="${transactions}">
                                        <tr>
                                            <td class="fw-semibold small">${txn.transactionDate}</td>
                                            <td>
                                                <span class="badge ${txn.type == 'transfer' ? 'bg-info' : txn.type == 'deposit' ? 'bg-success' : 'bg-warning'}">
                                                    <i class="fas ${txn.type == 'transfer' ? 'fa-exchange-alt' : txn.type == 'deposit' ? 'fa-arrow-down' : 'fa-arrow-up'} me-1"></i>
                                                    ${txn.type}
                                                </span>
                                            </td>
                                            <td class="text-truncate" style="max-width: 200px;" title="${txn.description}">
                                                ${txn.description != null ? txn.description : 'No description'}
                                            </td>
                                            <td class="fw-bold">₹${txn.amount}</td>
                                            <td>
                                                <c:if test="${not empty accountNumberMap[txn.senderAccountId]}">
                                                    <span class="badge bg-secondary small">
                                                        <c:out value="${accountNumberMap[txn.senderAccountId]}" />
                                                    </span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${not empty accountNumberMap[txn.receiverAccountId]}">
                                                    <span class="badge bg-secondary small">
                                                        <c:out value="${accountNumberMap[txn.receiverAccountId]}" />
                                                    </span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <span class="fw-bold ${txn.senderAccountId == account.accountId ? 'text-danger' : 'text-success'}">
                                                    <i class="fas ${txn.senderAccountId == account.accountId ? 'fa-minus' : 'fa-plus'} me-1"></i>
                                                    ${txn.senderAccountId == account.accountId ? '-' : '+'}₹${txn.amount}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-file-invoice fa-4x text-muted mb-3"></i>
                            <h4>No transactions found</h4>
                            <p class="text-muted">This account hasn't made any transactions yet.</p>
                            <a href="transfer.jsp" class="btn btn-banking-primary">
                                <i class="fas fa-plus me-1"></i>Make Your First Transaction
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <jsp:include page="common/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#transactionTable').DataTable({
                responsive: true,
                pageLength: 15,
                order: [[0, 'desc']],
                language: {
                    search: "Search transactions:",
                    emptyTable: "No transactions available"
                }
            });
        });
    </script>
</body>
</html>

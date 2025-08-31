<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Auro Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css"/>
    <jsp:include page="common/header.jsp" />
</head>
<body>
    <div class="container-fluid py-4">
        <!-- Admin Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card card-banking border-0" style="background: linear-gradient(135deg, var(--primary-color), #c62d38); color: white;">
                    <div class="card-body text-center py-4">
                        <i class="fas fa-shield-alt fa-3x mb-3"></i>
                        <h1 class="display-6 fw-bold mb-2">Admin Control Center</h1>
                        <p class="lead mb-0">Manage users, accounts & monitor all transactions</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="card card-banking text-center h-100">
                    <div class="card-body">
                        <i class="fas fa-users fa-3x text-banking-primary mb-3"></i>
                        <h3 class="fw-bold">${users.size()}</h3>
                        <p class="text-muted mb-0">Total Users</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="card card-banking text-center h-100">
                    <div class="card-body">
                        <i class="fas fa-clock fa-3x text-warning mb-3"></i>
                        <h3 class="fw-bold">${pendingAccounts.size()}</h3>
                        <p class="text-muted mb-0">Pending Requests</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="card card-banking text-center h-100">
                    <div class="card-body">
                        <i class="fas fa-credit-card fa-3x text-banking-secondary mb-3"></i>
                        <h3 class="fw-bold">${allAccounts.size()}</h3>
                        <p class="text-muted mb-0">Total Accounts</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="card card-banking text-center h-100">
                    <div class="card-body">
                        <i class="fas fa-exchange-alt fa-3x text-success mb-3"></i>
                        <h3 class="fw-bold">${transactions.size()}</h3>
                        <p class="text-muted mb-0">Total Transactions</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Users Management -->
        <div class="card card-banking mb-4" id="users">
            <div class="card-header">
                <h4 class="text-banking-dark mb-0">
                    <i class="fas fa-users me-2"></i>Users Management
                </h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="usersTable" class="table table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Joined</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td><span class="badge bg-secondary">${user.username}</span></td>
                                    <td class="fw-semibold">${user.fullName}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>
                                        <span class="badge ${user.admin ? 'bg-danger' : 'bg-success'}">
                                            <i class="fas ${user.admin ? 'fa-shield-alt' : 'fa-user'} me-1"></i>
                                            ${user.admin ? 'Admin' : 'Customer'}
                                        </span>
                                    </td>
                                    <td class="text-muted small">${user.createdAt}</td>
                                    <td>
                                        <c:if test="${!user.admin}">
                                            <form action="DeleteUserController" method="post" style="display:inline;" 
                                                  onsubmit="return confirm('Delete user ${user.fullName}?')">
                                                <input type="hidden" name="userId" value="${user.userId}">
                                                <button type="submit" class="btn btn-outline-danger btn-sm">
                                                    <i class="fas fa-trash"></i> Remove
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Account Approval Requests -->
        <div class="card card-banking mb-4" id="accounts">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h4 class="text-banking-dark mb-0">
                    <i class="fas fa-clock me-2"></i>Account Approval Requests
                </h4>
                <span class="badge bg-warning">${pendingAccounts.size()} Pending</span>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty pendingAccounts}">
                        <div class="table-responsive">
                            <table id="pendingAccountsTable" class="table table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Account Number</th>
                                        <th>User</th>
                                        <th>Type</th>
                                        <th>Applied On</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="account" items="${pendingAccounts}">
                                        <tr>
                                            <td><span class="badge bg-secondary">${account.accountNumber}</span></td>
                                            <td>
                                                <div>
                                                    <strong>User ID: ${account.userId}</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge ${account.accountType == 'savings' ? 'bg-success' : 'bg-info'}">
                                                    <i class="fas ${account.accountType == 'savings' ? 'fa-piggy-bank' : 'fa-briefcase'} me-1"></i>
                                                    ${account.accountType}
                                                </span>
                                            </td>
                                            <td class="text-muted small">${account.createdAt}</td>
                                            <td>
                                                <div class="btn-group btn-group-sm">
                                                    <form action="ApproveAccountController" method="post" style="display:inline;">
                                                        <input type="hidden" name="accountId" value="${account.accountId}">
                                                        <input type="hidden" name="status" value="active">
                                                        <button type="submit" class="btn btn-success btn-sm">
                                                            <i class="fas fa-check"></i> Approve
                                                        </button>
                                                    </form>
                                                    <form action="ApproveAccountController" method="post" style="display:inline;">
                                                        <input type="hidden" name="accountId" value="${account.accountId}">
                                                        <input type="hidden" name="status" value="rejected">
                                                        <button type="submit" class="btn btn-danger btn-sm" 
                                                                onclick="return confirm('Reject this account request?')">
                                                            <i class="fas fa-times"></i> Reject
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-check-circle fa-4x text-success mb-3"></i>
                            <h5>No pending requests</h5>
                            <p class="text-muted">All account requests have been processed</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- All Transactions -->
        <div class="card card-banking">
            <div class="card-header">
                <h4 class="text-banking-dark mb-0">
                    <i class="fas fa-exchange-alt me-2"></i>Recent Transactions
                </h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="transactionsTable" class="table table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>From Account</th>
                                <th>To Account</th>
                                <th>Amount</th>
                                <th>Type</th>
                                <th>Description</th>
                                <th>Date & Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="t" items="${transactions}">
                                <tr>
                                    <td><span class="badge bg-dark">#${t.transactionId}</span></td>
                                    <td>
                                        <span class="badge bg-secondary">
                                            <c:out value="${accountNumberMap[t.senderAccountId]}" />
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">
                                            <c:out value="${accountNumberMap[t.receiverAccountId]}" />
                                        </span>
                                    </td>
                                    <td class="fw-bold text-banking-primary">₹${t.amount}</td>
                                    <td>
                                        <span class="badge ${t.type == 'transfer' ? 'bg-info' : t.type == 'deposit' ? 'bg-success' : 'bg-warning'}">
                                            <i class="fas ${t.type == 'transfer' ? 'fa-exchange-alt' : t.type == 'deposit' ? 'fa-arrow-down' : 'fa-arrow-up'} me-1"></i>
                                            ${t.type}
                                        </span>
                                    </td>
                                    <td class="text-truncate" style="max-width: 150px;" title="${t.description}">
                                        ${t.description}
                                    </td>
                                    <td class="text-muted small">${t.transactionDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
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
            $('#usersTable').DataTable({
                responsive: true,
                pageLength: 10,
                language: { search: "Search users:" },
                columnDefs: [
                    { orderable: false, targets: [6] }
                ]
            });
            
            $('#pendingAccountsTable').DataTable({
                responsive: true,
                pageLength: 10,
                language: { search: "Search requests:" },
                columnDefs: [
                    { orderable: false, targets: [4] }
                ]
            });
            
            $('#transactionsTable').DataTable({
                responsive: true,
                pageLength: 15,
                order: [[0, 'desc']],
                language: { search: "Search transactions:" }
            });
        });
    </script>
</body>
</html>

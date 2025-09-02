<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - Auro Bank</title>
<link id="theme-style" rel="stylesheet" href="light.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css" />
<jsp:include page="common/header.jsp" />
</head>
<body>
<div class="container-fluid py-4">

<!-- Welcome Header -->
<div class="row mb-4">
  <div class="col-12">
    <div class="card card-banking border-0" style="background: linear-gradient(135deg, var(--secondary-color), var(--dark-color)); color: white;">
      <div class="card-body text-center py-4">
        <h1 class="display-6 fw-bold mb-2">Welcome back, ${user.fullName}!</h1>
        <p class="lead mb-0">Manage your accounts and transactions</p>
        <div class="mt-3">
          <a href="EditProfileController" class="btn btn-outline-light btn-sm">
            <i class="fas fa-user-edit me-1"></i>Edit My Profile
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Alert Messages (revised block) -->
<c:if test="${not empty message}">
  <div class="row mb-4">
    <div class="col-12">
      <div class="alert 
        ${message.contains('successfully') ? 'alert-banking-success' : 'alert-banking-danger'}
        alert-dismissible fade show" role="alert">
        <i class="fas 
          ${message.contains('successfully') ? 'fa-check-circle' : 'fa-exclamation-triangle'}
        me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </div>
  </div>
</c:if>

<!-- Quick Actions -->
<div class="row mb-4">
  <div class="col-md-4 mb-3">
    <div class="card card-banking h-100 text-center">
      <div class="card-body">
        <i class="fas fa-plus-circle fa-3x text-banking-primary mb-3"></i>
        <h5>Open New Account</h5>
        <p class="text-muted">Start with a new savings or current account</p>
        <button class="btn btn-banking-primary" data-bs-toggle="modal" data-bs-target="#newAccountModal">Apply Now</button>
      </div>
    </div>
  </div>
  <div class="col-md-4 mb-3">
    <div class="card card-banking h-100 text-center">
      <div class="card-body">
        <i class="fas fa-exchange-alt fa-3x text-banking-secondary mb-3"></i>
        <h5>Transfer Money</h5>
        <p class="text-muted">Send money to any account instantly</p>
        <a href="TransferPageController" class="btn btn-banking-secondary">
          Transfer Now
        </a>
      </div>
    </div>
  </div>
  <div class="col-md-4 mb-3">
    <div class="card card-banking h-100 text-center">
      <div class="card-body">
        <i class="fas fa-file-invoice fa-3x text-banking-primary mb-3"></i>
        <h5>Account Statements</h5>
        <p class="text-muted">View and download transaction history</p>
        <button class="btn btn-banking-primary" data-bs-toggle="modal" data-bs-target="#statementModal">View Statements</button>
      </div>
    </div>
  </div>
</div>

<!-- My Accounts Section -->
<div class="row">
  <div class="col-12" id="accounts">
    <div class="card card-banking">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h4 class="text-banking-dark mb-0">
          <i class="fas fa-credit-card me-2"></i>My Accounts
        </h4>
        <span class="badge bg-primary">${accounts.size()} Account(s)</span>
      </div>
      <div class="card-body">
        <div class="table-responsive">
          <table id="accountsTable" class="table table-hover">
            <thead class="table-dark">
              <tr>
                <th>Account Number</th>
                <th>Type</th>
                <th>Status</th>
                <th>Balance</th>
                <th>Created</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="account" items="${accounts}">
                <tr>
                  <td><span class="badge bg-secondary">${account.accountNumber}</span></td>
                  <td>
                    <span class="badge ${account.accountType == 'savings' ? 'bg-success' : 'bg-info'}">
                      <i class="fas ${account.accountType == 'savings' ? 'fa-piggy-bank' : 'fa-briefcase'} me-1"></i>
                      ${account.accountType == 'savings' ? 'Savings' : 'Current'}
                    </span>
                  </td>
                  <td>
                    <span class="badge ${account.status == 'active' ? 'bg-success' : account.status == 'pending' ? 'bg-warning' : 'bg-danger'}">
                      ${account.status}
                    </span>
                  </td>
                  <td class="fw-bold text-banking-primary">₹${account.balance}</td>
                  <td class="text-muted small">${account.createdAt}</td>
                  <td>
                    <div class="btn-group btn-group-sm">
                      <a href="ViewAccountController?id=${account.accountId}" class="btn btn-banking-secondary btn-sm">
                        <i class="fas fa-eye"></i>
                      </a>
                      <c:if test="${account.status == 'active'}">
                        <a href="PassbookController?accountId=${account.accountId}" class="btn btn-outline-primary btn-sm">
                          <i class="fas fa-file-alt"></i>
                        </a>
                      </c:if>
                      <button class="btn btn-outline-danger btn-sm" onclick="deleteAccount(${account.accountId})">
                        <i class="fas fa-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <c:if test="${empty accounts}">
          <div class="text-center py-5">
            <i class="fas fa-credit-card fa-4x text-muted mb-3"></i>
            <h5 class="text-muted">No accounts yet</h5>
            <p class="text-muted">Open your first account to get started</p>
            <button class="btn btn-banking-primary" data-bs-toggle="modal" data-bs-target="#newAccountModal">
              <i class="fas fa-plus me-1"></i>Open Account
            </button>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</div>

<!-- New Account Modal -->
<div class="modal fade" id="newAccountModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Open New Account</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form action="CreateAccountController" method="post">
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label fw-semibold">Account Type</label>
            <select name="accountType" class="form-select" required>
              <option value="">Choose account type...</option>
              <option value="savings"><i class="fas fa-piggy-bank"></i> Savings Account</option>
              <option value="current"><i class="fas fa-briefcase"></i> Current Account</option>
            </select>
          </div>
          <div class="alert alert-info">
            <i class="fas fa-info-circle me-2"></i> Your account will be reviewed and activated by our admin team.
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-banking-primary">Submit Application</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Statement Modal -->
<div class="modal fade" id="statementModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Account Statements</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form action="PassbookController" method="get">
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label fw-semibold">Select Account</label>
            <select name="accountId" class="form-select" required>
              <option value="">Choose account...</option>
              <c:forEach var="account" items="${accounts}">
                <option value="${account.accountId}">
                  ${account.accountNumber} (${account.accountType}) - ₹${account.balance}
                </option>
              </c:forEach>
            </select>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-banking-primary">View Statement</button>
        </div>
      </form>
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
        $('#accountsTable').DataTable({
            responsive: true,
            pageLength: 10,
            language: {
                search: "Search accounts:"
            }
        });
    });

    function deleteAccount(accountId) {
        if (confirm('Are you sure you want to delete this account? This action cannot be undone.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'DeleteAccountController';

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'accountId';
            input.value = accountId;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</body>
</html>

package com.aurionpro.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class BankAccount {
	private int accountId;
	private int userId;
	private String accountType;
	private String accountNumber;
	private String status;
	private Timestamp createdAt;
	private Timestamp approvedAt;
	private boolean isDeleted;
	private BigDecimal balance; // ADDED

	public BankAccount() {
	}

	public BankAccount(int accountId, int userId, String accountType, String accountNumber, String status,
			Timestamp createdAt, Timestamp approvedAt, boolean isDeleted, BigDecimal balance) { // UPDATED
		this.accountId = accountId;
		this.userId = userId;
		this.accountType = accountType;
		this.accountNumber = accountNumber;
		this.status = status;
		this.createdAt = createdAt;
		this.approvedAt = approvedAt;
		this.isDeleted = isDeleted;
		this.balance = balance;
	}

	// Getters and setters
	public int getAccountId() {
		return accountId;
	}

	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getApprovedAt() {
		return approvedAt;
	}

	public void setApprovedAt(Timestamp approvedAt) {
		this.approvedAt = approvedAt;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public BigDecimal getBalance() {
		return balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}
}

package com.aurionpro.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Transaction {
	private int transactionId;
	private Integer senderAccountId; // May be null for deposit/withdrawal
	private Integer receiverAccountId; // May be null for withdrawal
	private java.math.BigDecimal amount;
	private String type;
	private String description;
	private java.sql.Timestamp transactionDate;
	private boolean isDeleted;

	public Transaction() {
		super();
	}

	public Transaction(int transactionId, Integer senderAccountId, Integer receiverAccountId, BigDecimal amount,
			String type, String description, Timestamp transactionDate, boolean isDeleted) {
		super();
		this.transactionId = transactionId;
		this.senderAccountId = senderAccountId;
		this.receiverAccountId = receiverAccountId;
		this.amount = amount;
		this.type = type;
		this.description = description;
		this.transactionDate = transactionDate;
		this.isDeleted = isDeleted;
	}

	public int getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(int transactionId) {
		this.transactionId = transactionId;
	}

	public Integer getSenderAccountId() {
		return senderAccountId;
	}

	public void setSenderAccountId(Integer senderAccountId) {
		this.senderAccountId = senderAccountId;
	}

	public Integer getReceiverAccountId() {
		return receiverAccountId;
	}

	public void setReceiverAccountId(Integer receiverAccountId) {
		this.receiverAccountId = receiverAccountId;
	}

	public java.math.BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(java.math.BigDecimal amount) {
		this.amount = amount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public java.sql.Timestamp getTransactionDate() {
		return transactionDate;
	}

	public void setTransactionDate(java.sql.Timestamp transactionDate) {
		this.transactionDate = transactionDate;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

}

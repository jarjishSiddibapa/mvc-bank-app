package com.aurionpro.model;

import java.sql.Timestamp;

public class AdminAction {
	private int actionId;
	private int adminId;
	private String actionType;
	private int targetId;
	private String notes;
	private Timestamp actionTime;

	public AdminAction() {
		super();
	}

	public AdminAction(int actionId, int adminId, String actionType, int targetId, String notes, Timestamp actionTime) {
		super();
		this.actionId = actionId;
		this.adminId = adminId;
		this.actionType = actionType;
		this.targetId = targetId;
		this.notes = notes;
		this.actionTime = actionTime;
	}

	public int getActionId() {
		return actionId;
	}

	public void setActionId(int actionId) {
		this.actionId = actionId;
	}

	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}

	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}

	public int getTargetId() {
		return targetId;
	}

	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public Timestamp getActionTime() {
		return actionTime;
	}

	public void setActionTime(Timestamp actionTime) {
		this.actionTime = actionTime;
	}
}

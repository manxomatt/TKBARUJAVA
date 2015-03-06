package com.tkbaru.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="tb_phonelist")
public class PhoneList {
	public PhoneList() {
		
	}

	@Id
	@Column(name="phonelist_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)	
	private int phoneListId;
	@Column(name="provider")
	private String providerName;
	@Column(name="number")
	private String phoneNumber;
	@Column(name="status")
	private String phoneStatus;
	@Column(name="remarks")
	private String phoneNumRemarks;
	@Column(name="created_by")
	private int createdBy;
	@Column(name="created_date")
	private Date createdDate;
	@Column(name="updated_by")
	private int updatedBy;
	@Column(name="updated_date")
	private Date updatedDate;
	public int getPhoneListId() {
		return phoneListId;
	}
	public void setPhoneListId(int phoneListId) {
		this.phoneListId = phoneListId;
	}
	public String getProviderName() {
		return providerName;
	}
	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getPhoneStatus() {
		return phoneStatus;
	}
	public void setPhoneStatus(String phoneStatus) {
		this.phoneStatus = phoneStatus;
	}
	public String getPhoneNumRemarks() {
		return phoneNumRemarks;
	}
	public void setPhoneNumRemarks(String phoneNumRemarks) {
		this.phoneNumRemarks = phoneNumRemarks;
	}
	public int getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public int getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(int updatedBy) {
		this.updatedBy = updatedBy;
	}
	public Date getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}
	@Override
	public String toString() {
		return "PhoneList [phoneListId=" + phoneListId + ", providerName="
				+ providerName + ", phoneNumber=" + phoneNumber
				+ ", phoneStatus=" + phoneStatus + ", phoneNumRemarks="
				+ phoneNumRemarks + ", createdBy=" + createdBy
				+ ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
				+ ", updatedDate=" + updatedDate + "]";
	}
}

package com.tkbaru.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

public class Person {
	public Person() {
		this.phoneList = new ArrayList<PhoneList>();
	}
	
	private int personId;
	private String firstName;
	private String lastName;
	private String addressLine1;
	private String addressLine2;
	private String addressLine3;
	private String emailAddr;
	private String photoPath;
	
	private List<PhoneList> phoneList = LazyList.decorate(new ArrayList<PhoneList>(), FactoryUtils.instantiateFactory(Person.class));

	public int getPersonId() {
		return personId;
	}

	public void setPersonId(int personId) {
		this.personId = personId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getAddressLine1() {
		return addressLine1;
	}

	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}

	public String getAddressLine2() {
		return addressLine2;
	}

	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}

	public String getAddressLine3() {
		return addressLine3;
	}

	public void setAddressLine3(String addressLine3) {
		this.addressLine3 = addressLine3;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getPhotoPath() {
		return photoPath;
	}

	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}

	public List<PhoneList> getPhoneList() {
		return phoneList;
	}

	public void setPhoneList(List<PhoneList> phoneList) {
		this.phoneList = phoneList;
	}
	
}
package com.justin.project.database.dao;

import com.google.appengine.api.datastore.Key;

import java.util.Date;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable
public class Employee {
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Key key;

    @Persistent
    private String firstName;

    @Persistent
    private String lastName;
    
    @Persistent
    private String title;

	@Persistent
    private Date hireDate;
	public Employee() {
		
	}
	
    public Employee(String firstName, String lastName, Date hireDate) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.hireDate = hireDate;
    }

    // Accessors for the fields.  JDO doesn't use these, but your application does.

    public Key getKey() {
        return key;
    }

    public void setKey(Key key) {
		this.key = key;
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

    public Date getHireDate() {
        return hireDate;
    } 
    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    } 
    
    public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
package com.justin.project.database.dao;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class UserLocation {
	@PrimaryKey
    private Key key;
	
	@Persistent
	private Number lat;
	
	@Persistent
	private Number lng;
	
	@Persistent
	private String userName;
	
	@Persistent
	private String userInfo;
	
	public Key getKey() {
        return key;
    }

    public void setKey(Key key) {
		this.key = key;
	}

	public Number getLat() {
		return lat;
	}

	public void setLat(Number lat) {
		this.lat = lat;
	}

	public Number getLng() {
		return lng;
	}

	public void setLng(Number lng) {
		this.lng = lng;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(String userInfo) {
		this.userInfo = userInfo;
	}
}

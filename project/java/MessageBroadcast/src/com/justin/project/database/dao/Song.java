package com.justin.project.database.dao;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class Song {
	
	@PrimaryKey
    private Key key;

	@Persistent
    private String url;
	
	@Persistent
    private String author;
	
	@Persistent
	private String playOrder;
	
	public Key getKey() {
		return key;
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPlayOrder() {
		return playOrder;
	}

	public void setPlayOrder(String playOrder) {
		this.playOrder = playOrder;
	}
	
}

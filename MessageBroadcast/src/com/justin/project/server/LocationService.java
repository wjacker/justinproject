package com.justin.project.server;


import javax.jdo.PersistenceManager;

import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.gwt.dev.generator.ast.Expression;
import com.justin.project.database.PMF;
import com.justin.project.database.dao.UserLocation;

import java.util.List;
import javax.jdo.Query;


public class LocationService {
	private static final Logger log = Logger.getLogger(LocationService.class.getName());

	public List<UserLocation> getUserLocationList() {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(UserLocation.class);

	    try {
			List<UserLocation> results = (List<UserLocation>) query.execute();
			log.log(Level.INFO, "UserLocation Length:" + results.size());
	        return results;
	    } finally {
	        query.closeAll();
	    }
	}
	
	public boolean addUserLocation(UserLocation userLocation)
	{
		if(userLocation == null || userLocation.getUserName().isEmpty())
			return false;
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Key k = KeyFactory.createKey(UserLocation.class.getSimpleName(), userLocation.getUserName());
		userLocation.setKey(k);
	    try {
	    	pm.makePersistent(userLocation);
	    	return true;
	    } catch(Exception e)
	    {
	    	return false;
	    }
	    finally {
	    	pm.close();
	    }
	}
	
	public boolean modifyUserLocation(UserLocation userLocation)
	{
		log.log(Level.INFO, "Modify userLocation userName:" + userLocation.getUserName()
				+ " lat:" + userLocation.getLat() + " lng:" + userLocation.getLng());
		if(userLocation == null || userLocation.getUserName().isEmpty())
			return false;
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Key k = KeyFactory.createKey(UserLocation.class.getSimpleName(), userLocation.getUserName());

	    try {
	    	UserLocation u = pm.getObjectById(UserLocation.class, k);
    		log.log(Level.INFO, "userLocation not in DB");
    		u.setLat(userLocation.getLat());
	    	u.setLng(userLocation.getLng());
	    	u.setUserInfo(userLocation.getUserInfo());
	        return true;
	    } catch(Exception e)
	    {
	    	log.log(Level.SEVERE, "Modify User Location fault:" + e.getMessage());
	    	return false;
	    }
	    finally {
	    	pm.close();
	    }
	}
	
	public boolean deleteUserLocation(UserLocation userLocation) {
		if (userLocation == null || userLocation.getUserName().isEmpty())
			return false;

		PersistenceManager pm = PMF.get().getPersistenceManager();
		Key k = KeyFactory.createKey(UserLocation.class.getSimpleName(),
				userLocation.getUserName());
		try {
			log.log(Level.INFO, "userLocation in DB");
			UserLocation u = pm.getObjectById(UserLocation.class, k);
			pm.deletePersistent(u);
			return true;
		} catch (Exception e) {
			log.log(Level.INFO, "delete fault:" + e.getMessage());
			return false;
		} finally {
			pm.close();
		}
	}
}

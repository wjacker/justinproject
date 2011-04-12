package com.justin.project.server;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.justin.project.database.PMF;
import com.justin.project.database.dao.Employee;
import com.justin.project.database.dao.Song;
import com.justin.project.database.dao.UserLocation;

public class SongService {
	private static final Logger log = Logger.getLogger(SongService.class.getName());
	
	@SuppressWarnings("unchecked")
	public List<Song> getSongList() {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(Song.class);
	    try {
			List<Song> results = (List<Song>) query.execute();
	        return results;
	    } finally {
	        query.closeAll();
	    }
	}
	
	public boolean addSong(Song song) {
		if(song == null)
			return false;
		log.log(Level.INFO, "Modify userLocation getUrl:" + song.getUrl()
				+ " getAuthor:" + song.getAuthor());
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Key k = KeyFactory.createKey(Song.class.getSimpleName(), song.getUrl());
		song.setKey(k);
		try {
			pm.makePersistent(song);
	    	return true;
        } catch(Exception e)
	    {
        	log.log(Level.SEVERE, "Add Song fault:" + e.getMessage());
	    	return false;
	    }
		finally {
            pm.close();
        }
	}
	
	public boolean editSong(Song song) {
		if(song == null || song.getUrl().isEmpty())
			return false;
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Key k = KeyFactory.createKey(Song.class.getSimpleName(), song.getUrl());
        try {
        	Song s = pm.getObjectById(Song.class, k);
    		s.setUrl(song.getUrl());
	    	s.setAuthor(song.getAuthor());
	        return true;
        } finally {
            pm.close();
        }
	}
	
	public boolean deleteSong(Song song) {
		if(song == null || song.getUrl().isEmpty())
			return false;
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Key k = KeyFactory.createKey(Song.class.getSimpleName(), song.getUrl());
        try {
        	Song u = pm.getObjectById(Song.class, k);
			pm.deletePersistent(u);
			return true;
        }catch (Exception e) {
			log.log(Level.INFO, "delete fault:" + e.getMessage());
			return false;
		}finally {
            pm.close();
        }
	}
	
}

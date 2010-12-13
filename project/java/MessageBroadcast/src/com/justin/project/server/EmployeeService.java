package com.justin.project.server;


import javax.jdo.PersistenceManager;

import java.util.logging.Level;
import java.util.logging.Logger;
import com.justin.project.database.PMF;
import com.justin.project.database.dao.Employee;
import com.justin.project.database.dto.Pager;

import java.util.List;
import javax.jdo.Query;


public class EmployeeService {
	private static final Logger log = Logger.getLogger(EmployeeService.class.getName());

	public List<Employee> getEmployeeList() {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(Employee.class);
//	    query.setFilter("lastName == lastNameParam");
//	    query.setOrdering("hireDate desc");
//	    query.declareParameters("String lastNameParam");

	    try {
	        List<Employee> results = (List<Employee>) query.execute();
	        return results;
	    } finally {
	        query.closeAll();
	    }
	}
	
	public List<Employee> getEmployeeListBy(Pager pager)
	{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String queryStr = "select from com.justin.project.database.dao.Employee";
		if(!pager.getSortField().isEmpty())
		{
			queryStr = queryStr.concat(" order by ").concat(pager.getSortField()).concat(" ").concat(pager.getSortType());
		}

		log.log(Level.SEVERE, "query string:" + queryStr);
		 
		Query query = pm.newQuery(queryStr);
		query.setRange(pager.getRecFrom(), pager.getRecFrom() + pager.getPageSize());
	    try {
	        List<Employee> results = (List<Employee>) query.execute();
	        return results;
	    } finally {
	        query.closeAll();
	    }
	}
	
	public int getPageCount()
	{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(Employee.class);
	    try {
	    	List<Employee> results = (List<Employee>) query.execute();
	        return results.size();
	    } finally {
	        query.closeAll();
	    }
	}
	
	public List<Employee> executeQuery(String s, long from, long to) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(s);
		query.setRange(from, to);
	    try {
	        List<Employee> results = (List<Employee>) query.execute();
	        return results;
	    } finally {
	        query.closeAll();
	    }
	}
	
	public Employee getEmployee(Employee user) {
	    PersistenceManager pm = PMF.get().getPersistenceManager();
	    Employee employee, detached = null;
	    try {
	        employee = pm.getObjectById(Employee.class,
	            "Alfred.Smith@example.com");

	        // If you're using transactions, you can call
	        // pm.setDetachAllOnCommit(true) before committing to automatically
	        // detach all objects without calls to detachCopy or detachCopyAll.
	        detached = pm.detachCopy(employee);
	    } finally {
	        pm.close();
	    }
	    return detached;
	}
	
	public void saveEmployee(Employee e) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(e);
        } finally {
            pm.close();
        }
	}
	

	public void updateEmployeeTitle(Employee e, String newTitle) {
		e.setTitle(newTitle);
        PersistenceManager pm = PMF.get().getPersistenceManager();
        try {
            pm.makePersistent(e);
        } finally {
            pm.close();
        }
	}
}

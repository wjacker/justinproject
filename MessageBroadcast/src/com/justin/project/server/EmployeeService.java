package com.justin.project.server;

import javax.jdo.PersistenceManager;

import com.justin.project.database.PMF;
import com.justin.project.database.dao.Employee;
import java.util.List;
import javax.jdo.Query;


public class EmployeeService {
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

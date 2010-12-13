package
{
	[RemoteClass(alias="com.justin.project.database.dao.Employee")]
	public class Employee
	{
		public var key : Key;

	    public var firstName : String;
	
	    public var lastName : String;
	    
	    public var title : String;
	
	    public var hireDate : Date;
		
		
		public function Employee()
		{
		}

	}
}
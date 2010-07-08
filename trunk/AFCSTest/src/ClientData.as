package
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="com.justin.project.server.Customer.ClientData")]
	public class ClientData
	{
		public function ClientData()
		{
		}
		
		public var int dataType;
		public var dataSource : ArrayCollection;

	}
}
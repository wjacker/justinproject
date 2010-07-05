package
{
	public class Person
	{
		public var name : String;
		public var age : Number;
		public function Person(name : String, age : Number)
		{
			this.name = name;
			this.age = age;
		}
		
		public function toString():String
		{
			return "Name: " + this.name + "\nAge:" + this.age;
		}
	}
}
package com.task
{
	import flash.events.Event;

	public class TaskEvent extends Event
	{
		public static const COMPLETE : String = "Complete";
		public static const INPROCESSING : String = "Inprocessing";
		public static const NOT_START : String = "NotStart";
		public static const FAILED : String = "failed";
		
		public function TaskEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
package com.justin.common.components.datagrid
{
	import flash.events.Event;
	public class PageableGridEvent extends Event
	{
		public static const OUT_OF_RANGE:String = "out_of_range";
		public static const CURSOR_MAXED:String = "cursor_maxed";
		public static const SORT:String = "sort";
		public var data:Object = new Object();
		public function PageableGridEvent(type:String, _data:Object){
			super(type);
			data = _data;
		}
		override public function clone():Event {
           return new PageableGridEvent(type, data);
        }
	}
}
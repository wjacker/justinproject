package com.adobe.coreUI.events
{
	import flash.events.Event;

	/**
	 * @private
	 */
	public class WBToolBarEvent extends Event
	{
		public static const TOOL_BAR_CLICK:String = "toolBarClick";
		public static const TOOLBAR_CHANGE:String = "toolBarChange";
		
		public var item:Object;
		
		public function WBToolBarEvent(type:String, data:Object=null)
		{
			super(type, bubbles, cancelable);
			item = data;
		}
		
	}
}
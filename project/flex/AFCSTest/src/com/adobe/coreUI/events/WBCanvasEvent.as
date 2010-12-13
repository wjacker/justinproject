package com.adobe.coreUI.events
{
	import flash.events.Event;
	
	/**
	 * @private
	 */
	public class WBCanvasEvent extends Event
	{
		public static const PROPERTIES_TOOLBAR_ADD:String = "propertiesToolbarAdd";
		public static const PROPERTIES_TOOLBAR_REMOVE:String = "propertiesToolbarRemove";
		public static const CURSOR_CHANGE:String = "cursorChange";
		public static const END_DRAWING_SHAPE:String = "endDrawingShape";
		
		public function WBCanvasEvent(p_type:String)
		{
			super(p_type);
		}

		public override function clone():Event
		{
			return new WBCanvasEvent(type);
		}

	}
}
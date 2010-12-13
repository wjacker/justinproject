package com.adobe.coreUI.events
{
	import flash.events.Event;
	
	/**
	 * @private
	 */
	public class NullColorPickerEvent extends Event
	{
		public static const PROPERTIES_TOOLBAR_ADD:String = "propertiesToolbarAdd";
		public static const PROPERTIES_TOOLBAR_REMOVE:String = "propertiesToolbarRemove";
		
		public function NullColorPickerEvent(p_type:String)
		{
			super(p_type);
		}

		public override function clone():Event
		{
			return new NullColorPickerEvent(type);
		}

	}
}
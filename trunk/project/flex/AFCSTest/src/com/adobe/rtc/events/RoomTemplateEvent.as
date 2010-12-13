package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * Emitted by <code>RoomTemplater</code>, this event class notifies saves of a Room to a Template.
	 * 
	 * @see com.adobe.rtc.util.RoomTemplater
	 */
	public class RoomTemplateEvent extends Event
	{

		/**
		 * Event type dispatched to indicate a room has been saved to a template
		 */
		public static const TEMPLATE_SAVE:String = "templateSave";
		

		public function RoomTemplateEvent(type:String, p_templateName:String)
		{
			templateName = p_templateName;
			super(type, false, false);
		}
		
		/**
		 * The name of the newly-saved template 
		 */
		public var templateName:String;
	}
}
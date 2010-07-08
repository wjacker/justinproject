package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * Emitted by <code>Roster</code>  this event class notifies changes in data of the Roster. It is fired by the Roster's internal Itemrenderer
	 * 
	 * @see com.adobe.rtc.pods.Roster
	 */
	public class RTCEvent extends Event
	{
		/**
		 *  This event is fired when the data is changed...
		 */
		public static const DATA_CHANGE:String = "dataChange";
		
		public function RTCEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @private
		 */
		public override function clone():Event
		{
			return new RTCEvent(type, bubbles, cancelable);
		}
		
	}
}
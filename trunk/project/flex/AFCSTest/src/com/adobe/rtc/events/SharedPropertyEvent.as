// ActionScript file
package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * The event class sent for events sent by SharedProperty. 
	 * 
	 * @see com.adobe.rtc.events.SharedPropertyEvent
	 */
	public class SharedPropertyEvent extends Event
	{
		/**
		 * Dispatched when the shared property changes
		 */
		public static const CHANGE:String = "change"; 

		/**
		 * The body of the Shared Property
		 */
		public var value:*;
		/**
		 * The Publisher ID of the shared property
		 */ 
		public var publisherID:String  ;
		
		
		/**
		 *  Constructor
		 */
		public function SharedPropertyEvent(p_type:String, p_publisherID:String=null)
		{
			super(p_type);
			
			if (p_publisherID ) {
				publisherID = p_publisherID;
			}
		}

		/**
		* @private
		*/
		public override function clone():Event
		{
			return new SharedPropertyEvent(type, publisherID);
		}		
		
	}
}
package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * The event class sent for events sent by ConnectSession. 
	 * 
	 * @see com.adobe.rtc.session.ConnectSession
	 */
	public class ConnectSessionEvent extends Event
	{
		/**
		 * Dispatched when the ConnectSession is closed and about to remove its children.
		 */
		public static const CLOSE:String = "close"; 

		/**
		* A reason for calling close; for example, "The meeting has ended".
		*/
		public var reason:String;
		
		public function ConnectSessionEvent(p_type:String, p_reason:String="")
		{
			super(p_type);
			
			if (p_reason != "") {
				reason = p_reason;
			}
		}

		/**
		* @private
		*/
		public override function clone():Event
		{
			return new ConnectSessionEvent(type, reason);
		}		
		
	}
}
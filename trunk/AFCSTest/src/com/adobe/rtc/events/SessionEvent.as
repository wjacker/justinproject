package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * These events are emitted by various Session classes 
	 * 
	 * @see com.adobe.rtc.session.ConnetSession
	 * 
	 */
	public class SessionEvent extends Event
	{
		
		/**
		* The type of event emitted when the session gains or loses synchronization with its source.
		*/
		public static const SYNCHRONIZATION_CHANGE:String = "synchronizationChange"; 

		/**
		* Type of event emitted when the server encounters an error.
		*/
		public static const ERROR:String = "error";
		/**
		* Type of event emitted when the session is logged in.
		*/
		public static const LOGIN:String = "login";
		/**
		* Type of event emitted when the session is disconnected.
		*/
		public static const DISCONNECT:String = "disconnect"; 
		/**
		* Type of event emitted when the session pings.
		*/
		public static const PING:String = "ping";
		/**
		* Type of event emitted when the connection status changes .
		*/
		public static const CONNECTION_STATUS_CHANGE:String = "connectionStatusChange";
		/**
		 * @private
		 */
		public static const TEMPLATE_SAVE:String = "templateSave";
		
		public var userDescriptor:*;
		public var ticket:String;
		public var error:Error;
		
		public var latency:uint;
		public var bwUp:uint;
		public var bwDown:uint;
		public var latencyString:String;
		public var bwUpString:String;
		public var bwDownString:String;
		
		public var connectionStatus:String;
		public var templateName:String;
		
		public function SessionEvent(p_type:String)
		{
			super(p_type);
		}
		
		/**
		 * @private
		 */
		public override function clone():Event
		{
			var e:SessionEvent = new SessionEvent(type);
			e.userDescriptor = userDescriptor;
			e.ticket = ticket;
			e.error = error;
			e.latency = latency;
			e.bwUp = bwUp;
			e.bwDown = bwDown;
			e.latencyString = latencyString;
			e.bwUpString = bwUpString;
			e.bwDownString;
			e.connectionStatus = connectionStatus;
			return e;
		}
		
	}
}
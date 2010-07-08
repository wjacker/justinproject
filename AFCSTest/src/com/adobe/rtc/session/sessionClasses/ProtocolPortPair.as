package com.adobe.rtc.session.sessionClasses
{	
	/**
	 * @private
	 * Use this little object to pass protocol/port pairs to FMSConnector.
	 * 
	 */
	public class ProtocolPortPair extends Object
	{
		//include "../core/Version.as";
		
		/**
		 * @default "rtmp"
		 */
		public var protocol:String = "rtmp";

		/**
		 * @default 1935
		 */
		public var port:Number = 1935;
		
		/**
		 * Pass the protocol (for instance "rtmp" or "rtmpt" or "rtmps") and the port number (for instance 1935, 443, 80)
		 * to create the pair.
		 * 
		 * @author Peldi Guilizzoni
		 */
		function ProtocolPortPair(p_proto:String, p_port:Number):void
		{
			protocol = p_proto;
			port = p_port;
		}		
	}
}
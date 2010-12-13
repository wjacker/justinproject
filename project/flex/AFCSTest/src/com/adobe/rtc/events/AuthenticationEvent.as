package com.adobe.rtc.events
{
	import flash.events.Event;
	/**
	 * Event class sent by com.adobe.rtc.authentication classes (such as AdobeHSAuthenticator) to indicate 
	 * login success or failure.
	 * 
	 * @see com.adobe.rtc.authentication.AdobeHSAuthenticator
	 */
	public class AuthenticationEvent extends Event
	{
		/**
		 * Event sent to indicate login success.
		 */
		public static const AUTHENTICATION_SUCCESS:String = "authenticationSuccess";

		/**
		 * Event sent to indicate login failure.
		 */
		public static const AUTHENTICATION_FAILURE:String = "authenticationFailure";
		
		public function AuthenticationEvent(p_type:String)
		{
			super(p_type);
		}

		/**
		 * @private
		 */
		public override function clone():Event
		{
			return new AuthenticationEvent(type);
		}		

	}
}
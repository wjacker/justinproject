package com.adobe.rtc.session.sessionClasses
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import com.adobe.rtc.core.session_internal;
	import com.adobe.rtc.core.messaging_internal;
	import com.adobe.rtc.messaging.manager.MessageManager;
	import com.adobe.rtc.session.managers.SessionManagerBase;

	/**
	 * @private
	 */
	public class SessionInternals extends EventDispatcher
	{
		public function SessionInternals(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		messaging_internal var messageManager:MessageManager;
		session_internal var sessionManager:SessionManagerBase;
		/**
		 * @private
		 * 
		 * DO NOT save this in a variable after getting it, as it might change with reconnects. Use this getter
		 * (ConnectSession.primarySession.session_internal::connection as NetConnection) every time you need it instead!
		 */
		session_internal var connection:*;
		
	}
}
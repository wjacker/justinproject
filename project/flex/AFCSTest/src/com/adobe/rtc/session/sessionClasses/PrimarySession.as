package com.adobe.rtc.session.sessionClasses
{
	import com.adobe.rtc.sharedManagers.StreamManager;
	import flash.events.EventDispatcher;
	import com.adobe.rtc.sharedManagers.FileManager;
	import com.adobe.rtc.sharedManagers.RoomManager;
	import com.adobe.rtc.session.IConnectSession;
	import flash.events.Event;
	import com.adobe.rtc.authentication.AbstractAuthenticator;
	import com.adobe.rtc.session.RoomSettings;
	import com.adobe.rtc.sharedManagers.UserManager;
	import flash.events.IEventDispatcher;
	import com.adobe.rtc.events.SessionEvent;
	import com.adobe.rtc.events.ConnectSessionEvent;

	/**
	 * @private
	 */
	public class PrimarySession extends EventDispatcher implements IConnectSession
	{
		
		/**
		 * @private 
		 */
		protected var _connectSessionInstance:IConnectSession;
		
		public function PrimarySession(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function get userManager():UserManager
		{
			return _connectSessionInstance.userManager;
		}
		
		public function get streamManager():StreamManager
		{
			return _connectSessionInstance.streamManager;
		}
		
		public function get fileManager():FileManager
		{
			return _connectSessionInstance.fileManager;
		}
		
		public function get roomManager():RoomManager
		{
			return _connectSessionInstance.roomManager;
		}
		
		public function get authenticator():AbstractAuthenticator
		{
			return _connectSessionInstance.authenticator;
		}
		
		public function set authenticator(p_auth:AbstractAuthenticator):void
		{
			_connectSessionInstance.authenticator = p_auth;
		}
		
		public function get roomURL():String
		{
			return _connectSessionInstance.roomURL;
		}
		
		public function set roomURL(p_url:String):void
		{
			_connectSessionInstance.roomURL = p_url;
		}
		
		public function get initialRoomSettings():RoomSettings
		{
			return _connectSessionInstance.initialRoomSettings;
		}
		
		public function set initialRoomSettings(p_settings:RoomSettings):void
		{
			_connectSessionInstance.initialRoomSettings = p_settings;
		}
		
		public function get isSynchronized():Boolean
		{
			return _connectSessionInstance.isSynchronized;
		}
		
		public function get sessionInternals():SessionInternals
		{
			return _connectSessionInstance.sessionInternals;
		}
		
		public function login():void
		{
			_connectSessionInstance.login();
		}
		
		public function logout():void
		{
			_connectSessionInstance.logout();
		}
		
		public function close(p_reason:String=""):void
		{
			_connectSessionInstance.close(p_reason);
		}
		
		public function set connectSessionInstance(p_session:IConnectSession):void
		{
			_connectSessionInstance = p_session;
			_connectSessionInstance.addEventListener(SessionEvent.SYNCHRONIZATION_CHANGE,onConnectSessionEvent);
			_connectSessionInstance.addEventListener(ConnectSessionEvent.CLOSE,onConnectSessionEvent);
		}
		
		/**
		 * @inheritdoc
		 */
		override public function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false, p_priority:int=0, p_useWR:Boolean=false):void
		{
			super.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWR);
			_connectSessionInstance.addEventListener(p_type, onConnectSessionEvent, p_useCapture, p_priority, p_useWR);
		}
		
		/**
		 * @inheritdoc
		 */
		override public function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false):void
		{
			super.removeEventListener(p_type, p_listener, p_useCapture);
			_connectSessionInstance.removeEventListener(p_type, onConnectSessionEvent, p_useCapture);
		}


		/**
		 * @private 
		 */
		protected function onConnectSessionEvent(p_evt:Event):void
		{
			dispatchEvent(p_evt);
		}
		
		public function get connectSessionInstance():IConnectSession
		{
			return _connectSessionInstance;
		}
		
	}
}
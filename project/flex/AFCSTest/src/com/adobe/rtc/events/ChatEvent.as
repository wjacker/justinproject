package com.adobe.rtc.events
{
	import flash.events.Event;
	import com.adobe.rtc.sharedModel.descriptors.ChatMessageDescriptor;

	/**
	 * Event class dispatched by com.adobe.rtc.sharedModel.SimpleChatModel. 
	 * 
	 * @see com.adobe.rtc.sharedModel.SimpleChatModel
	 */
	public class ChatEvent extends Event
	{
		/**
		 * Dispatched when the typing list updates.
		 */
		public static const TYPING_LIST_UPDATE:String = "typingListUpdate"; 

		/**
		 * Dispatched when the time format changes from the AM/PM format to the 24 hour system and vise versa.
		 */
		public static const TIME_FORMAT_CHANGE:String = "timeFormatChange"; 

		/**
		 * Dispatched when private chat is enabled or disabled.
		 */
		public static const ALLOW_PRIVATE_CHAT_CHANGE:String = "allowPrivateChatChange"; 

		/**
		 * Dispatched when timestamps are turned on or off.
		 */
		public static const USE_TIME_STAMPS_CHANGE:String = "useTimeStampsChange"; 

		/**
		 * Dispatched when the history changes.
		 * If this is a result of a new message arriving, the message descriptor reside in <code>.message</code>.
		 */
		public static const HISTORY_CHANGE:String = "historyChange"; 

		/**
		* The ChateMessageDescriptor for which this event pertains, if applicable.
		*/
		public var message:ChatMessageDescriptor;
		
		public function ChatEvent(p_type:String, p_message:ChatMessageDescriptor=null)
		{
			super(p_type);
			
			if (p_message) {
				message = p_message;
			}
		}

		/**
		 * @private 
		 */
		public override function clone():Event
		{
			return new ChatEvent(type, message);
		}		
		
	}
}
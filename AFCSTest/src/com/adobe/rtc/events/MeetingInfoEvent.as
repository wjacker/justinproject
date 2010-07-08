package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * Event class dispatched by com.adobe.rtc.session.sessionClasses.MeetingInfoService
	 * 
	 * @see com.adobe.rtc.session.sessionClasses.MeetingInfoService
	 */
	public class MeetingInfoEvent extends Event
	{
		/**
		 * Dispatched when meeting or account info are received
		 */
		public static const INFO_RECEIVE:String = "infoReceive"; 

		/**
		 * Dispatched when items (rooms or templates) are received
		 */
		public static const ITEMS_RECEIVE:String = "itemsReceive"; 

		public var itemsType:String;
		public var items:Array;
		
		public function MeetingInfoEvent(p_type:String, p_itemsType:String = null, p_items:Array=null)
		{
			super(p_type);

			if (p_itemsType)
				itemsType = p_itemsType;
			if (p_items)
				items = p_items;
		}

		/**
		 * @private 
		 */
		public override function clone():Event
		{
			return new MeetingInfoEvent(type, itemsType, items);
		}		
		
	}
}

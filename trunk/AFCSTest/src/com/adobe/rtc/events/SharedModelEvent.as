package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * The event class dispatched by SharedProperties and BatonProperty.
	 * @see com.adobe.rtc.sharedModel.BaronProperty
	 */
	public class SharedModelEvent extends Event
	{
		/**
		 * Dispatched when the baton holder changes.
		 */
		public static const BATON_HOLDER_CHANGE:String = "batonHolderChange";
		/**
		 * Dispatched when someone makes a baton request.
		 */
		public static const BATON_REQUEST:String = "batonRequest";
		/**
		 * Dispatched when the baton has been released.
		 */
		public static const BATON_RELEASE:String = "batonRelease";

		/**
		 * @private
		 */
		public static const INDICES_SELECT:String = "indicesSelect";
		/**
		 * @private
		 */
		public static const SCROLL_UPDATE:String = "scrollUpdate";
				
		public function SharedModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		/**
		 * @private
		 */
		public override function clone():Event
		{
			return new SharedModelEvent(type, bubbles, cancelable);
		}
	}
}
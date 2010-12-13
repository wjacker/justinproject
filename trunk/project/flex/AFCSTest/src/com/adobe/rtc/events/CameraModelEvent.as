package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * Emitted by <code>CameraModel</code> and <code>WebCamera</code> this event class notifies changes in either the layout or quality settings on image
	 * 
	 * @see com.adobe.rtc.pods.WebCamera
	 * @see com.adobe.rtc.pods.cameraClasses.CameraModel
	 */
	public class CameraModelEvent extends Event
	{
		/**
		 * Event dispatched when the Quality of image changes
		 */
		public static const QUALITY_CHANGE:String = "qualityChange";
		/**
		 * Event dispatched when the layout of Image changes
		 */
		public static const LAYOUT_CHANGE:String = "layoutChange";

		public function CameraModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
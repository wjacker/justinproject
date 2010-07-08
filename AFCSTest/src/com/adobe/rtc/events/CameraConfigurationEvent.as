// ActionScript file
package com.adobe.rtc.events
{
	import flash.events.Event;

	/**
	 * Emitted by <code>WebcamPublisher</code>, this event class notifies changes to camera configuration.
	 * 
	 * @see com.adobe.rtc.collaboration.WebcamPublisher
	 */
	public class CameraConfigurationEvent extends Event
	{
		/**
		 * Event type dispatched to indicate fps has changed.
		 */
		public static const FPS_CHANGED:String = "fpsChanged";

		/**
		 * Event type dispatched to indicate quality level has changed.
		 */
		public static const QUALITY_CHANGED:String = "qualityChanged";
		/**
		 * Event type dispatched to indicate Key Frame Interval Changed.
		 */
		public static const KEY_FRAME_INTERVAL_CHANGED:String = "keyFrameIntervalChanged";
		/**
		 * Event type dispatched to indicate Capturing width height factor changed
		 */
		public static const CAPTURE_WIDTH_HEIGHT_FACTOR_CHANGED:String = "captureWidthHeightFactorChanged";
		/**
		 * Event type dispatched to indicate the bandwidth cap is user changed and user defined
		 */
		public static const BANDWIDTH_CHANGED:String = "bandwidthChanged";
		
		
		public function CameraConfigurationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @private
		 */
		public override function clone():Event
		{
			return new CameraConfigurationEvent(type);
		}
		
	}
}
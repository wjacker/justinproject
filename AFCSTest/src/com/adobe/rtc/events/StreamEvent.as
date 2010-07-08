// ActionScript file
package com.adobe.rtc.events
{
	import com.adobe.rtc.sharedManagers.descriptors.StreamDescriptor;
	
	import flash.events.Event;

	/**
	 * Event Class dispatched by the StreamManager
	 * @see com.adobe.rtc.sharedManagers.StreamManager
	 */
	public class StreamEvent extends Event
	{
		/**
		 * Dispatched when a room receives a new stream.
		 */
		public static const STREAM_RECEIVE:String = "streamReceive";	
		/**
		 * Dispatched when a stream is removed from the room
		 */
		public static const STREAM_DELETE:String = "streamDelete";
		/**
		 * Dispatched when the dimensions of a video stream change.
		 */
		public static const DIMENSIONS_CHANGE:String= "dimensionsChange";
		/**
		 * Dispatched when the bandwidth settings for a stream change.
		 */
		public static const BANDWIDTH_CHANGE:String= "bandwidthChange";
		/**
		 * Dispatched when a stream has been paused.
		 */
		public static const STREAM_PAUSE:String= "streamPause";
		/**
		 * Dispatched when the volume of an audio stream changes.
		 */
		public static const VOLUME_CHANGE:String="volumeChange";
		/**
		 * Dispatched when the Aspect Ratio of a video stream changes.
		 */
		public static const ASPECT_RATIO_CHANGE:String = "aspectRatioChange";
		/**
		 * @private
		 */
		public static const NO_STREAM_DETECTED:String = "noStreamDetected" ;
		/**
		 * @private
		 */
		public static const STREAM_SELECT:String = "streamSelect" ;
		/**
		 * @private
		 */
		public static const CONNECTION_TYPE_CHANGE:String = "connectionTypeChange" ;
		/**
		 * @private
		 */
		public static const CODEC_CHANGE:String = "codecChange" ;
		
		
		/**
		 * A streamDescriptor associated with this event, if applicable.
		 */
		public var streamDescriptor:StreamDescriptor;
		/**
		 * A name of the event.
		 */
		public var name:String;
		
		
		public function StreamEvent(type:String,p_streamDescriptor:StreamDescriptor = null,p_name:String=null):void {
			super(type);
			
			if ( p_streamDescriptor != null ) {
				streamDescriptor = p_streamDescriptor ;
			}
			
			if ( p_name != null ) {
				name = p_name ;
			}
		}

		/**
		 * @private
		 */
		public override function clone():Event
		{
			return new StreamEvent(type, streamDescriptor,name);
		}
	}
}

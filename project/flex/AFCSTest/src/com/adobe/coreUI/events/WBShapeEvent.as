package com.adobe.coreUI.events
{
	import flash.events.Event;
	import com.adobe.coreUI.controls.CustomTextEditor;



	/**
	 * @private
	 */
	public class WBShapeEvent extends Event
	{
		public static const TEXT_EDITOR_CREATE:String = "textEditorCreate";
		public static const TEXT_EDITOR_DESTROY:String = "textEditorDestroy";
		public static const DRAWING_COMPLETE:String = "drawingComplete";
		public static const DRAWING_CANCEL:String = "drawingCancelled";
		
		public static const SIZING_WIDTH:String = "sizingWidth";
		public static const SIZING_HEIGHT:String = "sizingHeight";
		public static const SIZING_BOTH:String = "sizingBoth";
		
		public static const POSITION_CHANGE:String = "positionChange";
		public static const SIZE_CHANGE:String = "sizeChange";
		public static const ROTATION_CHANGE:String = "rotationChange";
		
		public static const PROPERTY_CHANGE:String = "propertyChange";
		
		public static const POSITION_SIZE_ROTATE_END:String = "positionSizeRotateEnd";
		
		
		public var textEditor:CustomTextEditor;
		
		public var sizingDirection:String;
		
		public function WBShapeEvent(p_type:String)
		{
			super(p_type);
		}
		
		public override function clone():Event
		{
			var evt:WBShapeEvent = new WBShapeEvent(type);
			evt.textEditor = textEditor;
			return evt;
		}
	}
}
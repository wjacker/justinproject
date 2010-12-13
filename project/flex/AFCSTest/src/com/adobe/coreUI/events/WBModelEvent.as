package com.adobe.coreUI.events
{
	import flash.events.Event;
	import com.adobe.coreUI.controls.whiteboardClasses.WBShapeDescriptor;


	/**
	 * @private
	 */
	public class WBModelEvent extends Event
	{
		
		public var shapeID:String;
		public var deletedShape:WBShapeDescriptor;
		public var isLocalChange:Boolean = false;
		
		public static const SHAPE_CREATE:String = "shapeCreate";
		public static const SHAPE_ADD:String = "shapeAdd";
		public static const SHAPE_POSITION_SIZE_ROTATION_CHANGE:String = "shapePositionSizeRotationChange";
		public static const SHAPE_PROPERTIES_CHANGE:String = "shapePropertiesChange";
		public static const SHAPE_REMOVE:String = "shapeRemove";
		public static const SYNCHRONIZATION_CHANGE:String = "synchronizationChange";
		public static const MY_ROLE_CHANGE:String = "myRoleChange";
		
		public function WBModelEvent(p_type:String)
		{
			super(p_type);
		}
		
	}
}
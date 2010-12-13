package com.adobe.coreUI.controls.whiteboardClasses.commands
{
	import com.adobe.coreUI.controls.whiteboardClasses.IWBCommand;
	import com.adobe.coreUI.controls.whiteboardClasses.WBCommandBase;
	import com.adobe.coreUI.controls.whiteboardClasses.WBShapeDescriptor;

	/**
	 * @private
	 */
	public class WBRemoveShapes extends WBCommandBase
	{
		protected var _removedDescriptors:Array;
		
		public function WBRemoveShapes(p_descriptorsToRemove:Array)
		{
			_removedDescriptors = p_descriptorsToRemove;
		}
		
		override public function unexecute():void
		{
			var l:int = _removedDescriptors.length;
			for (var i:int=0; i<l; i++) {
//				canvas.model.createShape(WBShapeDescriptor(_removedDescriptors[i]));
				canvas.model.addShape(WBShapeDescriptor(_removedDescriptors[i]));
			}
		}
		
		override public function execute():void
		{
			var l:int = _removedDescriptors.length;
			for (var i:int=0; i<l; i++) {
				canvas.model.removeShape(WBShapeDescriptor(_removedDescriptors[i]).shapeID);
			}
		}
		
	}
}
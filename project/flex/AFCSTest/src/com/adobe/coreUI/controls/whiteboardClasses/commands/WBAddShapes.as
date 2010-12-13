package com.adobe.coreUI.controls.whiteboardClasses.commands
{
	import com.adobe.coreUI.controls.whiteboardClasses.IWBCommand;
	import com.adobe.coreUI.controls.whiteboardClasses.WBCommandBase;
	import com.adobe.coreUI.controls.whiteboardClasses.WBShapeDescriptor;

	/**
	 * @private
	 */
	public class WBAddShapes extends WBCommandBase
	{
		
		protected var _descriptorsToAdd:Array;
		
		public function WBAddShapes(p_descriptorsToAdd:Array)
		{
			_descriptorsToAdd = p_descriptorsToAdd;
		}
		
		override public function unexecute():void
		{
			var l:int = _descriptorsToAdd.length;
			for (var i:int=0; i<l; i++) {
				_canvas.model.removeShape(WBShapeDescriptor(_descriptorsToAdd[i]).shapeID);
			}
		}
		
		override public function execute():void
		{
			var l:int = _descriptorsToAdd.length;
			for (var i:int=0; i<l; i++) {
				var desc:WBShapeDescriptor = _descriptorsToAdd[i] as WBShapeDescriptor;
				_canvas.model.addShape(desc);
			}
		}
		
		
		
	}
}
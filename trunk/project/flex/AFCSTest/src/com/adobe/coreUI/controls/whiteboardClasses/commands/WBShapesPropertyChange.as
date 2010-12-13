package com.adobe.coreUI.controls.whiteboardClasses.commands
{
	import com.adobe.coreUI.controls.whiteboardClasses.IWBCommand;
	import com.adobe.coreUI.controls.whiteboardClasses.WBCommandBase;
	import com.adobe.coreUI.controls.whiteboardClasses.WBShapeDescriptor;

	/**
	 * @private
	 */
	public class WBShapesPropertyChange extends WBCommandBase
	{

		protected var _changedDescriptors:Array;
		protected var _oldDescriptors:Array;

		public function WBShapesPropertyChange(p_changedDescriptors:Array)
		{
			_changedDescriptors = p_changedDescriptors;
		}
		
		override public function unexecute():void
		{
			var l:int = _oldDescriptors.length;
			for (var i:int=0; i<l; i++) {
				var desc:WBShapeDescriptor = _oldDescriptors[i] as WBShapeDescriptor;
				_canvas.model.changeShapeProperties(desc.shapeID, desc.propertyData);
			}
		}
		
		override public function execute():void
		{
			_oldDescriptors = new Array();
			var l:int = _changedDescriptors.length;
			for (var i:int=0; i<l; i++) {
				var desc:WBShapeDescriptor = _changedDescriptors[i] as WBShapeDescriptor;
				_oldDescriptors.push(_canvas.model.getShapeDescriptor(desc.shapeID).clone());
				_canvas.model.changeShapeProperties(desc.shapeID, desc.propertyData);
			}
		}
		
	}
}
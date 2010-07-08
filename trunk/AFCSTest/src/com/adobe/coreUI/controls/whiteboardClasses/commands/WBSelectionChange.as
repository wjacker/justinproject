package com.adobe.coreUI.controls.whiteboardClasses.commands
{
	import com.adobe.coreUI.controls.whiteboardClasses.IWBCommand;
	import com.adobe.coreUI.controls.whiteboardClasses.WBCommandBase;

	/**
	 * @private
	 */
	public class WBSelectionChange extends WBCommandBase
	{
		protected var _oldSelection:Array;
		protected var _newSelection:Array;
		
		public function WBSelectionChange(p_newSelection:Array)
		{
			_newSelection = p_newSelection;
		}
		
		override public function unexecute():void
		{
			_canvas.selectedShapeIDs = _oldSelection;
		}
		
		override public function execute():void
		{
			_oldSelection = _canvas.selectedShapeIDs.slice();
			_canvas.selectedShapeIDs = _newSelection;
		}
		
	}
}
package com.adobe.coreUI.controls.whiteboardClasses
{
	/**
	 * @private
	 */
	public class WBCommandBase implements IWBCommand
	{
		protected var _canvas:WBCanvas;
		
		public function set canvas(p_canvas:WBCanvas):void
		{
			_canvas = p_canvas;
		}
		
		public function get canvas():WBCanvas
		{
			return _canvas;
		}
		
		public function unexecute():void
		{
		}
		
		public function execute():void
		{
		}
		
	}
}
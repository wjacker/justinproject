package com.adobe.coreUI.controls.whiteboardClasses
{
	/**
	 * @private
	 */
	public interface IWBCommand
	{
		function set canvas(p_canvas:WBCanvas):void;
		function get canvas():WBCanvas;
		function execute():void
		function unexecute():void
	}
}
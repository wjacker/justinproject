package com.adobe.coreUI.controls.whiteboardClasses
{
	/**
	 * @private
	 */
	public interface IWBShapeFactory
	{
		
		function newShape():WBShapeBase;
		function get toolBar():IWBPropertiesToolBar;
		function get toggleSelectionAfterDraw():Boolean;
		function set shapeData(p_data:Object):void;
		function get cursor():Class;
		function get factoryId():String;
	}
}
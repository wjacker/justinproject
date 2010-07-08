package com.adobe.coreUI.controls.whiteboardClasses
{
	import mx.core.IUIComponent;
	
	/**
	 * @private
	 */
	public interface IWBPropertiesToolBar extends IUIComponent
	{
		function get propertyData():*;
	 	function set propertyData(p_data:*):void;
	 	function set isFilledShape(p_filled:Boolean):void;
	}
}
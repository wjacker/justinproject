package com.adobe.coreUI.controls.whiteboardClasses.shapes
{
	import flash.display.Shape;
	import com.adobe.coreUI.controls.whiteboardClasses.IWBShapeFactory;
	import com.adobe.coreUI.controls.whiteboardClasses.WBShapeBase;
	import com.adobe.coreUI.controls.whiteboardClasses.IWBPropertiesToolBar;
	
	/**
	 * @private
	 */
	public class WBTextShapeFactory implements IWBShapeFactory
	{
		[Embed (source = '../whiteboardAssets/toolBarIcons.swf#cursor_text')]
		public static var CURSOR_TEXT:Class;
		
		public function newShape():WBShapeBase
		{
			var nShape:WBShapeBase = new WBTextShape();
			return nShape;
		}
		
		public function get toolBar():IWBPropertiesToolBar
		{
			return null;
		}
		
		public function get toggleSelectionAfterDraw():Boolean
		{
			return false;
		}
		
		public function set shapeData(p_data:Object):void
		{
		}
		
		public function get cursor():Class
		{
			return CURSOR_TEXT;
		}
		
		public function get factoryId():String
		{
			return null;
		}
		
	}
}
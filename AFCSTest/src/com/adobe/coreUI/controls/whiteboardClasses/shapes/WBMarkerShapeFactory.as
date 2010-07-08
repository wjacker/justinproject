package com.adobe.coreUI.controls.whiteboardClasses.shapes
{
	import com.adobe.coreUI.controls.whiteboardClasses.IWBShapeFactory;
	import com.adobe.coreUI.controls.whiteboardClasses.WBShapeBase;
	import com.adobe.coreUI.controls.whiteboardClasses.IWBPropertiesToolBar;
	
	/**
	 * @private
	 */
	public class WBMarkerShapeFactory implements IWBShapeFactory
	{
		[Embed (source = '../whiteboardAssets/toolBarIcons.swf#cursor_highlighter_pen')]
		public static var CURSOR_HIGHLIGHTER_PEN:Class;
		[Embed (source = '../whiteboardAssets/toolBarIcons.swf#cursor_pen')]
		public static var CURSOR_PEN:Class;
		
		
		public static const HIGHLIGHTER:String = "hightlighter";
		
		protected var _shapeData:Object;
		protected var _toolBar:IWBPropertiesToolBar;
		
		public function newShape():WBShapeBase
		{
			var nShape:WBMarkerShape = new WBMarkerShape();
			if (_toolBar) {
				nShape.propertyData = _toolBar.propertyData;
			}
			return nShape;
		}
		
		public function get toolBar():IWBPropertiesToolBar
		{
			if (!_toolBar) {
				_toolBar = new WBPropertiesToolBar();
				var tmpShape:WBMarkerShape = new WBMarkerShape();
				if (_shapeData==HIGHLIGHTER) {
					var props:Object = tmpShape.propertyData;
					props.lineColor = 0xffff00;
					props.alpha = 0.5;
					props.lineThickness = 15;
					tmpShape.propertyData = props;
				}
				_toolBar.propertyData = tmpShape.propertyData;
			}
			_toolBar.isFilledShape = false;
			return _toolBar;
		}
		
		public function get toggleSelectionAfterDraw():Boolean
		{
			return false;
		}
		
		public function set shapeData(p_data:Object):void
		{
			_shapeData = p_data;
		}
		
		public function get cursor():Class
		{
			if (_shapeData==HIGHLIGHTER) {
				return CURSOR_HIGHLIGHTER_PEN;
			} else {
				return CURSOR_PEN;
			}
		}
		
		public function get factoryId():String
		{
			return null;
		}
	}
}
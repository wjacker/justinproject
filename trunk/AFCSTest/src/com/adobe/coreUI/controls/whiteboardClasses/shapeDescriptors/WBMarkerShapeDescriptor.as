package com.adobe.coreUI.controls.whiteboardClasses.shapeDescriptors
{
	import com.adobe.coreUI.controls.whiteboardClasses.WBShapeDescriptor;
	import com.adobe.coreUI.controls.whiteboardClasses.shapes.WBMarkerShape;
	
	/**
	 * Descriptor class for a Highlighter/Marker pen shape
	 * 
	 * @see com.adobe.coreUI.controls.whiteboardClasses.WBShapeDescriptor
	 */
	public class WBMarkerShapeDescriptor extends WBShapeDescriptor
	{

		public function WBMarkerShapeDescriptor()
		{
			super();
			initialize();
		}

		/**
		 *@private
		 */		
		protected function initialize():void
		{
			var markerShape:WBMarkerShape = new WBMarkerShape();
			propertyData =  markerShape.propertyData;
			definitionData = markerShape.definitionData;
			factoryID = "com.adobe.coreUI.controls.whiteboardClasses.shapes::WBMarkerShapeFactory";
		}
		
		
		/**
		 * Specifies the line thickness of the marker shape
		 * 
		 * @default "15"
		 */
		public function get lineThickness():Number
		{
			return propertyData.lineThickness;
		}

		/**
		 *@private
		 */
		public function set lineThickness(p_lineThickness:Number):void
		{
			propertyData.lineThickness = p_lineThickness;
		}
		
		/**
		 * Specifies the line color
		 * 
		 * @default "#16776960"
		 */
		public function get lineColor():uint
		{
			return propertyData.lineColor;
		}
		
		/**
		 *@private
		 */		
		public function set lineColor(p_lineColor:uint):void
		{
			propertyData.lineColor = p_lineColor;
		}

		/**
		 * Specifies the foreground alpha of the marker shape
		 * 
		 * @default "0.5"
		 */
		public function get alpha():Number
		{
			return propertyData.alpha;
		}
		
		/**
		 *@private
		 */
		public function set alpha(p_lineAlpha:Number):void
		{
			propertyData.alpha = p_lineAlpha;
		}
		
		/**
		 * Specifies the array of points (x,y coordinates) of the Marker
		 */
		public function get points():Array
		{
			return definitionData as Array;
		}
		
		/**
		 *@private
		 */
		public function set points(p_points:Array):void
		{
			propertyData = p_points;
		}

	}
}
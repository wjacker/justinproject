package com.adobe.coreUI.controls.whiteboardClasses.shapeDescriptors
{
	import com.adobe.coreUI.controls.whiteboardClasses.WBShapeDescriptor;
	import com.adobe.coreUI.controls.whiteboardClasses.shapes.WBArrowShape;
	
	/**
	 * Descriptor class for a Arrow shape
	 * 
	 * @see com.adobe.coreUI.controls.whiteboardClasses.WBShapeDescriptor
	 */
	public class WBArrowShapeDescriptor extends WBShapeDescriptor
	{

		public function WBArrowShapeDescriptor()
		{
			super();
			initialize();
		}

		/**
		 *@private
		 */		
		protected function initialize():void
		{
			var arrowShape:WBArrowShape = new WBArrowShape();
			propertyData =  arrowShape.propertyData;
			definitionData = arrowShape.definitionData;
			factoryID = "com.adobe.coreUI.controls.whiteboardClasses.shapes::WBArrowShapeFactory";
		}
		
		
		/**
		 * Specifies the line thickness of the Arrow shape
		 * 
		 * @default "10"
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
		 * @default "#3815994"
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
		 * Specifies whether the drop shadow is set or not
		 * 
		 * @default "true"
		 */
		public function get dropShadow():Boolean
		{
			return propertyData.dropShadow;
		}
		
		/**
		 *@private
		 */		
		public function set dropShadow(p_dropShadow:Boolean):void
		{
			propertyData.dropShadow = p_dropShadow;
		}
		
		/**
		 * Specifies whether the gradient fill of the arrow lines is set or not
		 * 
		 * @default "true"
		 */
		public function get gradientFill():Boolean
		{
			return propertyData.gradientFill;
		}

		/**
		 *@private
		 */		
		public function set gradientFill(p_gradientFill:Boolean):void
		{
			propertyData.gradientFill = p_gradientFill;
		}
		
		/**
		 * Specifies the foreground alpha of the arrow lines
		 * 
		 * @default "1"
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
		

	}
}
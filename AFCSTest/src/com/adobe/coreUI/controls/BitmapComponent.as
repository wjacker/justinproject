package com.adobe.coreUI.controls
{
	import mx.core.UIComponent;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @private
	 *
	 *
	 *
	 */
	public class BitmapComponent extends UIComponent
	{
		protected var m_displayObjectToClone:DisplayObject
		protected var m_bitmapData:BitmapData;
		protected var m_generatedBitmap:Bitmap;
		protected var m_bitmapDirty:Boolean=false;

		public function BitmapComponent()
		{
		}

		public function set displayObjectToClone(p_displayObject:DisplayObject):void
		{
			m_displayObjectToClone = p_displayObject;
			m_bitmapDirty = true;
			m_displayObjectToClone.addEventListener("creationComplete", readyToClone);
			invalidateProperties();
		}

		private function readyToClone(p_evt:Event):void
		{
			m_bitmapDirty = true;
			invalidateDisplayList();
		}

		public function get displayObjectToClone():DisplayObject
		{
			return m_displayObjectToClone;
		}

		override protected function commitProperties():void
 		{
			if (m_bitmapDirty) {
				m_bitmapData = new BitmapData(m_displayObjectToClone.width, m_displayObjectToClone.height, true, 0xffffff);
			}
		}

		override protected function measure():void
 		{
			super.measure();
			measuredHeight = measuredMinHeight = (m_bitmapData==null) ? 0 : m_bitmapData.height;
			measuredMinWidth = measuredWidth = (m_bitmapData==null) ? 0 : m_bitmapData.width;
		}

		override protected function updateDisplayList(p_unscaledW:Number, p_unscaledH:Number):void
 		{
 			// TODO : are there any more filters? The dropshadow seems to come in later than this...
 			if (m_bitmapDirty) {
	 			m_bitmapData.draw(m_displayObjectToClone, null, null, null, null, true);
	 			m_generatedBitmap = new Bitmap(m_bitmapData);
	 			m_generatedBitmap.transform = m_displayObjectToClone.transform;
	 			m_generatedBitmap.blendMode = m_displayObjectToClone.blendMode;
	 			m_generatedBitmap.filters = m_displayObjectToClone.filters;
	 			addChild(m_generatedBitmap);
	 			m_bitmapDirty = false;
	 		}
 		}

	}
}
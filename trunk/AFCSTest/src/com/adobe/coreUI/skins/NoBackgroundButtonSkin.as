package com.adobe.coreUI.skins
{
	import mx.skins.halo.ButtonSkin;

	/**
	 * @private
	 */
	public class NoBackgroundButtonSkin extends ButtonSkin
	{
		public function NoBackgroundButtonSkin()
		{
			super();
		}
		
		protected override function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w,h);
			alpha = 0;
		}
	}
}
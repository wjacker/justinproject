package com.adobe.coreUI.localization
{
	import flash.events.EventDispatcher;

	/**
	 * @private
	 */
	public class LocalizationManagerNoOp extends EventDispatcher implements ILocalizationManager
	{
		public function formatString(p_inStr:String, ...args):String
		{
			return p_inStr;
		}
		
		public function getString(p_inStr:String):String
		{
			return p_inStr;
		}
		
	}
}
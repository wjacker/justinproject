package com.adobe.coreUI.localization
{
	import flash.events.EventDispatcher;

	/**
	 * @private
	 */
	public class Localization extends EventDispatcher
	{
		protected static var _impl:ILocalizationManager = new LocalizationManagerNoOp();
		
		public static function get impl():ILocalizationManager
		{
			return _impl;
		}
		
		public static function set impl(p_impl:ILocalizationManager):void
		{
			_impl = p_impl;
		}
	}
}

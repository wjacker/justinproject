package com.adobe.coreUI.localization
{
	/**
	 * @private
	 */
	public interface ILocalizationManager
	{
		function getString(p_inStr:String):String;
		function formatString(p_inStr: String, ...args):String;
	}
}
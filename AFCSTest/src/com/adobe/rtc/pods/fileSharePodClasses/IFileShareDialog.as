package com.adobe.rtc.pods.fileSharePodClasses
{
	import mx.core.IFlexDisplayObject;
	
	/**
	 * @private
	 */
	public interface IFileShareDialog extends IFlexDisplayObject
	{
		function set displayMessage(p_msg:String):void;
	}
}
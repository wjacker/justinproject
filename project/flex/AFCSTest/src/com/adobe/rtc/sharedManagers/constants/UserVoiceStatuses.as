package com.adobe.rtc.sharedManagers.constants
{
	/**
	 * @private 
	 */
	public class UserVoiceStatuses
	{
		public static const OFF:String = null;
		public static const ON_SILENT:String = "onSilent";
		public static const ON_SPEAKING:String = "onSpeaking";
				
		public function UserVoiceStatuses():void
		{
			throw new Error("UserVoiceStatuses(): Cannot be instantiated.");
		}
		
		public static function isValidStatus(p_value:String):Boolean
		{
			if(p_value == OFF ||
				p_value == ON_SILENT ||
				p_value == ON_SPEAKING) {
					return true;
				}
				
			return false;
		}
	}
}
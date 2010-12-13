package com.adobe.rtc.sharedManagers.constants
{
	/**
	 * @private
	 */
	public class UserStatuses
	{
		public static const NORMAL:String = null;
		public static const RAISING_HAND:String = "raisingHand";
		public static const TOO_FAST:String = "tooFast";
		public static const TOO_SLOW:String = "tooSlow";
		public static const LAUGHTER:String = "laughter";
		public static const APPLAUSE:String = "applause";
		public static const YES:String = "yes";
		public static const NO:String = "no";
		public static const AWAY:String = "away";
		
		public function UserStatus():void
		{
			throw new Error("UserStatus(): Cannot be instantiated.");
		}
		
		public static function isValidStatus(p_value:String):Boolean
		{
			if(p_value == NORMAL ||
				p_value == RAISING_HAND ||
				p_value == TOO_FAST ||
				p_value == TOO_SLOW ||
				p_value == LAUGHTER ||
				p_value == APPLAUSE ||
				p_value == YES ||
				p_value == NO ||
				p_value == AWAY) {
					return true;
				}
				
			return false;
		}
	}
}
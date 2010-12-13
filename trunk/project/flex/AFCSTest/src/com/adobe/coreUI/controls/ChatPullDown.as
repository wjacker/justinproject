package com.adobe.coreUI.controls
{
	/**
	 * 
	 * @private
	 * 
	 */
	public class ChatPullDown extends NoCtrlList
	{
		public function ChatPullDown()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			setStyle("fontFamily", "Arial");
		}
	}
}
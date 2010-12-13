package com.task
{
	import flash.utils.setTimeout;
	
	public class TimeDelayTask extends Task
	{
		public var delayTime : Number;
		public var taskResult : String;
		public function TimeDelayTask(taskName:String, delayTime : Number, taskResult : String)
		{
			super(taskName);
			this.delayTime = delayTime;
			this.taskResult = taskResult;
		}
		
		override public function executeSelf():void
		{
			setTimeout(timeComplete,delayTime);
		}
		
		private function timeComplete() : void
		{
			status = taskResult;
			/* if(Math.random() > 0.5)
			{
				status = TaskEvent.COMPLETE;
			}
			else
			{
				status = TaskEvent.FAILED;
			} */
			executeSelfFinished();
		}
	}
}
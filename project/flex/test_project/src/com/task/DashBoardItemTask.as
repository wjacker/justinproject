package com.lombardrisk.jupiter.controller.task
{
	public class DashBoardItemTask extends Task
	{
		private var const dashboardItemName : String = "dashboardItemTask";
		public function DashBoardItemTask()
		{
			super(dashboardItemName);
			this.executeByQueue = true;
			var getTimeStampsTask : Task = new Task("getTimeStampsTask");
			getTimeStampsTask
			this.addSubTask();
		}
		
		override function listNotificationInterests():Array
		{
			return [ApplicationFacade.TIME_STAMPS_UPDATE,
				ApplicationFacade.BUCKET_LOAD_SUCCESS,
				ApplicationFacade.CASHFLOW_LOAD_SUCCESS
				];
		}
		
		override function handleNotification(notification:INotification):void
		{
			switch()
			{
				case ApplicationFacade.TIME_STAMPS_UPDATE:
				
					break;
				case ApplicationFacade.BUCKET_LOAD_SUCCESS:
					
					break;
				case ApplicationFacade.CASHFLOW_LOAD_SUCCESS:
					
					break;
					
			}
		}
		
		override function execute():void
		{
			super.execute();
			
		}

	}
}
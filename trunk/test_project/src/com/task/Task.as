package com.task
{
	import com.task.interfaces.ITask;
	
	
	public class Task implements ITask
	{
		public static const NAME:String = 'Task';
		
		protected var taskName : String;
		protected var subTasksMap : Array;
		protected var superTasksMap : Array;
		public var executeByQueue : Boolean = false;
		public var status : String;
		public var executeSelfBeforeChild : Boolean = true;
		public var taskCompleteHandler : Function;
		public var taskFailedHandler : Function;
		
		public var stopExecute : Boolean = false;
		
		//public var taskTerm : Number;
		
		
		public function Task(taskName:String)
		{
			subTasksMap = new Array();
			superTasksMap = new Array();;
			status = TaskEvent.NOT_START;
			this.taskName = (taskName != null) ? taskName : NAME; 
		}

		public function getTaskName():String
		{
			return taskName;
		}
		
		public function addSubTask(task : Task, required : Boolean = true):void
		{
			if(task == null)
				throw new Error("Add Task can not be null");
			task.superTasksMap.push(this);	
			subTasksMap.push({task:task, required:required});
		}
		
		public function removeSubTask(task:Task):void
		{
			//TODO
		}
		
		public function execute():void
		{
			if(status == TaskEvent.INPROCESSING)
			{
				return;
			}
			else if(status)
			{
				var subStatus : String = checkStatus();
			
				if(subStatus == TaskEvent.FAILED || status == TaskEvent.FAILED)
				{
					taskFailed();
					return;
				}
				else if(subStatus == TaskEvent.COMPLETE && status == TaskEvent.COMPLETE)
				{
					taskComplete();
					return;
				}
				else
				{
					//processing;
				}
			}
			status = TaskEvent.INPROCESSING;
			
			if(executeSelfBeforeChild)
			{
				executeSelf();
			}
			
			if(hasSubTask())
			{
				executeSubTask();
			}
			
			if(!executeSelfBeforeChild)
			{
				executeSelf();
			}
		}
		
		public function executeSelf() : void
		{
			
		}
		
		public function executeSelfFinished() : void
		{
			trace(taskName + " " + status)
			taskStatusUpdate();
		}
		
		public function hasSubTask() : Boolean
		{
			return subTasksMap.length > 0;
		}
		
		public function executeSubTask() : void
		{
			if(executeByQueue)
			{
				//TODO
			}
			else
			{
				for each(var obj : Object in subTasksMap)
				{
					(obj.task as Task).execute();
				}
			}
		}
		
		public function executeNextTask() : void
		{
			
		}
		
		public function taskFailed():void
		{
			stopExecute = true;
			status = TaskEvent.FAILED;
			if(superTasksMap.length > 0)
			{
				for each(var superTask : Task in superTasksMap)
				{
					superTask.taskStatusUpdate();
				}
			}
			else
			{
				stopExecute = true;
				taskFailedHandler.call(this, this);
			}
		}
		
		public function taskComplete():void
		{
			stopExecute = true;
			status = TaskEvent.COMPLETE;
			if(superTasksMap.length > 0)
			{
				for each(var superTask : Task in superTasksMap)
				{
					superTask.taskStatusUpdate();
				}
			}
			else
			{
				taskCompleteHandler.call(this, this);
			}
		}
		
		public function taskStatusUpdate():void
		{
			if(stopExecute)
				return;
				
			var subStatus : String = checkStatus();
			
			if(subStatus == TaskEvent.FAILED || status == TaskEvent.FAILED)
			{
				taskFailed();
			}
			else if(subStatus == TaskEvent.COMPLETE && status == TaskEvent.COMPLETE)
			{
				taskComplete();
			}
			else
			{
				//processing;
			}
		}
		
		public function checkStatus():String
		{
			
			var subStatus : String = TaskEvent.COMPLETE;
			if(hasSubTask())
			{
				for each(var obj : Object in subTasksMap)
				{
					var subTask : Task = obj.task as Task;
					if(subTask.status == TaskEvent.FAILED && obj.required)
					{
						subStatus = TaskEvent.FAILED;
						break;
					}
					else if(subTask.status == TaskEvent.INPROCESSING)
					{
						subStatus = TaskEvent.INPROCESSING;
						break;
					}
				}
			}
			else
			{
				subStatus = status
			}
			return subStatus;
		}
		
		public function getSubTaskMap():Array
		{
			return subTasksMap;
		}
		
		public function getSuperTaskMap():Array
		{
			return superTasksMap;
		}
	}
}
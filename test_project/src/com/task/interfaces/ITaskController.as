package com.task.interfaces
{
	public interface ITaskController
	{
		function registerTask(notificationName : String, taskClassRef : Class) : void;
		function executeTask() : void;
		function retrieveTask(taskName : String) : ITask;
		function removeTask(notificationName : String) : void;
		function hasTask(notificationName:String) : Boolean;
	}
}
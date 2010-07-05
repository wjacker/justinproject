package com.task.interfaces
{
	import com.task.Task;
	
	public interface ITask
	{
		function getTaskName():String;
		function addSubTask(task : Task, required : Boolean = true) : void
		function removeSubTask(task : Task) : void;
		function execute() : void;
		function checkStatus() : String;
		function getSubTaskMap() : Array;
		function getSuperTaskMap() : Array;
	}
}
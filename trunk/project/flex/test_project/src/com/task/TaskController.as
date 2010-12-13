package com.task
{
	import com.lombardrisk.jupiter.controller.task.interfaces.ITask;
	import com.lombardrisk.jupiter.controller.task.interfaces.ITaskController;
	
	import org.puremvc.as3.core.View;
	import org.puremvc.as3.interfaces.IView;
	import org.puremvc.as3.patterns.observer.Observer;

	public class TaskController implements ITaskController
	{
		protected const SINGLETON_MSG : String = "Controller Singleton already constructed!";
		
		protected static var instance : ITaskController;
		
		protected var view : IView;
		
		protected var taskMap : Array;
		
		public function TaskController()
		{
			if (instance != null) throw Error(SINGLETON_MSG);
			
			instance = this;
			taskMap = new Array();	
			initializeController();	
		}
		
		protected function initializeController(  ) : void 
		{
			view = View.getInstance();
		}
		
		public static function getInstance() : ITaskController
		{
			if ( instance == null ) instance = new TaskController( );
			return instance;
		}
		
		public function registerTask(task : ITask):void
		{
			if ( taskMap[ task.getTaskName() ] != null ) return;
			
			taskMap[task.getTaskName()] = task;
			
			view.registerObserver(task.getTaskName(), new Observer(executeTask, this));
			
			var interests:Array = task.listNotificationInterests();

			// Register Mediator as an observer for each of its notification interests
			if ( interests.length > 0 ) 
			{
				// Create Observer referencing this mediator's handlNotification method
				var observer:Observer = new Observer(task.handleNotification, task );

				// Register Mediator as Observer for its list of Notification interests
				for ( var i:Number=0;  i<interests.length; i++ ) {
					view.registerObserver( interests[i],  observer );
				}			
			}
		}
		
		public function retrieveTask( taskName:String ) : ITask
		{
			return taskMap[ taskName ];
		}
		
		public function executeTask(taskName : String):void
		{
			var taskClassRef : Class = taskMap[taskName];
			if (taskClassRef == null) return;

			var taskInstance : ITask = new taskClassRef();
			taskInstance.execute();
		}
		
		public function removeTask(taskName:String):void
		{
			// Retrieve the named task
			var task : ITask = taskMap[ taskName ] as ITask;
			
			if ( task ) 
			{
				// for every notification this mediator is interested in...
				var interests:Array = task.listNotificationInterests();
				for ( var i:Number=0; i<interests.length; i++ ) 
				{
					// remove the observer linking the mediator 
					// to the notification interest
					view.removeObserver( interests[i], task );
				}	
				
				// remove the mediator from the map		
				delete taskMap[ taskName ];
	
				// alert the mediator that it has been removed
				task.onRemove();
			}
			
			return task;
		}
		
		public function hasTask(notificationName:String):Boolean
		{
			return taskMap[ notificationName ] != null;
		}
		
	}
}
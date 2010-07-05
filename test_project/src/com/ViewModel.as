package com
{
	
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.containers.Canvas;
	
	public class ViewModel
	{
		public static var app:Test;
		public static var view:SourceView;
		public static var backBoard:Canvas;
		private static var _paintBoard:Canvas;
		 public static function set paintBoard(cvs:Canvas):void
		{
			_paintBoard = cvs;
		}
		public static function get paintBoard():Canvas
		{
			var returnContainer:Canvas = _paintBoard;
			if(ViewModel.app){
			}
			return returnContainer;
		} 
//		public static var paintBoard:Canvas;
		public static var floatBoard:Canvas;
		public static var mouseBoard:Canvas;
		
		public static var viewWidth:Number = 3000;
		public static var viewHeight:Number = 3000;
		public static var lineDistance:Number = 50;
		
		public static var mouseBoardContextMenu:ContextMenu = new ContextMenu();
		public static var treeLayoutContextMenu:ContextMenu = new ContextMenu();
		public static var deleteContext:ContextMenuItem;
		public static var addFolderContext:ContextMenuItem;
		
		public static var status:int = 0;
		public static var statusEdit:int = 1;
		public static var statusMove:int = 2;
		public static var statusResize1:int = 11;
		public static var statusResize2:int = 12;
		public static var statusResize3:int = 13;
		public static var statusResize4:int = 14;
		public static var statusResize5:int = 15;
		public static var statusResize6:int = 16;
		public static var statusResize7:int = 17;
		public static var statusResize8:int = 18;
		public static var statusResize9:int = 19;
		public static var selectLineBtn:Object;
		
		public static var scrollBarEditable:Boolean;
		
		public function ViewModel()
		{
		}

	}
}
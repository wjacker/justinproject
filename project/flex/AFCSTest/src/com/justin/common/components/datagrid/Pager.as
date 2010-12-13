package com.justin.common.components.datagrid
{
	[RemoteClass(alias="com.justin.project.database.dto.Pager")]
	public class Pager
	{
		public function Pager()
		{
		}
		
		public var pageSize:int;
		public var pageNum:int;
		public var recFrom: int;
		public var recCount:int;
		public var sortField:String = "";
		public var sortType:String = "ASC";
		
	}
}
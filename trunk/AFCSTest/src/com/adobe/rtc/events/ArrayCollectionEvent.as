package com.adobe.rtc.events
{
	import flash.events.Event;
	
	public class ArrayCollectionEvent extends Event
	{
		/**
		 * The ArrayCollectionChangeEvent.REPLACE constant defines the value of the type property of the event object for an event that is dispatched when a value in ArrayCollection has been modified.
		 */ 
	    public static const REPLACE:String = "replace";
		
		/**
  		 * The ArrayCollectionChangeEvent.ADD constant defines the value of the type property of the event object for an event that is dispatched when a value in ArrayCollection has been added.
		 */ 
	    public static const ADD:String = "add";

		/**
		 * The ArrayCollectionChangeEvent.REMOVE constant defines the value of the type property of the event object for an event that is dispatched when a value in ArrayCollection has been removed.
		 */ 
	    public static const REMOVE:String = "remove";
	    public static const REMOVEALL:String = "removeAll";
		
	    public var newItem:*;
	    public var location:int;
	    public var oldItem:*;

		public function ArrayCollectionEvent(p_type:String,p_location:int = -1,
                                    p_oldItem:* = null, p_newItem:* = null)
		{
			super(p_type);
	        location = p_location;
	        oldItem = p_oldItem;
    	    newItem = p_newItem ? p_newItem : null;
		}
		
		override public function clone():Event
		{
			return (new ArrayCollectionEvent(type,location,oldItem,newItem));
		}

	}
}
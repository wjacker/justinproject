﻿package com.adobe.rtc.sharedManagers.descriptors
{
	import com.adobe.rtc.messaging.IValueObjectEncodable;
	import com.adobe.rtc.session.RoomSettings;
	
	import flash.system.Capabilities;


	/**
	 * A UserDescriptor is an object used to represent the details of a given user 
	 * or entity in a room. It is returned by the UserManager's <code>getUserDescriptor()
	 * </code>. This this object is used for accessing relevent details about users 
	 * within a roster list and so on.
	 * 
	 * @see com.adobe.rtc.sharedManagers.UserManager
	 * 
	 */
	public class UserDescriptor implements IValueObjectEncodable
	{
		
		/**
		 * Unique ID for identifying the user within the room.
		 * 
		 */
		public var userID:String;
		
		/**
		 * The user name displayed in the roster.
		 * 
		 */
		public var displayName:String;

		/**
		 * The current user role for the user at the root level.
		 * 
		 */
		public var role:int=-1;

		/**
		 * The permanent, database-authenticated user role at the root level.
		 * 
		 */
		public var affiliation:int=-1;

		/**
		 * The user's connection speed as set in RoomSettings; for example, modem, dsl, or lan. 
		 * 
		 * @see com.adobe.rtc.session.RoomSettings
		 * 
		 */
		public var connection:String = RoomSettings.DSL;

		/**
		 * The amount of latency in milliseconds between the user and the server. 
		 * 
		 */
		public var latency:Number;

		/**
		 * The rate of packets dropped by the service on a scale of 100. 
		 * 
		 */
		public var drops:Number;


		/**
		 * An object which holds extended fields
		 */
		public var customFields:Object ;



		/**
		* The URL of the user's avatar. 
		*/
		public var usericonURL:String;


		/**
		 * @private
		 * 
		 * The sortability field for the status field.
		 * */
		public var activityCounter:Number;
		
		/**
		* @private
		* 
		* The user's status.
		* 
		* @see UserStatuses
		*/
		public var status:String;

		/**
		 * the voice status of the current user
		 */
		public var voiceStatus:String;
		
		/**
		 * @private 
		 */
		public var screenShareStatus:String;
		/**
		 * indicates whether or not the user is connected via RTMFP 
		 */
		public var playerVersion:String = Capabilities.version;
		/**
		 * Shows whether the connection is PeerToPeer for this user. All users need to have this true to have a p2p A/V streaming.
		 * This depends on various factors like player version, number of streams and firewalls.
		 * @deault true
		 */
		 public var isPeer:Boolean = true ;
		 /**
		 * Shows whether the connection is RTMFP.
		 * @default true
		 */
		 public var isRTMFP:Boolean = true ;
		/**
		 * [Read-only] The time the descriptor was last updated.
		 */
		public var lastUpdated:Number ;
	
		
		public function UserDescriptor()
		{
			customFields = new Object();
		}
		
		/**
		 * Creates a value object from the <code>userDescriptor</code> which is suitable 
		 * for storage as a simple object. Note that this only serializes the fields sent 
		 * via NODENAME_USER_LIST (others are updated separately)
		 * 
		 */
		public function createValueObject():Object
		{
			var returnVO:Object = new Object();
			
			if (userID!=null) {
				returnVO.userID = userID;
			}
			if (displayName!=null) {
				returnVO.displayName = displayName;
			}
			if (affiliation!=-1) {
				returnVO.affiliation = affiliation;
			}
			if (connection!=null) {
				returnVO.connection = connection;
			}
			if(usericonURL!=null) {
				returnVO.usericonURL = usericonURL;
			}
			
			if (role!=-1) {
				returnVO.role = role;
			}
			
			returnVO.isPeer = isPeer ;
			returnVO.isRTMFP = isRTMFP ;
			returnVO.playerVersion = playerVersion ;
			
			return returnVO;
		}
		
		/**
		 * Fills a <code>userDescriptor</code> based on a given value object.
		 * 
		 */
		public function readValueObject(p_valueObject:Object):void
		{
			for (var i:* in p_valueObject) {
				this[i] = p_valueObject[i];
			}
			
		}
		
	}
}

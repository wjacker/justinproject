package com.adobe.rtc.messaging
{
	
	/**
	 * UserRoles is a class for holding the constant values for standard user roles. 
	 * Roles are all stored as integers. Note that it is possible to set roles not 
	 * listed here both in NodeConfigurations and the various roles functions on 
	 * CollectionNode and UserManager.
	 * 
	 * @see com.adobe.rtc.sharedModel.CollectionNode
	 * @see com.adobe.rtc.messaging.NodeConfiguration
	 * @see com.adobe.rtc.sharedManagers.UserManager
	 */
	public class UserRoles
	{
		/**
		 * LOBBY can only subscribe to collections such as the ones used for knocking or for features in the lobby.
		 */
		public static const LOBBY:int = 5;
		
		/**
		 * VIEWER can subscribe to most nodes but cannot publish or configure. It corresponds to "NONE" in XEP-60.
	 	 */
		public static const VIEWER:int = 10;

		/**
		 * PUBLISHER can publish and subscribe to most nodes but cannot create, delete or configure nodes.
	 	 */
		public static const PUBLISHER:int = 50;

		/**
		 * OWNER can create, configure, and delete nodes, as well as publish and subscribe. 
		 * The OWNER is typically the person who created the room.
	 	 */
		public static const OWNER:int = 100;
	}
}
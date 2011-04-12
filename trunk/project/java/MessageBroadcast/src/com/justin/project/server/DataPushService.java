package com.justin.project.server;

import flex.messaging.MessageBroker;
import flex.messaging.MessageDestination;
import flex.messaging.io.ArrayCollection;
import flex.messaging.messages.AsyncMessage;
import flex.messaging.messages.Message;
import flex.messaging.services.MessageService;
import flex.messaging.services.messaging.adapters.ActionScriptAdapter;
import flex.messaging.util.UUIDUtils;

public class DataPushService extends ActionScriptAdapter{
	//private static DataGenerator thread;
	
	public DataPushService() 
	{
	}
	
	public void start()
	{
		MessageBroker msgBroker = MessageBroker.getMessageBroker(null);
		String clientID = UUIDUtils.createUUID();
		
		// creating a new async message and setting the
		// random generated number as content. 
		AsyncMessage msg = new AsyncMessage();
		
		// setting the destination for this message.
		msg.setDestination("dataPush");
		msg.setClientId(clientID);
		msg.setMessageId(UUIDUtils.createUUID());
		
		ClientData pushData = new ClientData();
		pushData.setDataType((int) Math.floor(Math.random() * 6));
		pushData.setDataSource(generatorArray());
		
		msg.setBody(pushData);
		
        MessageService service = (MessageService) msgBroker.getServer("message-service");
        MessageDestination messageDestination = (MessageDestination) service.getDestination("dataPush");
        service.sendPushMessageFromPeer(msg, messageDestination, true);
	}
	
	private ArrayCollection generatorArray()
	{
		ArrayCollection dataSource = new ArrayCollection();
		int n = (int) Math.floor((Math.random() * 100));
		for (int i = 0; i < n; i++) {
			UserData userData = new UserData();
			int randomeNumber = (int) Math.floor((Math.random() * 1000));
			userData.setName("Random Name" + randomeNumber);
			userData.setValue(randomeNumber);
			dataSource.add(userData);
		}
		return dataSource;
	}
	
	@Override
	public Object invoke(Message arg0) {
//		if (message.getBody().equals("New")) 
//		{ 
//			return randomNumbers; 
//		} 
//		else 
//		{ 
//			AsyncMessage newMessage = (AsyncMessage) message; 
//			newMessage.setBody(randomNumbers); 
//			MessageService msgService = (MessageService) getDestination().getService();
//			msgService.pushMessageToClients(newMessage, false); 
//			} return null;
//		}
		return null;
	}
}

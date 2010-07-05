package com.justin.project.server;

import java.util.Random;

import flex.messaging.MessageBroker;
import flex.messaging.io.ArrayCollection;
import flex.messaging.messages.AsyncMessage;
import flex.messaging.util.UUIDUtils;

public class DataGenerator extends Thread {
	
	public boolean running = true;

	public void run() {
		MessageBroker msgBroker = MessageBroker.getMessageBroker(null);
		String clientID = UUIDUtils.createUUID();
		while (running) {
			
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
			msgBroker.routeMessageToService(msg, null);
			try {
				Thread.sleep(60000);
				// 1 minute delay.
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
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
}

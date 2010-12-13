package com.justin.project.server;

import flex.messaging.io.ArrayCollection;

public class ClientData {
	private int dataType;
	private ArrayCollection dataSource;
	
	public Number getDataType() {
		return dataType;
	}
	public void setDataType(int dataType) {
		this.dataType = dataType;
	}
	public ArrayCollection getDataSource() {
		return dataSource;
	}
	public void setDataSource(ArrayCollection dataSource) {
		this.dataSource = dataSource;
	}
	
	
}

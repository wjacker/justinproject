package com.justin.service
{
    import com.ericfeminella.collections.HashMap;
    import com.ericfeminella.collections.IMap;

    import mx.core.FlexGlobals;
    import mx.logging.Log;
    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.remoting.RemoteObject;

    public class ServiceLocator
    {
        private static var _instance:ServiceLocator;
        private var channel:ChannelSet = new ChannelSet();
        private var serviceCache:IMap = new HashMap();

		private var _allowSendReuqest:Boolean = true;

        public static function getInstance():ServiceLocator
        {
            if (_instance == null)
            {
                _instance = new ServiceLocator();
            }

            return _instance;
        }

        public function ServiceLocator()
        {
        }

        public function getServices():Array
        {
            return serviceCache.getValues();
        }

        private function getChannelSetUri():String
        {
            return FlexGlobals.topLevelApplication.facade.sysConfig.getAmfEndPointUrl();
        }

        private function createService(serviceName:String):RemoteObject
        {
            var result:RemoteObject = new RemoteObject();

            var amf:AMFChannel = new AMFChannel();
            amf.uri = "http://flexmessagebroadcast.appspot.com/messagebroker/amf"
            channel.addChannel(amf);
            result.channelSet = channel;
            result.destination = serviceName;
            return result;
        }

        public function getService(serviceName:String):RemoteObject
        {
            if (!serviceCache.containsKey(serviceName))
            {
                serviceCache.put(serviceName, createService(serviceName));
            }
            return serviceCache.getValue(serviceName) as RemoteObject;
        }

		public function set allowSendReuqest(info:Boolean):void
		{
			_allowSendReuqest = info;
		}

		public function get allowSendReuqest():Boolean
		{
			return _allowSendReuqest;
		}
    }
}
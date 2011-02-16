package com.justin.service
{
    import mx.messaging.config.ServerConfig;
    import mx.rpc.AbstractOperation;
    import mx.rpc.AsyncToken;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    public class ServiceBroker
    {
        private var _locator:ServiceLocator = ServiceLocator.getInstance();
        private var _responder:IResponder;
        private var _destination:String;

        public function ServiceBroker(responder:IResponder = null, destination:String = null)
        {
            this._destination = destination;
            this._responder = responder;
        }

        public function get responder():IResponder
        {
            return this._responder;
        }

        public function set responder(value:IResponder):void
        {
            this._responder = value;
        }

        public function get destination():String
        {
            return this._destination;
        }

        public function set destination(value:String):void
        {
            _destination = value;
        }

        public function getService():RemoteObject
        {
            var result:RemoteObject = _locator.getService(destination);
            result.makeObjectsBindable = true;
            result.showBusyCursor = true;
            return result;
        }

        public function invoke(operationName:String, ... args):AsyncToken
        {
			if(!locator.allowSendReuqest) return null;

            var service:RemoteObject = getService();
            var op:AbstractOperation = service.getOperation(operationName);
            op.arguments = args;
            var token:AsyncToken = op.send();
            token.addResponder(responder);
            token.operation = operationName;
            return token;
        }

        public function invokeWithHandler(resultHandler:Function, faultHandler:Function, operationName:String,  ... args):AsyncToken
        {
			if(!locator.allowSendReuqest) return null;

            var service:RemoteObject = getService();
            var op:AbstractOperation = service.getOperation(operationName);
            op.arguments = args;
            var token:AsyncToken = op.send();
            token.resultHandler = resultHandler;
            token.faultHandler = faultHandler;
            token.addResponder(responder);
            token.operation = operationName;
            return token;
        }

        /*public function login():AsyncToken
        {
            var service:RemoteObject = getService();
            if (service.channelSet == null)
            {
                service.channelSet = ServerConfig.getChannelSet(this._destination);
            }
            var token:AsyncToken = service.channelSet.login(currentUser.username, currentUser.password);
            token.addResponder(_responder);
            token.operation = ServiceConstants.LOGIN;
            return token;
        }*/

        /*public function logout():AsyncToken
        {
            var service:RemoteObject = getService();
            if (service.channelSet != null)
            {
                var token:AsyncToken = service.channelSet.logout();
                token.addResponder(responder);
                token.operation = ServiceConstants.LOGOUT;
                return token;
            }
            return null;
        }*/

		public function get locator() : ServiceLocator
		{
			return _locator;
		}
    }
}
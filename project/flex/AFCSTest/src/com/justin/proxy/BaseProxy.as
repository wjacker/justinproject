package com.justin.proxy
{
    import com.justin.Constants;
    import com.justin.service.ServiceBroker;

    import mx.controls.Alert;
    import mx.core.FlexGlobals;
    import mx.events.CloseEvent;
    import mx.managers.CursorManager;
    import mx.messaging.messages.RemotingMessage;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class BaseProxy implements IResponder
    {
        protected var remoteDelegate: ServiceBroker;
        protected var destination: String;

        public function BaseProxy()
        {
            remoteDelegate = new ServiceBroker(this, destination);
        }

        protected function resultHandler(resultEvent: ResultEvent): void
        {
        }

        protected function faultHandler(faultEvent: FaultEvent):void
        {
            Alert.show("code:\n" + faultEvent.fault.faultCode + "\n\nMessage:\n" + faultEvent.fault.faultString + "\n\nDetail:\n" + faultEvent.fault.faultDetail, "Error");
        }

        public function result(data: Object): void
        {
            CursorManager.removeBusyCursor();
            if (data == null || !(data is ResultEvent))
                return;

            if(data.token && data.token.resultHandler)
                data.token.resultHandler(data as ResultEvent)
            else
                resultHandler(data as ResultEvent);
        }

        public function fault(info:Object): void
        {
            CursorManager.removeBusyCursor();
            if (info == null || !(info is FaultEvent))
                return;

            var event:FaultEvent = FaultEvent(info);

            if(event.token && event.token.faultHandler)
                event.token.faultHandler(info);
            else
                faultHandler(event as FaultEvent);
        }

        public function getRemoteDelegate():ServiceBroker
        {
            return remoteDelegate;
        }
    }
}
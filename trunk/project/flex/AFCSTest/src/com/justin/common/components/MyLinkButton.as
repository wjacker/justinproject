package com.justin.common.components
{
    import flash.events.*;
    import flash.net.*;
    import mx.controls.*;

    public class MyLinkButton extends LinkButton
    {
        public var linkURL:String;

        public function MyLinkButton()
        {
            this.addEventListener(MouseEvent.CLICK, openNewWindow);
        }

        private function openNewWindow(event:MouseEvent) : void
        {
            navigateToURL(new URLRequest(this.linkURL), "quote");
            return;
        }

    }
}

package com.justin.common.components
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.ui.*;
    import flash.utils.*;

    import mx.containers.Canvas;
    import mx.core.*;
    import mx.utils.GraphicsUtil;

    import spark.primitives.Graphic;
    import spark.primitives.Line;


    [Style(name="audioLineColor", type="uint", format="Color")]
    [Style(name="audioFillColor", type="uint", format="Color")]
    [Style(name="audioGradientFillColor", type="uint", format="Array")]
    [Style(name="audioGradientFillAlphas", type="uint", format="Array")]
    [Style(name="audioGradientFillRatios", type="uint", format="Array")]


    public class Visualization extends UIComponent
    {
        public var bars:uint = 256;
        private var display:UIComponent;
        public var channel:String = "mono";
        private var _audioFillColor:uint = 0;
        private var spectrumData:ByteArray;
        public var peak:Number = 0;
        private var myContextMenu:ContextMenu;
        //public var bitmap:Bitmap;
        private var rc:Number = 0;
        private var _audioLineColor:uint = 0;
        //public var bitmapData:BitmapData;
        public var type:String = "line";
        private var rp:Number = 0;
        private var gain:uint = 1;
        private var _blurFilter:BlurFilter = new BlurFilter();
        private var gradientBar:Canvas;
        private var _audioGradientFillColor:Array = [0xFF0000, 0xFF0000, 0x00FF00];
        private var _audioGradientFillAlphas:Array = [1,0.8,1];
        private var _audioGradientFillRatios:Array = [0,125,255];

        public function Visualization()
        {
            _blurFilter.blurX = 0;
            _blurFilter.blurY = 0;
            display = new UIComponent();
            //bitmapData = new BitmapData(2, 2, true, 0);
            //bitmap = new Bitmap(bitmapData);
            gradientBar = new Canvas();
            gradientBar.setStyle("backgroundColor", 0x000000);
            gradientBar.setStyle("backgroundAlpha",0);
            spectrumData = new ByteArray();
            addEventListener(Event.ENTER_FRAME, enterFrameListener);
            myContextMenu = new ContextMenu();
            myContextMenu.hideBuiltInItems();
            var builtInItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
            builtInItems.print = true;
            var lineMenuItem:ContextMenuItem = new ContextMenuItem("Line");
            var waveMenuItem:ContextMenuItem = new ContextMenuItem("Wave");
            var barsMenuItem:ContextMenuItem = new ContextMenuItem("Bars");
            myContextMenu.customItems.push(lineMenuItem);
            myContextMenu.customItems.push(waveMenuItem);
            myContextMenu.customItems.push(barsMenuItem);
            lineMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
            waveMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
            barsMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
            gradientBar.contextMenu = myContextMenu;
            return;
        }

        private function drawEQ() : void
        {
            var loc_y:Number;
            var j:uint = 0;
            var i:Number = 0;
            var barItemWidth:Number = rp * 256 / bars;
            var barNumber:uint = 0;
            var g:Graphics = gradientBar.graphics;
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox(this.width, this.height, Math.PI / 2);
            g.clear();
            g.beginGradientFill(GradientType.LINEAR, _audioGradientFillColor, _audioGradientFillAlphas, _audioGradientFillRatios, matrix);
            while (barNumber < bars)
            {

                i = 0;
                j = 0;
                while (j < Math.floor(256 / bars))
                {

                    i = i + spectrumData.readFloat();
                    if (Math.abs(i) > peak)
                    {
                        peak = Math.abs(i);
                    }
                    j = j + 1;
                }
                i = i / Math.floor(256 / bars);
                loc_y = Math.max(rc * 2 - i * rc * 2 * gain, 5);
                if(getStyle("audioGradientFillColor") is Array)
                    _audioGradientFillColor = getStyle("audioGradientFillColor");

                if(getStyle("audioGradientFillAlphas") is Array)
                    _audioGradientFillAlphas = getStyle("audioGradientFillAlphas");

                if(getStyle("audioGradientFillRatios") is Array)
                    _audioGradientFillRatios = getStyle("audioGradientFillRatios");

                g.drawRect(barItemWidth / 8 + barNumber * barItemWidth, loc_y, barItemWidth / 2 + barItemWidth / 4, rc * 2 - loc_y);
                g.drawRect(barItemWidth / 8 + barNumber * barItemWidth, loc_y, barItemWidth / 2 + barItemWidth / 4, 1);
                barNumber = barNumber + 1;
            }
            g.endFill();
            gradientBar.filters = [_blurFilter];
            return;
        }

        private function enterFrameListener(event:Event) : void
        {
            var rect:Rectangle;
            var i:int;
            var j:int;
            var e:* = event;
            try
            {
                //rect = bitmapData.rect;
                SoundMixer.computeSpectrum(spectrumData, type == "bars", 0);
                //dispatchEvent(new Event("beforeVisualization", true));
                /*if (!hasEventListener("beforeVisualization"))
                {
                bitmapData.fillRect(rect, 0);
                }*/
                switch(channel)
                {
                    case "mono":
                    {
                        toMono();
                    }
                    case "left":
                    {
                        if (type == "line" || type == "wave")
                        {
                            drawWave(1);
                        }
                        if (type == "wave")
                        {
                            spectrumData.position = 0;
                            drawWave(-1);
                        }
                        if (type == "bars")
                        {
                            drawEQ();
                        }
                        break;
                    }
                    case "right":
                    {
                        i;
                        while (i < 256)
                        {

                            spectrumData.readFloat();
                            i = (i + 1);
                        }
                        if (type == "line" || type == "wave")
                        {
                            drawWave(1);
                        }
                        if (type == "wave")
                        {
                            spectrumData.position = 0;
                            j;
                            while (j < 256)
                            {

                                spectrumData.readFloat();
                                j = (j + 1);
                            }
                            drawWave(-1);
                        }
                        if (type == "bars")
                        {
                            drawEQ();
                        }
                        break;
                    }
                    case "stereo":
                    {
                        if (type == "line" || type == "wave")
                        {
                            drawWave(1);
                            drawWave(1);
                        }
                        if (type == "wave")
                        {
                            spectrumData.position = 0;
                            drawWave(-1);
                            drawWave(-1);
                        }
                        if (type == "bars")
                        {
                            drawEQ();
                            drawEQ();
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                //bitmapData.applyFilter(bitmapData, rect, new Point(0, 0), new BlurFilter(bitmapData.width / 256, bitmapData.width / 256, 1));
                //dispatchEvent(new Event("afterVisualization", true));
            }
            catch (err:Error)
            {

            }
            return;
        }

        private function menuItemSelectHandler(event:ContextMenuEvent) : void
        {
            setType(event.target.caption);
            return;
        }

        private function toMono() : void
        {
            var _loc_1:ByteArray = null;
            var _loc_2:ByteArray = null;
            var _loc_3:uint = 0;
            spectrumData.position = 0;
            if (spectrumData.length == 2048)
            {
                _loc_1 = new ByteArray();
                _loc_2 = new ByteArray();
                spectrumData.readBytes(_loc_1, 0, 1024);
                spectrumData.readBytes(_loc_2, 0, 1024);
                spectrumData = new ByteArray();
                _loc_3 = 0;
                while (_loc_3 < 256)
                {

                    spectrumData.writeFloat((_loc_1.readFloat() + _loc_2.readFloat()) / 2);
                    _loc_3 = _loc_3 + 1;
                }
                spectrumData.position = 0;
            }
            return;
        }

        private function drawWave(param1:Number = 1) : void
        {
            var _loc_2:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_3:* = rc;
            peak = 0;
            var _loc_4:uint = 0;
            var g:Graphics = gradientBar.graphics;
            g.clear();
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox(this.width, this.height, Math.PI / 2);
            //g.beginGradientFill(GradientType.LINEAR, _audioGradientFillColor, _audioGradientFillAlphas, _audioGradientFillRatios, matrix);
            while (_loc_4 < 256)
            {

                _loc_5 = spectrumData.readFloat();
                _loc_2 = rc + _loc_5 * rc * param1 * -1;
                if (type == "wave")
                {
                    g.beginFill(4278190080 | _audioFillColor);
                    g.drawRect(_loc_4 * rp, Math.min(_loc_2, rc), rp, Math.abs(rc - _loc_2));
                    //bitmapData.fillRect(new Rectangle(_loc_4 * rp, Math.min(_loc_2, rc), rp, Math.abs(rc - _loc_2)), 4278190080 | _audioFillColor);
                }
                g.beginFill(4278190080 | _audioLineColor);
                g.drawRect(_loc_4 * rp, _loc_2, rp, 1 + Math.abs(_loc_3 - _loc_2));
                //bitmapData.fillRect(new Rectangle(_loc_4 * rp, _loc_2, rp, 1 + Math.abs(_loc_3 - _loc_2)), 4278190080 | _audioLineColor);
                _loc_3 = _loc_2;
                if (Math.abs(_loc_5) > peak)
                {
                    peak = Math.abs(_loc_5);
                }
                _loc_4 = _loc_4 + 1;
            }
            g.endFill();
            gradientBar.filters = [];
        }

        override protected function createChildren() : void
        {
            //addChild(bitmap);
            addChild(gradientBar);
            return;
        }

        private function setType(param1:String) : void
        {
            type = param1.toLowerCase();
            return;
        }

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("borderThickness") * 2;
            gradientBar.width = param1;
            gradientBar.height = param2;
            if (param1 - _loc_3 > 0 && param2 - _loc_3 > 1)
            {
                //bitmapData = new BitmapData(param1 - _loc_3, param2 - _loc_3, true, 0);
            }
            //bitmap.bitmapData = bitmapData;
            _audioLineColor = getStyle("audioLineColor");
            _audioFillColor = getStyle("audioFillColor");
            rc = (param2 - _loc_3) / 2;
            rp = (param1 - _loc_3) / 256;
            return;
        }

    }
}

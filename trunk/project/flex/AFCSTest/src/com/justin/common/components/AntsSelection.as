package com.justin.common.components
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    import mx.core.*;
    import mx.events.*;

    import spark.primitives.Graphic;

    public class AntsSelection extends UIComponent
    {
        private var __h:Number;
        private var __w:Number;
        private var __antsBMP:BitmapData;
        private var __x:Number;
        private var __y:Number;
        private var __matrix:Matrix;
        private var __lineBitmap:Bitmap;
        private var __zoom:Number;
        private var __animateTimer:Timer;
        private var __ants:UIComponent;
        private var __hitTester:UIComponent;
        private var __line:UIComponent;
        private var __vertices:Array;
        private var __enabled:Boolean;
        private var __lineBitmapData:BitmapData;
        private var __hasSelection:Boolean;
        private var __lineGraphics:UIComponent;
        private var __angleNum:Number;
        private var __maxCircle:Number;
        public var antsAngle:Number;
        public var antsColor:Array;
        public var antsLength:Number;

        public function AntsSelection(antsAngle:Number = 45, antsLength:Number = 3, antsColor:Array = null):void
        {
            this.antsAngle = antsAngle;
            this.antsLength = antsLength;
            if(this.antsColor == null)
                this.antsColor = [0xFF000000, 0xFFFFFFFF];
            else
                this.antsColor = antsColor;
            blendMode = BlendMode.LAYER;
            this.__vertices = [];
            this.__matrix = new Matrix();
            this.__angleNum = this.antsAngle / 180 * Math.PI;
            this.__matrix.rotate(this.__angleNum);
            this.__animateTimer = new Timer(50, 0);
            this.__animateTimer.addEventListener("timer", this.animateAnts);
            addEventListener(ResizeEvent.RESIZE, this.resize);
            return;
        }

        public function set vertices(param1:Array) : void
        {
            this.__vertices = param1;
            this.createSelection(this.__zoom, this.__vertices);
            this.drawSelection();
            return;
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.__enabled = param1;
            return;
        }

        public function get hasSelection() : Boolean
        {
            return this.__hasSelection;
        }

        public function get selectionWidth() : Number
        {
            return this.__w;
        }

        public function applyAntsAngle(newAngle:Number):void
        {
            this.antsAngle = newAngle;
            this.__angleNum = this.antsAngle / 180 * Math.PI;
            this.__matrix = new Matrix();
            this.__matrix.rotate(this.__angleNum);
            this.drawSelection();
        }

        public function applyAntsColor(newColorArray:Array):void
        {
            this.antsColor = newColorArray;
            this.__antsBMP = new BitmapData(2 * this.antsLength, 2 * this.antsLength);
            var topLeftRect:Rectangle = new Rectangle(0, 0, this.antsLength, this.antsLength);
            var topRightRect:Rectangle = new Rectangle(this.antsLength, 0, this.antsLength, this.antsLength);
            var bottomLeftRect:Rectangle = new Rectangle(0, this.antsLength, this.antsLength, this.antsLength);
            var bottomRightRect:Rectangle = new Rectangle(this.antsLength, this.antsLength, this.antsLength, this.antsLength);
            this.__antsBMP.fillRect(topLeftRect, antsColor[0]);
            this.__antsBMP.fillRect(topRightRect, antsColor[1]);
            this.__antsBMP.fillRect(bottomLeftRect, antsColor[0]);
            this.__antsBMP.fillRect(bottomRightRect, antsColor[1]);
            this.drawSelection();
        }

        override protected function createChildren() : void
        {
            this.__antsBMP = new BitmapData(2 * this.antsLength, 2 * this.antsLength);
            var topLeftRect:Rectangle = new Rectangle(0, 0, this.antsLength, this.antsLength);
            var topRightRect:Rectangle = new Rectangle(this.antsLength, 0, this.antsLength, this.antsLength);
            var bottomLeftRect:Rectangle = new Rectangle(0, this.antsLength, this.antsLength, this.antsLength);
            var bottomRightRect:Rectangle = new Rectangle(this.antsLength, this.antsLength, this.antsLength, this.antsLength);
            this.__antsBMP.fillRect(topLeftRect, antsColor[0]);
            this.__antsBMP.fillRect(topRightRect, antsColor[1]);
            this.__antsBMP.fillRect(bottomLeftRect, antsColor[0]);
            this.__antsBMP.fillRect(bottomRightRect, antsColor[1]);
            this.__ants = new UIComponent();
            addChild(this.__ants);
            this.__line = new UIComponent();
            this.__line.blendMode = BlendMode.ALPHA;
            this.__line.cacheAsBitmap = true;
            addChild(this.__line);
            this.__lineGraphics = new UIComponent();
            this.__lineGraphics.visible = false;
            this.__line.addChild(this.__lineGraphics);
            this.__lineBitmapData = new BitmapData(10, 10, true, 0);
            this.__lineBitmap = new Bitmap(this.__lineBitmapData, "auto", true);
            this.__line.addChild(this.__lineBitmap);
            this.__hitTester = new UIComponent();
            this.__hitTester.visible = false;
            addChild(this.__hitTester);
            return;
        }

        public function set hasSelection(value:Boolean) : void
        {
            this.__hasSelection = value;
            if (value)
            {
                this.createSelection(this.__zoom);
            }
            else
            {
                this.clearSelection();
            }
            return;
        }

        public function addVertex(newPoint:Point) : void
        {
            this.__vertices.push(newPoint);
            this.drawSelection();
            return;
        }

        public function set zoom(value:Number) : void
        {
            this.__zoom = value;
            this.drawSelection();
            dispatchEvent(new Event("selectionChange"));
            return;
        }

        private function drawSelection() : void
        {
            var pointX:Number = NaN;
            var pointY:Number = NaN;
            var selectionStartX:Number = NaN;
            var selectionStartY:Number = NaN;
            var selectionEndX:Number = NaN;
            var selectionEndY:Number = NaN;
            var i:uint = 0;
            var verticesLength:uint = this.__vertices.length;
            var lineGraphics:Graphics = this.__lineGraphics.graphics;
            lineGraphics.clear();
            var hitTesterGraphics:Graphics = this.__hitTester.graphics;
            hitTesterGraphics.clear();
            if (verticesLength > 0)
            {
                pointX = this.__vertices[0].x;
                pointY = this.__vertices[0].y;
                lineGraphics.lineStyle(0, 0, 1, false, "none");
                lineGraphics.moveTo(pointX * this.__zoom, pointY * this.__zoom);
                hitTesterGraphics.beginFill(0, 1);
                hitTesterGraphics.moveTo(pointX * this.__zoom, pointY * this.__zoom);
                selectionStartX = pointX;
                selectionStartY = pointY;
                selectionEndX = pointX;
                selectionEndY = pointY;
                i = 1;

                var currentPointX:Number = NaN;
                var currentPointY:Number = NaN;
                while (i < verticesLength)
                {

                    currentPointX = Point(this.__vertices[i]).x;
                    currentPointY = Point(this.__vertices[i]).y;
                    lineGraphics.lineTo(currentPointX * this.__zoom, currentPointY * this.__zoom);
                    hitTesterGraphics.lineTo(currentPointX * this.__zoom, currentPointY * this.__zoom);
                    selectionStartX = Math.min(currentPointX, selectionStartX);
                    selectionStartY = Math.min(currentPointY, selectionStartY);
                    selectionEndX = Math.max(currentPointX, selectionEndX);
                    selectionEndY = Math.max(currentPointY, selectionEndY);
                    i = i + 1;
                }
                this.__x = selectionStartX;
                this.__y = selectionStartY;
                this.__w = selectionEndX - selectionStartX;
                this.__h = selectionEndY - selectionStartY;
            }
            else
            {
                this.__h = 0;
                this.__w = 0;
                this.__y = 0;
                this.__x = 0;
            }

            this.__lineBitmapData.fillRect(this.__lineBitmapData.rect, 0);
            this.__lineBitmapData.draw(this.__lineGraphics);
            lineGraphics.clear();
            return;
        }

        public function offsetVertices(x:Number, y:Number) : void
        {
            var i:uint = 0;
            var verticesLength:uint = this.__vertices.length;
            if (verticesLength > 0)
            {
                while (i < verticesLength)
                {

                    Point(this.__vertices[i]).offset(x, y);
                    i = i + 1;
                }
                this.drawSelection();
            }
            return;
        }

        private function resize(event:ResizeEvent) : void
        {
            if(unscaledWidth <= 0 || unscaledHeight <= 0)
                return;
            this.__lineBitmapData.dispose();
            this.__lineBitmapData = new BitmapData(unscaledWidth, unscaledHeight, true, 0);
            this.__lineBitmap.bitmapData = this.__lineBitmapData;
            this.drawSelection();
            return;
        }

        public function clearSelection() : void
        {
            this.__vertices = [];
            this.__ants.graphics.clear();
            this.__hitTester.graphics.clear();
            this.__lineBitmapData.fillRect(this.__lineBitmapData.rect, 0);
            this.__matrix.ty = 0;
            this.__hasSelection = false;
            this.__animateTimer.stop();
            dispatchEvent(new Event("selectionChange"));
            return;
        }

        override public function get enabled() : Boolean
        {
            return this.__enabled;
        }

        public function get selectionY() : Number
        {
            return this.__y;
        }

        public function get selectionX() : Number
        {
            return this.__x;
        }

        public function get selectionHeight() : Number
        {
            return this.__h;
        }

        public function get zoom() : Number
        {
            return this.__zoom;
        }

        public function createSelection(param1:Number, param2:Array = null) : void
        {
            this.__zoom = param1;
            this.__hasSelection = true;
            this.__maxCircle = 20 * this.antsLength * Math.abs(Math.sin(this.__angleNum));
            this.__animateTimer.start();
            if (param2 != null)
            {
                this.__vertices = param2;
                this.drawSelection();
            }
            else
            {
                this.__vertices = [];
            }
            dispatchEvent(new Event("selectionChange"));
            return;
        }

        private function animateAnts(event:TimerEvent) : void
        {
            var antsGraphics:Graphics = null;
            if (this.__enabled)
            {
                if (this.__matrix.ty >= this.__maxCircle)
                {
                    this.__matrix.ty = __matrix.ty - this.__maxCircle;
                }
                else
                {
                    (this.__matrix.ty += 1);
                }
                antsGraphics = this.__ants.graphics;
                antsGraphics.clear();
                antsGraphics.beginBitmapFill(this.__antsBMP, this.__matrix, true, true);
                antsGraphics.moveTo(0, 0);
                antsGraphics.lineTo(width, 0);
                antsGraphics.lineTo(width, height);
                antsGraphics.lineTo(0, height);
                antsGraphics.lineTo(0, 0);
                antsGraphics.endFill();
            }
            return;
        }

        public function cloneVertices() : Array
        {
            var cloneVertices:Array = [];
            var i:uint = 0;
            var verticesLength:uint = this.__vertices.length;
            if (verticesLength > 0)
            {
                while (i < verticesLength)
                {

                    cloneVertices.push(Point(this.__vertices[i]).clone());
                    i++;
                }

            }
            return cloneVertices;
        }

        public function get vertices() : Array
        {
            return this.__vertices;
        }

        public function mouseWithinSelection() : Boolean
        {
            if (!this.__hasSelection)
            {
                return false;
            }
            var _loc_1:* = new Point(stage.mouseX, stage.mouseY);
            return this.__hitTester.hitTestPoint(_loc_1.x, _loc_1.y, true);
        }

        public function pointInSelection(point:Point,shapeFlg:Boolean = false) : Boolean
        {
            if (!this.__hasSelection)
            {
                return false;
            }
            return this.__hitTester.hitTestPoint(point.x, point.y, shapeFlg);
        }

        private function getARGBBy(rgb:uint, newAlpha:uint):uint
        {
            var argb:uint = 0;
            argb += (newAlpha<<24);
            argb += (rgb);
            return argb;
        }

        public function getToolTipString():String
        {
            return "Selection";
        }

    }
}

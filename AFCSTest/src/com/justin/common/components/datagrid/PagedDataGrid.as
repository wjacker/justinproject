package com.justin.common.components.datagrid
{
    import flash.utils.clearInterval;
    import flash.utils.setInterval;
    
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.dataGridClasses.DataGridHeader;
    import mx.core.mx_internal;
    import mx.events.DataGridEvent;
    import mx.events.IndexChangedEvent;
    import mx.events.ScrollEvent;
    use namespace mx_internal;

    public class PagedDataGrid extends DataGrid
    {
        protected var collectionMirror:ValueListHandler;
        private var cTotal:Number=0;
        private var appendResolved:Boolean=true;
        private var lastScrollPosition:Number=0;
        private var accurateScrollPosition:Number=0;
        private var currentSort:String="ASC";
        private var scrollInter:Number;
        private var currentField:String="";
        private var fromSort:Boolean=false;
        public var delay:Number=300;



        public function PagedDataGrid()
        {
            super();
            initializeComponent();
        }

        private function initializeComponent():void
        {
            addEventListener(ScrollEvent.SCROLL, scrollListener);
            addEventListener(DataGridEvent.HEADER_RELEASE, gridHeaderReleased);
            addEventListener(IndexChangedEvent.HEADER_SHIFT, gridColumnShift);
            collectionMirror=new ValueListHandler();
        }

        private function handleScrollRange(range:Number, down:Boolean):void
        {
            clearInterval(scrollInter);
            var realIndex:Number;
            try
            {
                realIndex=collectionMirror.rangeIsValid(range, rowCount)
                if (realIndex != -1)
                {
                    if (appendResolved)
                    {
                        appendResolved=false;
                        lastScrollPosition=realIndex;
                        dispatchEvent(new PageableGridEvent(PageableGridEvent.OUT_OF_RANGE, {start: realIndex, sortType: currentSort, field: currentField}));
                    }
                }
            }
            catch (e:Error)
            {
            }
        }

        private function retrieveDataNeeded():Boolean
        {
            return cTotal <= rowCount;
        }

        private function gridHeaderReleased(evt:DataGridEvent):void
        {
            if (retrieveDataNeeded())
                return;
            if (cTotal != 0)
            {
                evt.preventDefault();
                fromSort=true;
                currentSort=(currentSort == "ASC") ? "DESC" : "ASC";
                currentField=evt.dataField;
                var actColumn:DataGridColumn=columns[evt.columnIndex];
                super.mx_internal::lastSortIndex=sortIndex;
                super.mx_internal::sortIndex=evt.columnIndex;
                super.mx_internal::sortDirection=currentSort;
                accurateScrollPosition=this.scrollInter;
                accurateScrollPosition=verticalScrollBar.scrollPosition;
                cheatSortArrow(actColumn, sortIndex);
                dispatchEvent(new PageableGridEvent(PageableGridEvent.SORT, {start: accurateScrollPosition, sortType: currentSort, field: currentField}));
                if (appendResolved)
                {
                    appendResolved=false;
                }
            }
        }

        private function gridColumnShift(evt:IndexChangedEvent):void
        {
            super.mx_internal::sortIndex=evt.newIndex;
            super.mx_internal::lastSortIndex=evt.oldIndex;
            cheatSortArrow(evt.target as DataGridColumn, sortIndex);
        }

        private function scrollListener(evt:ScrollEvent):void
        {
            if (cTotal)
            {
                if (collectionMirror.length < cTotal)
                {
                    clearInterval(scrollInter);
                    scrollInter=setInterval(handleScrollRange, delay, evt.position, evt.delta > 0);
                }
            }
            accurateScrollPosition=evt.position;
        }

        public function set collectionLength(n:Number):void
        {
            cTotal=n;
        }

        public function get collectionLength():Number
        {
            return cTotal;
        }

        public function appendData(value:Object):void
        {
            appendResolved=true;
            if (fromSort)
            {
                fromSort=false;
                appendSortedData(value);
            }
            else
            {
                collectionMirror.updateCollectionElements(value, lastScrollPosition);
                clearInterval(scrollInter);
                scrollInter=setInterval(handleScrollRange, delay, accurateScrollPosition, false);
            }
        }

        private function appendSortedData(value:Object):void
        {
            collectionMirror.setSortedReference(value, cTotal, accurateScrollPosition);
            appendResolved=true;
        }

        override public function set dataProvider(value:Object):void
        {
            super.dataProvider=collectionMirror.setReference(value, cTotal);
        }

        public function get sorted():Boolean
        {
            return !(currentSort == "ASC");
        }

        public function get sortedField():Object
        {
            if (currentField == "")
                return null;

            return {sortType: currentSort, field: currentField};
        }

        private function cheatSortArrow(activeColumn:DataGridColumn, activeIndex:Number):void
        {
            var dgHeager:DataGridHeader=header as DataGridHeader;
            dgHeager.mx_internal::_placeSortArrow();
        }

        override protected function setRowCount(v:int):void
        {
            var rowCountChanged:Boolean=(rowCount < v && v > 7);
            var rowCountDiff:int=v - rowCount;
            super.setRowCount(v);
            if (rowCountChanged)
            {
                dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL, false, false, null, Math.max(0, accurateScrollPosition - rowCountDiff)));
            }
        }

    }
}
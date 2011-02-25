package com.lombardrisk.validator
{
    public class FunctionOperator extends Operator
    {
        public var dimension:int;
        public function FunctionOperator(name:String)
        {
            super(name);
        }

        public function getDimension():int
        {
            return dimension;
        }

        public function eval(values:Array):Number
        {
            throw new Error("this method must implement in child");
        }
    }
}
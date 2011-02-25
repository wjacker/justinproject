package
{
    public class Match
    {
        public var value:String;
        public var index:int;
        public var length:int;
        public var css:String;

        public function Match(value:String, index:int, css:String)
        {
            this.value = value;
            this.index = index;
            this.length = value.length;
            this.css = css;
        }
    }
}
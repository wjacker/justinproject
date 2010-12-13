package event
{
	import flash.events.Event;

	public class RssChangeEvent extends Event
	{
		public static const RSS_CHANGE_EVENT = "rssChanged";
		public var rss : RssVO;
		public function RssChangeEvent(rss : RssVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.rss = rss;
			super(RSS_CHANGE_EVENT, bubbles, cancelable);
		}
		
	}
}
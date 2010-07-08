package com.adobe.rtc.util
{
	import com.adobe.rtc.session.ConnectSession;

	/**
	 * Utility class for debugging.
	 * 
	 * 
	 */
	public class DebugUtil
	{
		//include "../core/Version.as";
		/**
		 * A custom trace function that can be defined by the developer. It can turned on and off using the <code>suppressDebugTraces</code>.
		 */ 
		public static var traceFunction:Function;
		
		/**
		 * A flag to turn on/off tracing. The flag is used in conjunction with the <code>debugTrace</code> method. The traces are turned off if true.
		 * @default false
		 */ 
		public static var suppressDebugTraces:Boolean = false;
		
		/**
		 * Takes an object and traces its content and the type of each member in a tree form.
		 * In additional to the two standard parameters, two optional parameters may be passed in:
		 * <ul>
		 * <li>A prefix to add to all traces; it's typically just "".</li>
		 * <li>A function that should be used for tracing instead of <code>trace</code>. For example, 
		 * this is useful if you'd like the output to go to a TextArea component.</li>
		 * </ul>
		 * 
		 * @param p_name The name of the object. 
		 * @param p_obj The object to trace. 
		 */
		
		public static function dumpObject(p_name:String, p_obj:Object, ...rest):void
		{
			var prefix:String = (rest.length == 0) ? "  " : rest[0];
			var f:Function = (rest.length == 2) ? rest[1] : trace;
			
			f(prefix+"."+p_name+" ["+typeof(p_obj)+"]");
			f(prefix+prefix+"\\\\");
			for (var i:* in p_obj) {
				if (typeof(p_obj[i]) == "object") {
					DebugUtil.dumpObject(i, p_obj[i], prefix+prefix, f);
				} else
					f(prefix+prefix+"."+i+" ["+typeof(p_obj[i])+"]= "+p_obj[i]);
			}
		}

		/**
		 * Similar to <code>dumpObject()</code> but it's not recursive, and it only traces 
		 * the first level of the object that's passed in. In additional to the two 
		 * standard parameters, two optional parameters may be passed in:
		 * <ul>
		 * <li>A prefix to add to all traces; it's typically just "".</li>
		 * <li>A function that should be used for tracing instead of <code>trace</code>. For example, 
		 * this is useful if you'd like the output to go to a TextArea component.</li>
		 * </ul>
		 * 
		 * @param p_name The name of the object. 
		 * @param p_obj The object to trace. 
		 */
		public static function dumpObjectShallow(p_name:String, p_obj:Object, ...rest):void
		{
			var prefix:String = (rest.length == 0) ? "  " : rest[0];
			var f:Function = (rest.length == 2) ? rest[1] : trace;

			f(prefix+"."+p_name+" ["+typeof(p_obj)+"]");
			f(prefix+prefix+"\\\\");
			for (var i:* in p_obj) {
				f(prefix+prefix+"."+i+" ["+typeof(p_obj[i])+"]= "+p_obj[i]);
			}
		}
		
		/**
		 * A custom log function that can be turned on/off using the <code>suppressDebugTraces</code>. The traces are outputted only when <code>suppressDebugTraces</code> is false.
		 * The default trace() function is used if the <code>traceFunction</code> is not defined.
		 */ 
		public static function debugTrace(p_traceString:String):void
		{
			if (!suppressDebugTraces) {
				if (traceFunction != null) {
					traceFunction(p_traceString);
				} else {
					trace(p_traceString);
				}
			}
		}
		
		
	}
}


import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import mx.controls.TextInput;
import mx.controls.Label;

class BindableProperty
{
	/*
	 * generated bindable wrapper for property input (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'input' moved to '_100358090input'
	 */

    [Bindable(event="propertyChange")]
    public function get input():mx.controls.TextInput
    {
        return this._100358090input;
    }

    public function set input(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._100358090input;
        if (oldValue !== value)
        {
            this._100358090input = value;
           if (this.hasEventListener("propertyChange"))
               this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "input", oldValue, value));
        }
    }

	/*
	 * generated bindable wrapper for property outupt (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'outupt' moved to '_1005507797outupt'
	 */

    [Bindable(event="propertyChange")]
    public function get outupt():mx.controls.Label
    {
        return this._1005507797outupt;
    }

    public function set outupt(value:mx.controls.Label):void
    {
    	var oldValue:Object = this._1005507797outupt;
        if (oldValue !== value)
        {
            this._1005507797outupt = value;
           if (this.hasEventListener("propertyChange"))
               this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "outupt", oldValue, value));
        }
    }

	/*
	 * generated bindable wrapper for property veriableInput (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'veriableInput' moved to '_1833326634veriableInput'
	 */

    [Bindable(event="propertyChange")]
    public function get veriableInput():mx.controls.TextInput
    {
        return this._1833326634veriableInput;
    }

    public function set veriableInput(value:mx.controls.TextInput):void
    {
    	var oldValue:Object = this._1833326634veriableInput;
        if (oldValue !== value)
        {
            this._1833326634veriableInput = value;
           if (this.hasEventListener("propertyChange"))
               this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "veriableInput", oldValue, value));
        }
    }



}

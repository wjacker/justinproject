package
{
	import flash.events.TextEvent;

	import mx.controls.TextInput;

	public class NumericTextInput extends TextInput
	{
		public var matchRegex : RegExp =  /^-?(([1-9][0-9]{0,26}\.?\d{0,2})|(0\.\d{1,2}))$/gm;
        public var inputRegex : RegExp =  /^(-?(([1-9][0-9]{0,26}\.?)|(0\.))\d{0,2}$)|(^-?0$)|(^-$)/gm;


		public function NumericTextInput()
		{
			super();
		}

		override protected function childrenCreated() : void
		{
			super.childrenCreated()
			addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
		}

		public function valdiate() : Boolean
		{
			matchRegex.lastIndex = 0;
			var match : Object = matchRegex.exec(text);
			return match && match[0] == this.text;
		}


		public function textInputHandler(event : TextEvent) : void
		{

			var textToBe : String = "";
			if (selectionBeginIndex > 0)
			{
				textToBe += text.substr(0, selectionBeginIndex)
			}
			textToBe += event.text;
			if (selectionEndIndex > 0)
			{
				textToBe += text.substr(selectionEndIndex, text.length - selectionEndIndex);
			}
			matchRegex.lastIndex = 0;
			inputRegex.lastIndex = 0;
			var matchInput : Object = inputRegex.exec(textToBe);
			var match : Object = matchRegex.exec(textToBe);
			if (matchInput && matchInput[0] == textToBe)
				return;
			if (!match || match[0] != textToBe)
			{
				event.preventDefault();
			}
		}
	}
}
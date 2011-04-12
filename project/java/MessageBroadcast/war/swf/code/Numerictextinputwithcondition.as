package
{
	public class NumericTextInputWithCondition extends NumericTextInput
	{
		public function NumericTextInputWithCondition()
		{
			super();
			matchRegex = /^(>|>=|<|<=|<>|=)(-?([1-9][0-9]{0,26}\.?\d{0,2})|(-?0\.\d{1,2})|(0))$/gm;
			inputRegex = /^(>|>=|<|<=|<>|=)(-?(([1-9][0-9]{0,26}\.?)|(0\.))\d{0,2}$)|(^(>|>=|<|<=|<>|=)-?0$)|(^(>|>=|<|<=|<>|=)-$)|(^(>|>=|<|<=|<>|=)$)/gm;
		}

	}
}
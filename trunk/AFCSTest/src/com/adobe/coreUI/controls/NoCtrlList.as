package com.adobe.coreUI.controls
{
import mx.controls.List;
import mx.controls.listClasses.IListItemRenderer;

/**
* @private
*/
public class NoCtrlList extends List
{

    override protected function selectItem(item:IListItemRenderer,
                                  shiftKey:Boolean, ctrlKey:Boolean,
                                  transition:Boolean = true):Boolean
	{
		return super.selectItem(item, false, false, transition);
	}
}

}
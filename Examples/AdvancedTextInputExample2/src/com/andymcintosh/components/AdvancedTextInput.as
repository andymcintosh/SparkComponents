package com.andymcintosh.components
{
import flash.events.FocusEvent;

import spark.components.TextInput;
import spark.primitives.SimpleText;

public class AdvancedTextInput extends TextInput
{
	//--------------------------------------------------------------------------
	//
	//	Constructor
	//
	//--------------------------------------------------------------------------
	
	public function AdvancedTextInput()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//	Skin Parts
	//
	//--------------------------------------------------------------------------
	
	[SkinPart(required="true")]
	
	public var promptView:SimpleText;
	
	//--------------------------------------------------------------------------
	//
	//	Skin States
	//
	//--------------------------------------------------------------------------
	
	[SkinState("focused")];
	
	//--------------------------------------------------------------------------
	//
	//	Properties
	//
	//--------------------------------------------------------------------------
	
	private var _prompt:String
	
	private var promptChanged:Boolean;
	
	[Bindable]
	
	public function get prompt():String
	{
		return _prompt;
	}
	
	public function set prompt(v:String):void
	{
		_prompt = v;
		
		promptChanged = true;
		
		invalidateProperties();
	}
	
	//--------------------------------------------------------------------------
	//
	//	Overridden Properties
	//
	//--------------------------------------------------------------------------
	
	override public function set text(val:String):void
	{
		super.text = val;
		
		if (promptView && text == "")
		{
			promptView.visible = true;	
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//	Variables
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//
	//	Overridden Methods
	//
	//--------------------------------------------------------------------------
	
	override protected function commitProperties():void
	{
		super.commitProperties();
		
		if (promptChanged)
		{
			if (promptView)
			{
				promptView.text = prompt;	
			}
			
			promptChanged = false;
		}
	}
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == textView)
		{
			textView.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			textView.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
		}
		
		if (instance == promptView)
		{	
			promptView.text = prompt;
		}
	}
	
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == this.textView)
		{
			this.textView.removeEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			this.textView.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//	Event Handlers
	//
	//--------------------------------------------------------------------------
	
	private function onFocusInHandler(event:FocusEvent):void
	{
		if (promptView)
		{
			promptView.visible = false;
		}
	}
	
	private function onFocusOutHandler(event:FocusEvent):void
	{
		if (promptView)
		{
			if (text == "")
			{
				promptView.visible = true;	
			}
			else
			{
				promptView.visible = false;
			}
		}
	}

}
}
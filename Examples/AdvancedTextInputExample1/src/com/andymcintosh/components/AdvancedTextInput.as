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
	
	[Bindable()]
	
	public function get prompt():String
	{
		return _prompt;
	}
	
	public function set prompt(v:String):void
	{
		_prompt = v;
	}
	
	//--------------------------------------------------------------------------
	//
	//	Variables
	//
	//--------------------------------------------------------------------------
	
	protected var focused:Boolean;
	
	//--------------------------------------------------------------------------
	//
	//	Overridden Methods
	//
	//--------------------------------------------------------------------------
	
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == this.textView)
		{
			this.textView.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			this.textView.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
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
	
	override protected function getCurrentSkinState():String
	{
		if (focused)
		{
			return "focused";
		}
		else
		{
			return super.getCurrentSkinState();
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//	Event Handlers
	//
	//--------------------------------------------------------------------------
	
	private function onFocusInHandler(event:FocusEvent):void
	{
		focused = true;
		invalidateSkinState();
	}
	
	private function onFocusOutHandler(event:FocusEvent):void
	{
		focused = false;
		invalidateSkinState();
	}

}
}
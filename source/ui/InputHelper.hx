package ui;

#if html5
import js.Browser;
#end

class InputHelper
{
	public static function getText(label:String, def:String):String
	{
		#if html5
		return getTextHtml5(label, def);
		#end

		return null;
	}

	#if html5
	private static inline function getTextHtml5(label:String, def:String):String
	{
		return Browser.window.prompt(label, def);
	}
	#end
}

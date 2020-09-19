package;

import firetongue.FireTongue;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;
import ui.LocaleUtils;

class Main extends Sprite
{
	public static inline var WIDTH:Int = 1920;
	public static inline var HEIGHT:Int = 1080;
	public static inline var NAME_MAX_LENGTH:Int = 15;
	public static var TONGUE(default, null):FireTongue;

	public function new()
	{
		super();

		TONGUE = new FireTongue(Framework.OpenFL);
		TONGUE.init("en-GB", function()
		{
			var defaultLocale = LocaleUtils.selectDefaultLocale(TONGUE.locales);

			if (defaultLocale != null)
			{
				TONGUE.init(defaultLocale, initGame, true, true);
			}
			else
			{
				initGame();
			}
		});

		#if !FLX_NO_MOUSE
		FlxG.mouse.useSystemCursor = true;
		#end
	}

	private function initGame()
	{
		addChild(new FlxGame(WIDTH, HEIGHT, MenuState, 1, 60, 60, true));
	}
}

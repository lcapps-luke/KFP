package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static inline var WIDTH:Int = 1920;
	public static inline var HEIGHT:Int = 1080;

	public function new()
	{
		super();
		addChild(new FlxGame(WIDTH, HEIGHT, PlayState, 1, 60, 60, true));

		#if !FLX_NO_MOUSE
		FlxG.mouse.useSystemCursor = true;
		#end
	}
}

package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;

class Drum extends FlxSprite
{
	public function new()
	{
		super();
		loadGraphic(FlxG.random.bool() ? AssetPaths.drum_1__png : AssetPaths.drum_2__png);

		init();
	}

	override function revive()
	{
		super.revive();

		init();
	}

	private function init()
	{
		acceleration.y = 300;
		angularVelocity = FlxG.random.float(-270, 270);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (y > Main.HEIGHT + height)
		{
			kill();
		}
	}
}

package;

import flixel.text.FlxText;

class ScoreIncrement extends FlxText
{
	public function new()
	{
		super();

		alignment = RIGHT;
		size = 144;
		fieldWidth = 1920 - 16;

		moves = true;

		init();
	}

	override function revive()
	{
		super.revive();

		init();
	}

	private function init()
	{
		y = -size;
		velocity.y = 1080 * 2;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (y > 1080)
		{
			kill();
		}
	}
}

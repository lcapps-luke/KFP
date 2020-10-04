package;

import flixel.text.FlxText;

class ScoreIncrement extends FlxText
{
	public function new()
	{
		super();

		alignment = RIGHT;
		size = 144;
		fieldWidth = Main.WIDTH - 16;

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
		velocity.y = Main.HEIGHT * 2;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (y > Main.HEIGHT)
		{
			kill();
		}
	}
}

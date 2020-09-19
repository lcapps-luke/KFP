package;

import flixel.text.FlxText;

class Timer extends FlxText
{
	private var time:Float;
	private var callback:Void->Void;

	public function new(seconds:Int, callback:Void->Void)
	{
		super();

		this.time = seconds;
		this.callback = callback;

		alignment = LEFT;
		size = 144;
		fieldWidth = Main.WIDTH / 2;

		text = Std.string(seconds);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		time -= elapsed;
		if (time < 0)
		{
			time = 0;
			if (callback != null)
			{
				callback();
				callback = null;
			}
		}

		text = Std.string(Math.ceil(time));
	}
}

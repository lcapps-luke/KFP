package;

import flixel.FlxG;
import flixel.FlxSprite;

class Kiara extends FlxSprite
{
	private static inline var ANIMATION_WALK:String = "Walk";
	private static inline var MOVE_ACCELERATION:Float = Main.WIDTH;

	public function new()
	{
		super();

		loadGraphic(AssetPaths.kiara__png, true, 575, 1051);
		animation.add(ANIMATION_WALK, [0, 1], 2, true);

		animation.play(ANIMATION_WALK);

		this.drag.x = MOVE_ACCELERATION * 2;
		this.maxVelocity.x = MOVE_ACCELERATION / 2;

		this.offset.set(400, 390);
		this.setSize(135, 50);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.LEFT)
		{
			this.acceleration.x = -MOVE_ACCELERATION;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			this.acceleration.x = MOVE_ACCELERATION;
		}
		else if (FlxG.mouse.pressed)
		{
			this.acceleration.x = (FlxG.mouse.x > Main.WIDTH / 2) ? MOVE_ACCELERATION : -MOVE_ACCELERATION;
		}
		else
		{
			this.acceleration.x = 0;
		}

		if (this.x < 0)
		{
			this.x = 0;
			if (acceleration.x < 0)
			{
				acceleration.x = 0;
			}
		}

		if (this.x + this.width > Main.WIDTH)
		{
			this.x = Main.WIDTH - this.width;
			if (acceleration.x > 0)
			{
				acceleration.x = 0;
			}
		}
	}
}

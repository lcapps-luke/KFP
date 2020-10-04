package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	private var drumTimer:Float = 0;
	private var drumGroup:FlxTypedSpriteGroup<Drum>;

	private var kiara:Kiara;

	private var scoreIncrementGroup:FlxTypedSpriteGroup<ScoreIncrement>;

	private var score:Int = 0;
	private var scoreText:FlxText;

	public var timeLimit(default, default):Int = -1;
	public var scoreToken(default, default):String = null;

	override public function create()
	{
		super.create();

		var background = new FlxSprite();
		background.loadGraphic(AssetPaths.bg__jpg);
		add(background);

		drumGroup = new FlxTypedSpriteGroup<Drum>();
		add(drumGroup);

		kiara = new Kiara();
		kiara.y = Main.HEIGHT - (kiara.graphic.height - kiara.offset.y);
		kiara.x = Main.WIDTH / 2;

		add(kiara);

		scoreIncrementGroup = new FlxTypedSpriteGroup<ScoreIncrement>();
		add(scoreIncrementGroup);

		scoreText = new FlxText();
		scoreText.text = "0";
		scoreText.alignment = RIGHT;
		scoreText.size = 144;
		scoreText.y = Main.HEIGHT - scoreText.size - 16;
		scoreText.fieldWidth = Main.WIDTH - 16;
		add(scoreText);

		if (timeLimit > 0)
		{
			var timer:Timer = new Timer(timeLimit, timeOver);
			timer.x = 16;
			timer.y = 16;
			add(timer);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		drumTimer -= elapsed;
		if (drumTimer <= 0)
		{
			drumTimer = FlxG.random.float(1, 2);

			var drum:Drum = drumGroup.recycle(Drum, createDrum);
			drum.x = 1920 + drum.width;
			drum.y = -drum.height;

			drum.velocity.set(FlxG.random.float(-1000, -300), 0);
		}

		FlxG.overlap(kiara, drumGroup, drumCollisionCallback);
	}

	private function createDrum():Drum
	{
		return new Drum();
	}

	private function drumCollisionCallback(kiara:Kiara, drum:Drum)
	{
		drum.kill();
		incrementScore(100);
	}

	private function incrementScore(amount:Int)
	{
		score += amount;
		scoreText.text = Std.string(score);

		var scoreIncrement:ScoreIncrement = scoreIncrementGroup.recycle(ScoreIncrement, createScoreIncrement);
		scoreIncrement.text = "+" + Std.string(amount);
	}

	private function createScoreIncrement():ScoreIncrement
	{
		return new ScoreIncrement();
	}

	private function timeOver():Void
	{
		var ss:SubmitScoreSubState = new SubmitScoreSubState();
		ss.score = score;
		ss.token = scoreToken;
		openSubState(ss);
	}
}

package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import score.Score;
import score.ScoreClient;
import ui.Button;
import ui.ScoreLine;
import ui.TextButton;
import ui.ToggleButton;

class MenuState extends FlxState
{
	private var timeTrialButton:ToggleButton;
	private var scoreLines:List<ScoreLine>;

	override function create()
	{
		super.create();

		var background = new FlxSprite();
		background.loadGraphic(AssetPaths.bg__jpg);
		add(background);

		var ovr = new FlxSprite();
		ovr.makeGraphic(Main.WIDTH, Main.HEIGHT, 0xaa000000);
		add(ovr);

		var start:Button = new TextButton(Main.TONGUE.get("$PLAY"), 48, onPlayClicked);
		start.x = Main.WIDTH / 2 - start.width / 2;
		start.y = Main.HEIGHT / 2 - start.height / 2;
		add(start);

		var clockSprite = new FlxSprite();
		clockSprite.loadGraphic(AssetPaths.clock__png);
		clockSprite.scale.set(3, 3);
		clockSprite.updateHitbox();
		timeTrialButton = new ToggleButton(clockSprite);
		timeTrialButton.x = Main.WIDTH / 4 - timeTrialButton.width / 2;
		timeTrialButton.y = Main.HEIGHT / 2 - timeTrialButton.height / 2;
		add(timeTrialButton);

		timeTrialButton.checked = true;

		var flagSprite = new FlxSprite();
		flagSprite.loadGraphic(Main.TONGUE.getIcon(Main.TONGUE.locale));
		flagSprite.scale.set(3, 3);
		flagSprite.updateHitbox();
		var localeButton = new Button(flagSprite, onLocaleClicked);
		localeButton.x = 16;
		localeButton.y = 16;
		add(localeButton);

		var scoreHeader = new FlxText(0, 16, 0, Main.TONGUE.get("$SCORE_HEADER"), 48);
		scoreHeader.x = (scoreHeader.width > Main.WIDTH / 4) ? Main.WIDTH - scoreHeader.width : Main.WIDTH - Main.WIDTH / 4;
		add(scoreHeader);

		scoreLines = new List<ScoreLine>();
		reloadScores();
	}

	private function onPlayClicked():Void
	{
		var play:PlayState = new PlayState();

		if (timeTrialButton.checked)
		{
			play.timeLimit = 100;
			ScoreClient.getToken(function(token)
			{
				play.scoreToken = token;
			});
		}

		FlxG.switchState(play);
	}

	private function onLocaleClicked()
	{
		openSubState(new LocaleSelectState());
	}

	private function reloadScores()
	{
		ScoreClient.listScores(function(list:Array<Score>)
		{
			for (s in scoreLines)
			{
				this.remove(s);
			}

			scoreLines.clear();

			var yy:Float = 72;
			for (i in list)
			{
				var s = new ScoreLine(i.name, i.value);
				s.x = Main.WIDTH - Main.WIDTH / 4;
				s.y = yy;
				scoreLines.add(s);
				add(s);

				yy += s.height;
				if (yy > Main.HEIGHT - s.height)
				{
					break;
				}
			}
		});
	}
}

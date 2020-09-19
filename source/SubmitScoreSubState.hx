package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.addons.ui.FlxInputText;
import flixel.text.FlxText;
import score.ScoreClient;
import ui.Button;
import ui.InputHelper;
import ui.TextButton;

class SubmitScoreSubState extends FlxSubState
{
	public var score(default, default):Int;
	public var token(default, default):String;

	private var nameInput:FlxInputText;
	private var submitClicked:Bool = false;

	public function new()
	{
		super(0xaa000000);
	}

	override function create()
	{
		super.create();

		var label:FlxText = new FlxText(0, 0, 0, Main.TONGUE.get("$SUBMIT_SCORE"), 144);
		label.x = Main.WIDTH / 2 - label.width / 2;
		label.y = Main.HEIGHT / 4 - label.height / 2;
		add(label);

		nameInput = new FlxInputText(0, 0, Math.round(Main.WIDTH * 0.75), "anonymous", 144, 0xFFFFFF, 0x000000);
		nameInput.caretWidth = 10;
		nameInput.maxLength = Main.NAME_MAX_LENGTH;
		nameInput.x = Main.WIDTH / 8;
		nameInput.y = Main.HEIGHT / 2 - nameInput.height / 2;
		nameInput.hasFocus = true;
		add(nameInput);

		if (token != null)
		{
			var submit:Button = new TextButton(Main.TONGUE.get("$SUBMIT"), 144, onSubmitClicked);
			submit.x = Main.WIDTH / 2 + 20;
			submit.y = (Main.HEIGHT - submit.height) - 20;
			add(submit);
		}

		var cancel:Button = new TextButton(Main.TONGUE.get("$CANCEL"), 144, onCancelClicked);
		cancel.x = Main.WIDTH / 2 - (cancel.width + 20);
		cancel.y = (Main.HEIGHT - cancel.height) - 20;
		add(cancel);
	}

	private function onSubmitClicked()
	{
		if (!submitClicked)
		{
			submitClicked = true;

			var sanName = nameInput.text;
			if (sanName.length > Main.NAME_MAX_LENGTH)
			{
				sanName = sanName.substring(0, Main.NAME_MAX_LENGTH);
			}

			ScoreClient.submit(token, sanName, score, function(success:Bool)
			{
				if (success)
				{
					FlxG.switchState(new MenuState());
				}
				else
				{
					submitClicked = false;
				}
			});
		}
	}

	private function onCancelClicked()
	{
		FlxG.switchState(new MenuState());
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justReleased && FlxG.mouse.overlaps(nameInput))
		{
			var name = InputHelper.getText(Main.TONGUE.get("$NAME"), nameInput.text);
			if (name != null)
			{
				nameInput.text = name;
			}
		}
	}
}

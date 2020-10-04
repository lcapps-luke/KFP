package;

import firetongue.FireTongue.IndexString;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import ui.Button;

class LocaleSelectState extends FlxSubState
{
	public function new()
	{
		super(0xee000000);
	}

	override function create()
	{
		super.create();

		var yDist:Float = Main.HEIGHT / (Main.TONGUE.locales.length + 1);
		var yAcc:Float = yDist / 2;

		for (l in Main.TONGUE.locales)
		{
			var lang = createLang(l, yDist * 0.25);
			lang.x = Main.WIDTH / 2 - lang.width / 2;
			lang.y = yAcc;
			add(lang);

			yAcc += yDist;
		}
	}

	private function createLang(locale:String, size:Float):Button
	{
		var grp = new FlxSpriteGroup();

		var label = new FlxText(0, 0, 0, Main.TONGUE.getIndexString(IndexString.LanguageNative, locale), Math.round(size));
		grp.add(label);

		var flagSprite = new FlxSprite();
		flagSprite.loadGraphic(Main.TONGUE.getIcon(locale));
		var flagScale:Float = label.height / 11;
		flagSprite.scale.set(flagScale, flagScale);
		flagSprite.updateHitbox();
		flagSprite.y = label.height / 2 - flagSprite.height / 2;
		grp.add(flagSprite);

		label.x = flagSprite.width + 20;

		return new Button(grp, function()
		{
			selectLocale(locale);
		});
	}

	private function selectLocale(locale:String)
	{
		Main.SAVE.data.locale = locale;
		Main.SAVE.flush();

		Main.TONGUE.init(locale, function()
		{
			FlxG.resetState();
		});
	}
}

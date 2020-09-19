package;

import flixel.system.FlxAssets;
import flixel.system.FlxBasePreloader;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;

class Preloader extends FlxBasePreloader
{
	private var textSize:Int;
	private var loadingText:TextField;
	private var progressText:TextField;

	override public function new()
	{
		super();
	}

	private inline function makeTextField():TextField
	{
		var tf = new TextField();
		tf.defaultTextFormat = new TextFormat(FlxAssets.FONT_DEFAULT, textSize, 0xffffff);
		tf.defaultTextFormat.align = CENTER;
		tf.embedFonts = true;
		tf.selectable = false;
		tf.multiline = false;
		tf.autoSize = CENTER;
		tf.x = 0;
		tf.width = _width;

		return tf;
	}

	override function create()
	{
		super.create();

		_width = Std.int(Lib.current.stage.stageWidth);
		_height = Std.int(Lib.current.stage.stageHeight);
		textSize = Std.int(_height * 0.13);

		loadingText = makeTextField();
		loadingText.y = (_height * 0.5) - textSize;
		loadingText.text = "Loading...";
		addChild(loadingText);

		progressText = makeTextField();
		progressText.y = (_height * 0.75) - textSize;
		addChild(progressText);
	}

	override function update(percent:Float)
	{
		super.update(percent);

		progressText.text = Std.string(Math.round(percent)) + "%";
	}

	override function destroy()
	{
		super.destroy();

		removeChild(loadingText);
		removeChild(progressText);

		loadingText = null;
		progressText = null;
	}
}

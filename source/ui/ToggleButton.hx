package ui;

import flixel.FlxSprite;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class ToggleButton extends Button
{
	public var checked(get, set):Bool;
	public var offOverlay:FlxSprite;

	public function new(spr:FlxSprite)
	{
		super(spr, toggle);

		offOverlay = new FlxSprite();

		offOverlay.makeGraphic(Math.ceil(spr.width + Button.PADDING * 2), Math.ceil(spr.height + Button.PADDING * 2), FlxColor.TRANSPARENT, true);
		offOverlay.drawLine(0, 0, offOverlay.width, offOverlay.height, {
			thickness: 12,
			color: FlxColor.WHITE
		});

		add(offOverlay);
	}

	public function toggle()
	{
		trace(offOverlay.visible);
		offOverlay.visible = !offOverlay.visible;
	}

	private function get_checked():Bool
	{
		return !offOverlay.visible;
	}

	private function set_checked(v:Bool):Bool
	{
		return offOverlay.visible = !v;
	}
}

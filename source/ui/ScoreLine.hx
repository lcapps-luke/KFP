package ui;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

class ScoreLine extends FlxSpriteGroup
{
	public function new(name:String, score:Int)
	{
		super();

		var nt:FlxText = new FlxText(0, 0, 0, name.length > Main.NAME_MAX_LENGTH ? name.substring(0, Main.NAME_MAX_LENGTH) : name, 32);
		add(nt);

		var st:FlxText = new FlxText(0, 0, 0, Std.string(score), 32);
		st.x = (Main.WIDTH / 4) - st.width;
		add(st);
	}
}

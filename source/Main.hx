package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flash.text.Font;
import flixel.system.FlxAssets;

@:font("assets/data/solemnit.ttf")
private class MyFont extends Font {}

/**
 * @author E. Zachary Knight
 */
class Main extends Sprite 
{
	// Entry point
	static public function main():Void
	{	
		Lib.current.addChild(new Main());
		Font.registerFont(MyFont);
		FlxAssets.FONT_DEFAULT = "Solemnity";
	}
	
	public function new() 
	{
		super();
		
		if (stage != null) 
		{
			init();
		}
		else 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(?E:Event):Void 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		initialize();
		
		var game:FlxGame = new GameClass();
		addChild(game);
	}
	
	private function initialize():Void 
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
	}
}

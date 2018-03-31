package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class LogoState extends FlxState
{
	private var _switchTimer:Float;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		Reg.dkLogoSp = new FlxSprite( 100, 10, Reg.dkLogo);
		add(Reg.dkLogoSp);
		
		_switchTimer = 2.5;
	}
	
	private function goToMenu():Void
	{
		FlxG.switchState(new MenuState());
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		_switchTimer -= FlxG.elapsed;
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE || FlxG.mouse.justPressed || _switchTimer < 0)
		{
			this.goToMenu();
		}
	}	
}

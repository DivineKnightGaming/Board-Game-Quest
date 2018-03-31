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
class WinState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		Reg.text = new FlxText(10,5,620,"Board Game Quest");
		Reg.text.size = 40;
		add(Reg.text); 
		Reg.text.alignment = "center";
		
		Reg.text = new FlxText(10,40,620,"You Won!");
		Reg.text.size = 72;
		add(Reg.text); 
		Reg.text.alignment = "center";
		
		Reg.text = new FlxText(10,130,620,"You fought valiantly. Your strength, determination and character carried you through to victory. The people of the world will sing of your victory for many generations to come.");
		Reg.text.size = 24;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.button = new FlxButton((FlxG.width/2) - 80, 300, "Play Again", goToGame);
		Reg.button.loadGraphic(Reg.buttonImg,true,false,160,40);
		Reg.button.label = new FlxText(0,0,160,"Play Again");
		Reg.button.label.setFormat(null, 22, 0xffffff, "center");
		add(Reg.button);
		
		Reg.text = new FlxText(10,360,620,"Credits");
		Reg.text.size = 30;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.text = new FlxText(10,400,620,"Game Design, Programming, Some Art: Zachary Knight");
		Reg.text.size = 20;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.text = new FlxText(10,430,620,"Game Art: Willis Knight");
		Reg.text.size = 20;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		/*Reg.text = new FlxText(200,450,600,"Press Enter to start playing.");
		Reg.text.size = 30;
		add(Reg.text); */
	}
	
	private function goToGame():Void
	{
		FlxG.switchState(new TokenSelectState());
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
	}	
}

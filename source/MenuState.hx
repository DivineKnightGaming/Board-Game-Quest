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
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		Reg.init();
		add(Reg.tileMap);
		
		Reg.sprite = new FlxSprite(Reg.movements[41][0],Reg.movements[41][1],Reg.tokens[0]);
		add(Reg.sprite);
		Reg.sprite = new FlxSprite(Reg.movements[30][0],Reg.movements[30][1],Reg.tokens[3]);
		add(Reg.sprite);
		Reg.sprite = new FlxSprite(Reg.movements[20][0],Reg.movements[20][1],Reg.tokens[5]);
		add(Reg.sprite);
		Reg.sprite = new FlxSprite(Reg.movements[9][0],Reg.movements[9][1],Reg.tokens[6]);
		add(Reg.sprite);
		Reg.sprite = new FlxSprite(Reg.movements[42][0],Reg.movements[42][1],Reg.monsters[9]);
		add(Reg.sprite);
		Reg.sprite = new FlxSprite(Reg.movements[21][0],Reg.movements[21][1],Reg.monsters[5]);
		add(Reg.sprite);
		
		Reg.playerDice.x = 256;//256
		Reg.playerDice.y = 192;
		add(Reg.playerDice);
		Reg.playerDice.animation.play("title");
		
		Reg.enemyDice.x = 384;//384
		Reg.enemyDice.y = 192;
		add(Reg.enemyDice);
		Reg.enemyDice.animation.play("title");
		
		Reg.text = new FlxText(192,64,500,"Board Game Quest");
		Reg.text.size = 40;
		Reg.text.setBorderStyle(FlxText.BORDER_SHADOW, 0x000000, 4, 1);
		add(Reg.text); 
		
		Reg.button = new FlxButton(256, 330, "Play Game", goToGame);
		Reg.button.loadGraphic(Reg.buttonImg,true,false,160,40);
		Reg.button.label = new FlxText(0,0,160,"Play Game");
		Reg.button.label.setFormat(null, 22, 0xffffff, "center");
		add(Reg.button);
		
		/*Reg.text = new FlxText(200,450,600,"Press Enter to start playing.");
		Reg.text.size = 30;
		add(Reg.text); */
	}
	
	private function goToGame():Void
	{
		FlxG.switchState(new TokenSelectState());
		//FlxG.switchState(new WinState());
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

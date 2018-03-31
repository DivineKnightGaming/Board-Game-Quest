package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var player1TokenSpt:FlxSprite;
	public var monsterTokenSpt:FlxSprite;
	private var playerRan:Int;
	private var potion:Int;
	private var enemyRan:Int;
	private var playerAtt:Int;
	private var enemyAtt:Int;
	private var playerRolling:Bool;
	private var enemyRolling:Bool;
	private var turnState:Int;//1 movement 2 fight
	private var monster:Int;
	private var pdieTimer:Float;
	private var edieTimer:Float;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		Reg.init();
		add(Reg.tileMap);
		
		player1TokenSpt = new FlxSprite(0,0,Reg.tokens[Reg.player1Token]);
		add(player1TokenSpt);
		
		Reg.text = new FlxText(256,64,500,"Health: 5");
		Reg.text.size = 40;
		Reg.text.setBorderStyle(FlxText.BORDER_SHADOW, 0x000000, 4, 1);
		add(Reg.text); 
		
		playerRolling = false;
		enemyRolling = false;
		
		Reg.playerDice.x = -64;//256
		Reg.playerDice.y = 192;
		add(Reg.playerDice);
		
		Reg.enemyDice.x = -64;//384
		Reg.enemyDice.y = 192;
		add(Reg.enemyDice);
		
		Reg.rollButton = new FlxButton(256, 210, "Roll Die", playerRoll);//256
		Reg.rollButton.loadGraphic(Reg.buttonImg,true,false,160,40);
		Reg.rollButton.label = new FlxText(0,0,160,"Roll Die");
		Reg.rollButton.label.setFormat(null, 22, 0xffffff, "center");
		add(Reg.rollButton);
		
		Reg.potionButton = new FlxButton(256, 330, "Use Potion", usePotion);//256
		Reg.potionButton.loadGraphic(Reg.buttonImg,true,false,160,40);
		Reg.potionButton.label = new FlxText(0,0,160,"Use Potion");
		Reg.potionButton.label.setFormat(null, 22, 0xffffff, "center");
		add(Reg.potionButton);
		
		turnState = 1;
		Reg.score = 5;
		potion = 1;
		if(Reg.player1Token == 2 || Reg.player1Token == 3)
		{
			potion++;
		}
		pdieTimer = .1;
		edieTimer = .1;
	}
	
	public function movePlayer1(steps:Int)
	{
		Reg.playerPos = Reg.playerPos + steps;
		if(Reg.playerPos > 41)
		{
			Reg.playerPos = 41;
		}
		if(Reg.playerPos < 0)
		{
			Reg.playerPos = 0;
		}
		player1TokenSpt.x = Reg.movements[Reg.playerPos][0];
		player1TokenSpt.y = Reg.movements[Reg.playerPos][1];
	}
	
	private function playerRoll():Void
	{
		if (playerRolling == false)
		{
			FlxG.sound.play(Reg.rollSnd);
			Reg.rollButton.x = -256;
			Reg.potionButton.x = -256;
			playerRan = Std.random(6);
			Reg.playerDice.x = 256;//256
			Reg.playerDice.animation.play("roll");
			playerRolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
		if(turnState == 2)
		{
			enemyRoll();
		}
	}
	
	private function enemyRoll():Void
	{
		if (enemyRolling == false)
		{
			//FlxG.sound.play(Reg.rollSnd);
			enemyRan = Std.random(6);
			Reg.enemyDice.x = 384;//384
			Reg.enemyDice.animation.play("roll");
			enemyRolling = true;
			haxe.Timer.delay(endAnimation, 2000);
		}
	}
	
	private function endAnimation():Void
	{
		if(playerRolling)
		{
			playerRolling = false;
		}
		if(enemyRolling)
		{
			enemyRolling = false;
		}
	}
	
	private function spawnEnemy():Void
	{
		FlxG.sound.play(Reg.enemyRiseSnd);
		if(Reg.playerPos < 41)
		{
			monster = Std.random(8);
			monsterTokenSpt = new FlxSprite(Reg.movements[Reg.playerPos+1][0],Reg.movements[Reg.playerPos+1][1],Reg.monsters[monster]);
			add(monsterTokenSpt);
		}
		else
		{
			monster = 9;
			monsterTokenSpt = new FlxSprite(Reg.movements[Reg.playerPos+1][0],Reg.movements[Reg.playerPos+1][1],Reg.monsters[9]);
			add(monsterTokenSpt);
		}
	}
	
	private function moveObjects():Void
	{
		Reg.enemyDice.x = -64;//384
		Reg.playerDice.x = -64;//256
		Reg.rollButton.x = 256;
		if(potion > 0)
		{
			Reg.potionButton.x = 256;
		}
	}
	
	private function goToWin():Void
	{
		Reg.playerPos = 0;
		FlxG.switchState(new WinState());
	}
	
	private function goToLose():Void
	{
		Reg.playerPos = 0;
		FlxG.switchState(new LoseState());
	}
	
	private function usePotion():Void
	{
		if(potion > 0)
		{
			FlxG.sound.play(Reg.potionSnd);
			Reg.score = 5;
			potion--;
			Reg.text.text = "Health: " + Reg.score;
			Reg.potionButton.x = -256;
		}
	}
	
	private function endPow():Void
	{
		Reg.powSprite.kill();
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
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE || FlxG.mouse.justPressed)
		{
			//this.movePlayer1(1);
		}
		if (playerRolling == false)
		{
			if(Reg.playerDice.animation.curAnim != null && Reg.playerDice.animation.curAnim.curFrame == playerRan)
			{
				Reg.playerDice.animation.curAnim.stop();
				Reg.playerDice.animation.curAnim.curFrame = playerRan;
				if(turnState == 1)
				{
					if(Reg.player1Token == 4 || Reg.player1Token == 5)
					{
						playerRan++;
					}
					movePlayer1(playerRan+1);
					spawnEnemy();
					haxe.Timer.delay(moveObjects, 1000);
					turnState = 2;
					playerAtt = -1;
				}
				else
				{
					playerAtt = playerRan;
				}
				playerRan = -1;
			}
		}
		else
		{
			pdieTimer -= FlxG.elapsed;
			if(pdieTimer < 0)
			{
				pdieTimer = .1;
				FlxG.sound.play(Reg.rollSnd);
			}
		}
		if (enemyRolling == false)
		{
			if(Reg.enemyDice.animation.curAnim != null && Reg.enemyDice.animation.curAnim.curFrame == enemyRan)
			{
				Reg.enemyDice.animation.curAnim.stop();
				Reg.enemyDice.animation.curAnim.curFrame = enemyRan;
				enemyAtt = enemyRan;
				enemyRan = -1;
			}
		}
		/*else
		{
			edieTimer -= FlxG.elapsed;
			if(edieTimer < 0)
			{
				edieTimer = .1;
				FlxG.sound.play(Reg.rollSnd);
			}
		}*/
		if(playerRolling == false && enemyRolling == false)
		{
			if(turnState == 2 && playerAtt != -1 && enemyAtt != -1)
			{
				if(Reg.player1Token == 6 || Reg.player1Token == 7)
				{
					playerAtt++;
				}
				if(playerAtt > enemyAtt)
				{
					FlxG.sound.play(Reg.enemyDiesSnd);
					Reg.powSprite = new FlxSprite(Reg.movements[Reg.playerPos+1][0],Reg.movements[Reg.playerPos+1][1],Reg.powImg);
					add(Reg.powSprite);
					haxe.Timer.delay(endPow, 500);
					monsterTokenSpt.x = -64;
					haxe.Timer.delay(moveObjects, 1000);
					if(monster == 9)
					{
						FlxG.sound.play(Reg.victorySnd);
						haxe.Timer.delay(goToWin, 1000);
					}
				}
				else
				{
					if(Reg.player1Token != 0 && Reg.player1Token != 1)
					{
						movePlayer1(-1);
					}
					monsterTokenSpt.x = -64;
					if(playerAtt != enemyAtt)
					{
						FlxG.sound.play(Reg.playerDamageSnd);
						Reg.powSprite = new FlxSprite(Reg.movements[Reg.playerPos][0],Reg.movements[Reg.playerPos][1],Reg.powImg);
						add(Reg.powSprite);
						haxe.Timer.delay(endPow, 500);
						Reg.score--;
						Reg.text.text = "Health: " + Reg.score;
					}
					else
					{
						FlxG.sound.play(Reg.playerSwingSnd);
					}
					if(Reg.score == 0)
					{
						FlxG.sound.play(Reg.playerDiesSnd);
						haxe.Timer.delay(goToLose, 1000);
					}
					else
					{
						haxe.Timer.delay(moveObjects, 1000);
					}
				}
				playerAtt = -1;
				enemyAtt = -1;
				turnState = 1;
			}
		}
	}	
}

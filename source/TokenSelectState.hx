package;


import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import flash.filters.GlowFilter;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.util.FlxPath;
import flixel.util.FlxSave;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.effects.FlxSpriteFilter;

import flixel.addons.display.FlxExtendedSprite;

class TokenSelectState extends FlxState
{
	public var player1TokenSpt:FlxSprite;
	public var player2TokenSpt:FlxSprite;
	public var player3TokenSpt:FlxSprite;
	public var player4TokenSpt:FlxSprite;
	
	public var player1Select:Int;
	public var player2Select:Int;
	public var player3Select:Int;
	public var player4Select:Int;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Set a background color
		//FlxG.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		Reg.init();
		#if !FLX_NO_MOUSE
		//FlxG.mouse.show(Reg.pointer);
		#end
		
		Reg.text = new FlxText(10,10,620,"To begin your quest, you must first select your champion. Each champion has its own ability to aid you to victory.");
		Reg.text.size = 30;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.leftBtn = new FlxButton((FlxG.width/2)-64, 156, "", moveTokenLeft);
		Reg.leftBtn.loadGraphic(Reg.btnLeftImg);
		add(Reg.leftBtn);
		
		Reg.player1Token = -1;
		player1Select = 0;
		player1TokenSpt = new FlxSprite((FlxG.width/2)-32,140,Reg.tokens[0]);
		add(player1TokenSpt);
		
		Reg.rightBtn = new FlxButton((FlxG.width/2)+32, 156, "", moveTokenRight);
		Reg.rightBtn.loadGraphic(Reg.btnRightImg);
		add(Reg.rightBtn);
		
		Reg.tokenDesc = new FlxText(0,200,640,"Paladins have strong defense. Don't get pushed back.");
		Reg.tokenDesc.size = 16;
		Reg.tokenDesc.alignment = "center";
		add(Reg.tokenDesc); 
		
		Reg.button = new FlxButton((FlxG.width/2) - 80, 240, "Select Token", selectPlayer1);
		Reg.button.loadGraphic(Reg.buttonImg,true,false,160,40);
		Reg.button.label = new FlxText(0,0,160,"Select Token");
		Reg.button.label.setFormat(null, 22, 0xffffff, "center");
		add(Reg.button);
		
		Reg.button = new FlxButton((FlxG.width/2) - 80, 310, "Begin", goToGame);
		Reg.button.loadGraphic(Reg.buttonImg,true,false,160,40);
		Reg.button.label = new FlxText(0,0,160,"Begin");
		Reg.button.label.setFormat(null, 22, 0xffffff, "center");
		add(Reg.button);
		
		Reg.text = new FlxText(10,350,620,"Instructions:");
		Reg.text.size = 30;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.text = new FlxText(10,390,620,"Roll the die to move. A monster appears before you. Roll the die to beat the monster's roll. If you roll lower than the monster, you lose 1 hp and move back a space. If you tie, you move back a space. If you win, the monster is gone. Beat the final monster to win the game. You get 1 potion to refill your life. Use it wisely.");
		Reg.text.size = 16;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		super.create();
	}
	
	private function moveTokenLeft():Void
	{
		switchToken(1);
	}
	
	private function moveTokenRight():Void
	{
		switchToken(2);
	}
	
	private function switchToken(dir:Int):Void
	{
		if(Reg.player1Token == -1)
		{
			if(dir == 1)
			{
				player1Select = player1Select - 1;
				if (player1Select < 0)
				{
					player1Select = 7;
				}
			}
			if(dir == 2)	
			{
				player1Select = player1Select + 1;
				if (player1Select > 7)
				{
					player1Select = 0;
				}
			}
			player1TokenSpt.loadGraphic(Reg.tokens[player1Select]);
			switch(player1Select)
			{
				case 0:
					Reg.tokenDesc.text = "Paladins have strong defense. Don't get pushed back.";
				case 1:
					Reg.tokenDesc.text = "Paladins have strong defense. Don't get pushed back.";
				case 2:
					Reg.tokenDesc.text = "Priests are always prepared to heal. Gets an extra potion.";
				case 3:
					Reg.tokenDesc.text = "Priests are always prepared to heal. Gets an extra potion.";
				case 4:
					Reg.tokenDesc.text = "Rogues are masters of stealth. Adds 1 to dice rolls when moving.";
				case 5:
					Reg.tokenDesc.text = "Rogues are masters of stealth. Adds 1 to dice rolls when moving.";
				case 6:
					Reg.tokenDesc.text = "Sorcerers have strong magic. Adds 1 to attack rolls.";
				case 7:
					Reg.tokenDesc.text = "Sorcerers have strong magic. Adds 1 to attack rolls.";
			}
		}
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if(Reg.player1Token == -1)
		{
			if (FlxG.keys.justPressed.SPACE)
			{
				this.selectPlayer1();
			}
		}
		if (FlxG.keys.justPressed.ENTER)
		{
			this.goToGame();
		}
		
		super.update();
	}	
	
	private function selectPlayer1():Void
	{
		Reg.p1Filter = new FlxSpriteFilter(player1TokenSpt);
		Reg.p1Filter.removeAllFilters();
		Reg.p1Filter.addFilter(new GlowFilter(0xff0000, 1, 10, 10, 2, 1));
		
		//player1DragonSpt.removeAllFilters();
		//player1DragonSpt.addFilter(new GlowFilter(0x0000ff, 1, 20, 20, 2, 1), 0,0);
		Reg.player1Token = player1Select;
	}
	
	/*private function selectPlayer2():Void
	{
		Reg.p2Filter = new FlxSpriteFilter(player1DragonSpt);
		Reg.p2Filter.removeAllFilters();
		Reg.p2Filter.addFilter(new GlowFilter(0xff0000, 1, 10, 10, 2, 1));
		
		//player2DragonSpt.removeAllFilters();
		//player2DragonSpt.addFilter(new GlowFilter(0x0000ff, 1, 20, 20, 2, 1), 0,0);
		Reg.player1Dragon = player2Select;
	}
	
	private function selectPlayer3():Void
	{
		Reg.p3Filter = new FlxSpriteFilter(player1DragonSpt);
		Reg.p3Filter.removeAllFilters();
		Reg.p3Filter.addFilter(new GlowFilter(0xff0000, 1, 10, 10, 2, 1));
		
		//player3DragonSpt.removeAllFilters();
		//player3DragonSpt.addFilter(new GlowFilter(0x0000ff, 1, 20, 20, 2, 1), 0,0);
		Reg.player1Dragon = player3Select;
	}
	
	private function selectPlayer4():Void
	{
		Reg.p4Filter = new FlxSpriteFilter(player1DragonSpt);
		Reg.p4Filter.removeAllFilters();
		Reg.p4Filter.addFilter(new GlowFilter(0xff0000, 1, 10, 10, 2, 1));
		
		//player4DragonSpt.removeAllFilters();
		//player4DragonSpt.addFilter(new GlowFilter(0x0000ff, 1, 20, 20, 2, 1), 0,0);
		Reg.player1Dragon = player4Select;
	}*/
	
	private function goToGame():Void
	{
		FlxG.switchState(new PlayState());
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}
}

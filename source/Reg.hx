package;

import flixel.util.FlxSave;
import flixel.tile.FlxTilemap;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.effects.FlxSpriteFilter;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	static public var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	static public var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	static public var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	static public var score:Int = 0;
	/**
	 * Generic bucket for storing different <code>FlxSaves</code>.
	 * Especially useful for setting up multiple save slots.
	 */
	static public var saves:Array<FlxSave> = [];
	
	public static var dkLogo="assets/images/DKGTitleLogo.png";
	public static var dkLogoSp:FlxSprite;
	
	public static var text:FlxText;
	public static var sprite:FlxSprite;
	public static var tokenDesc:FlxText;
	public static var buttonImg = "assets/data/buttondk.png";
	public static var button:FlxButton;
	public static var rollButton:FlxButton;
	public static var potionButton:FlxButton;
	public static var btnLeftImg = "assets/images/small_arrow_l.png";
	public static var btnRightImg = "assets/images/small_arrow_r.png";
	public static var leftBtn:FlxButton;
	public static var rightBtn:FlxButton;
	
	public static var MapTiles="assets/images/board_spaces.png";
	public static var map:Array<Int>;
	public static var tileMap:FlxTilemap;
	
	public static var movements:Array<Dynamic>;
	public static var playerPos:Int = 0;
	
	public static var tokens:Array<String> = ["assets/images/paladin.png","assets/images/paladin_girl.png","assets/images/priest.png","assets/images/priestess.png"
											 ,"assets/images/rogue.png","assets/images/rogue_girl.png","assets/images/sorcerer.png","assets/images/sorceress.png"];
	public static var monsters:Array<String> = ["assets/images/bat.png","assets/images/slime.png","assets/images/spider.png","assets/images/snake.png"
											 ,"assets/images/goblin_knight.png","assets/images/orc.png","assets/images/ogre_warrior.png","assets/images/dragon.png"
											 ,"assets/images/fire_dragon.png","assets/images/devil_winged.png"];
	
	public static var player1Token:Int;
	public static var p1Filter:FlxSpriteFilter;
	
	public static var dice1="assets/images/dice.png";
	public static var dice2="assets/images/dice_2.png";
	public static var playerDice:FlxSprite;
	public static var enemyDice:FlxSprite;
	
	public static var powImg = "assets/images/pow.png";
	public static var powSprite:FlxSprite;
	
					//FlxG.sound.play("assets/sounds/enemy_rise.wav");
	public static var enemyRiseSnd = "assets/sounds/enemy_rise.wav";
	public static var enemyDiesSnd = "assets/sounds/enemy_dies.wav";
	public static var playerDiesSnd = "assets/sounds/player_dies.wav";
	public static var playerSwingSnd = "assets/sounds/player_swing.wav";
	public static var playerDamageSnd = "assets/sounds/player_damage.wav";
	public static var potionSnd = "assets/sounds/potion.wav";
	public static var victorySnd = "assets/sounds/victory.wav";
	public static var rollSnd = "assets/sounds/roll.wav";
	
	public static function init()
	{
		map = [
				2 ,0 ,2 ,1 ,2 ,1 ,2 ,1 ,2 ,1 ,
				1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,2 ,
				2 ,0 ,2 ,0 ,2 ,1 ,2 ,1 ,0 ,1 ,
				1 ,0 ,1 ,0 ,0 ,0 ,0 ,2 ,0 ,2 ,
				2 ,0 ,2 ,1 ,2 ,1 ,2 ,1 ,0 ,1 ,
				1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,2 ,
				2 ,1 ,2 ,1 ,2 ,1 ,2 ,1 ,2 ,1 ,
				0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 
				];
		
		tileMap = new FlxTilemap();
		tileMap.widthInTiles = 10;
		tileMap.heightInTiles = 8;
		tileMap.loadMap(
			map, 
			MapTiles, 
			64, 
			64, 0,0,0,
			0
		);
		
		movements = [[0,0],[0,64],[0,128],[0,192],[0,256],[0,320],[0,384]
					,[64,384],[128,384],[192,384],[256,384],[320,384],[384,384],[448,384],[512,384],[576,384]
					,[576,320],[576,256],[576,192],[576,128],[576,64],[576,0]
					,[512,0],[448,0],[384,0],[320,0],[256,0],[192,0],[128,0]
					,[128,64],[128,128],[128,192],[128,256]
					,[192,256],[256,256],[320,256],[384,256],[448,256]
					,[448,192],[448,128]
					,[384,128],[320,128],[256,128]];
		
		playerDice = new FlxSprite( 0, 0);
		playerDice.loadGraphic(Reg.dice1, true, false, 64, 64);
		playerDice.animation.add("roll", [0, 1, 2, 3, 4, 5], 16, true);
		playerDice.animation.add("title", [4], 16, true);
		
		enemyDice = new FlxSprite( 0, 0);
		enemyDice.loadGraphic(Reg.dice2, true, false, 64, 64);
		enemyDice.animation.add("roll", [0, 1, 2, 3, 4, 5], 16, true);
		enemyDice.animation.add("title", [2], 16, true);
	}
}

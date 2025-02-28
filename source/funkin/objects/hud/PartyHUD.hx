package funkin.objects.hud;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

import funkin.objects.playfields.PlayField;
import funkin.data.JudgmentManager.JudgmentData;

class PartyHUD extends CommonHUD
{
	public var scoreNameTxt:FlxText;
	public var scoreTxt:FlxText;

	public var missesTxt:FlxText;

	public var ratingTxt:FlxText;

	override public function new(iP1:String, iP2:String, songName:String, stats:Stats)
	{
		super(iP1, iP2, songName, stats);

		healthBar.x += 300;

		var blackBarThing = new FlxSprite(Paths.image("hudshit"));
		blackBarThing.screenCenter();
		add(blackBarThing);

		// Worst things ever...
		scoreNameTxt = new FlxText(50, healthBarBG.y - 40, 720, "SCORE");
		scoreNameTxt.setFormat(Paths.font("al.ttf"), 32, FlxColor.WHITE, LEFT);
		scoreNameTxt.antialiasing = true;
		add(scoreNameTxt);

		scoreTxt = new FlxText(scoreNameTxt.x, scoreNameTxt.y + 40, 720, "6000");
		scoreTxt.setFormat(Paths.font("al.ttf"), 64, FlxColor.WHITE, LEFT);
		scoreTxt.antialiasing = true;
		add(scoreTxt);


		missesTxt = new FlxText(250, scoreNameTxt.y, 720, "MISSES: 500");
		missesTxt.setFormat(Paths.font("al.ttf"), 32, FlxColor.WHITE, LEFT);
		missesTxt.antialiasing = true;
		add(missesTxt);

		ratingTxt = new FlxText(300, scoreTxt.y - 10, 720, "PERFECT!");
		ratingTxt.setFormat(Paths.font("vcr.ttf"), 50, FlxColor.CYAN, CENTER);
		ratingTxt.antialiasing = true;
		add(ratingTxt);

		remove(timeBar);
		add(healthBarBG);
		add(healthBar);
		add(iconP1);
		add(iconP2);
	}


	override function update(elapsed:Float)
	{
		scoreTxt.text = Std.string(PlayState.instance.stats.score);
		missesTxt.text = "MISSES: " + PlayState.instance.stats.misses;
		ratingTxt.text = PlayState.instance.stats.grade.toUpperCase();

		super.update(elapsed);
	}
}
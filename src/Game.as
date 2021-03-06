package {
import flash.geom.Point;
import flash.ui.Mouse;

import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;
import net.flashpunk.Sfx;


public class Game extends World {
	public var frameNumber:int = 0;
	
	[Embed(source = '../content/sprites/cursor.png')]
	private const CURSOR:Class;
	private const cursor:Image = new Image(CURSOR);
	
	[Embed(source = '../content/sprites/title dog.png')]
	private const TITLEDOG:Class;
	private const titleDog:Image = new Image(TITLEDOG);

	[Embed(source = '../content/sprites/titleText.png')]
	private const TITLETEXT:Class;
	private const titleText:Image = new Image(TITLETEXT);
	
	[Embed(source = '../content/sprites/pause.png')]
	private const PAUSE:Class;
	private const paused:Image = new Image(PAUSE);
	
	//artofgardens.mp3 from http://www.danosongs.com/
	[Embed(source = '../content/sounds/artofgardens.mp3')]
	static private const MUSIC:Class;
	static public var music:Sfx = new Sfx(MUSIC);
	
	//public var gameManager:GameManager = new GameManager();
	public var hud:HUD;
	public var mainEmitter:EmitterExtra;
	static public var mute:Boolean = false;
	static public var pause:Boolean = false;
	static public var tutorial:Boolean = false;
	static public var title:Boolean = true;
	private var tut:Tutorial;
	
	private const titleMax:int = 50;
	private var titleTimer:int = titleMax;
	private var change:Boolean = false;

	public var enemyMgr:EnemyMgr = new EnemyMgr();

	public static var haveHadMouseover:Boolean = false;

	public function Game () {
		FP.watch("id");
		FP.watch("fadeOut");
		hud = new HUD(this);
		mainEmitter = new EmitterExtra();

		add(new Background());
		add(new Cloud());

		add(new Player());
		
		tut = new Tutorial();
		add(tut);

		cursor.blend = "add";
		cursor.scale = 0.25;
		
		titleDog.scale = 0.5;
		
		music.loop();
	}
	
	override public function update():void
	{
		if (Input.mouseX || Input.mouseY)
			haveHadMouseover = true;

		if (mute && music.volume == 1)
			music.volume = 0;
			
		if (Input.pressed(Key.M))
		{
			if (music.volume == 1)
			{
				music.volume = 0;
				mute = true;
			}
			else
			{
				music.volume = 1;
				mute = false;
			}
		}
		
		if (Input.pressed(Key.P))
		{
			if (!pause)
			{
				pause = true;
				music.volume = 0;
			}
			else
			{
				pause = false;
				music.volume = 1;
			}
		}

		if (Input.mousePressed) 
		{
			if (title)
			{
				change = true;
			}
			if (pause) {
				pause = false;
				music.volume = 1;
			}
		}
		
		if (change)
		{
			titleTimer--;
			titleDog.alpha = titleTimer / titleMax;
			titleText.alpha = titleTimer / titleMax;
			if (titleDog.alpha <= 0)
			{
				title = false;
				tutorial = true;
				tut.visible = true;
				change = false;
			}
		}

		frameNumber++;
		
		//trace(tutorial);
		
		if (title)
		{
			var play:Array = [];
			getClass(Player, play);
			play[0].update();
			tut.visible = false;
		}
		else if (tutorial)
		{
			var pl:Array = [];
			getClass(Player, pl);
			pl[0].update();
			tut.update();		
		}
		else
		{
			if (!pause)
			{
				var p:Array = [];
				getClass(Player, p);
				if (!p[0].dead)
				{
					super.update();
					GameManager.update();
				}
				else
				{
					var enemies:Array = [];
					FP.world.getClass(Hittable, enemies);
					for each(var enemy:Hittable in enemies)
					{
						if(enemy.fadeOut)
							enemy.update();
					}
					p[0].update();
				}
			}
		}

		hud.update();
		mainEmitter.update();
		
		// Hiding the mouse cursor doesn't seem to work (in firefox and
		// chrome) before receiving mouse events, so we do it here.
		//if (Input.mouseX || Input.mouseY)
			Input.mouseCursor = "hide";

		enemyMgr.update();

		var c:int = FP.world.typeCount("cloud");
		while (c < 3)
		{
			add(new Cloud());
			c++;
		}
	}
	
	override public function render():void
	{
		super.render();
		cursor.render(FP.buffer, new Point(Input.mouseX - cursor.width * cursor.scale / 2, Input.mouseY - cursor.height * cursor.scale / 2), FP.camera);
		if (!tutorial && !title)
			hud.render();
		if (title)
		{
			titleDog.render(FP.buffer, new Point(640 - titleDog.width / 2, 0), FP.camera);
			titleText.render(FP.buffer, new Point(25, 480 / 2 + 25), FP.camera);
		}
		mainEmitter.render(FP.buffer, new Point(), FP.camera);
		if (pause)
			paused.render(FP.buffer, new Point(640 / 2 - paused.width / 2, 480 / 2 - paused.height / 2), FP.camera);
	}
}
}

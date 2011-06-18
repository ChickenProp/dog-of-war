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
	[Embed(source = '../content/sounds/artofgardens.mp3')]
	private const MUSIC:Class;
	public var music:Sfx = new Sfx(MUSIC);
	
	//public var gameManager:GameManager = new GameManager();
	public var hud:HUD;
	public var mainEmitter:EmitterExtra;

	public function Game () {
		FP.watch("id");
		hud = new HUD(this);
		mainEmitter = new EmitterExtra();

		add(new Background());
		add(new Cloud());

		add(new Player());
		for (var x:int = 0; x < 10; x++)
		{
			add(new BasicEnemy());
			add(new BouncingEnemy());
		}

		cursor.blend = "add";
		music.loop();
	}
	
	override public function update():void
	{
		frameNumber++;
		
		var p:Array = [];
		getClass(Player, p);
		if (!p[0].dead)
		{
			super.update();
			GameManager.update();
		}
		else
			p[0].update();

		hud.update();
		mainEmitter.update();
		
		// Hiding the mouse cursor doesn't seem to work (in firefox and
		// chrome) before receiving mouse events, so we do it here.
		//if (Input.mouseX || Input.mouseY)
		//	Input.mouseCursor = "hide";

		var n:int = FP.world.typeCount("enemy");
		if (n < 20)
		{
			for (; n < 20; n++)
			{
				if(FP.world.classCount(BasicEnemy) <= FP.world.classCount(BouncingEnemy))
					add(new BasicEnemy());
				else
					add(new BouncingEnemy());
			}
		}
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
		cursor.render(FP.buffer, new Point(Input.mouseX - cursor.width / 2, Input.mouseY - cursor.height / 2), FP.camera);
		hud.render();
		mainEmitter.render(FP.buffer, new Point(), FP.camera);
	}
}
}

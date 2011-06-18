package {
import flash.geom.Point;
import flash.ui.Mouse;

import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;


public class Game extends World {
	public var frameNumber:int = 0;
	[Embed(source = '../content/sprites/cursor.png')]
	private const CURSOR:Class;
	private const cursor:Image = new Image(CURSOR);
	
	//public var gameManager:GameManager = new GameManager();
	public var hud:HUD;

	public function Game () {
		FP.watch("id");
		hud = new HUD(this);
		add(new Player());
		for (var x:int = 0; x < 10; x++)
		{
			add(new BasicEnemy());
			add(new BouncingEnemy());
		}

		cursor.blend = "add";
	}
	
	override public function update():void
	{
		super.update();
		frameNumber++;

		GameManager.update();
		hud.update();
		
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
	}
	
	override public function render():void
	{
		super.render();
		cursor.render(FP.buffer, new Point(Input.mouseX - cursor.width / 2, Input.mouseY - cursor.height / 2), FP.camera);
		hud.render();
	}
}
}

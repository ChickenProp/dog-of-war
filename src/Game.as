package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;
import flash.ui.Mouse;


public class Game extends World {
	public var frameNumber:int = 0;

	public function Game () {
		add(new Player());
		for (var x:int = 0; x < 10; x++)
		{
			add(new BasicEnemy());
			add(new BouncingEnemy());
		}
	}
	
	override public function update():void
	{
		super.update();
		frameNumber++;

		// Hiding the mouse cursor doesn't seem to work (in firefox and
		// chrome) before receiving mouse events, so we do it here.
		if (Input.mouseX || Input.mouseY)
			Input.mouseCursor = "hide";


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
}
}

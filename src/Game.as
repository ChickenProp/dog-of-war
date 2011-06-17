package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;
import flash.ui.Mouse;


public class Game extends World {
	public function Game () {
		//Input.mouseCursor = "hide";
		Mouse.hide();
		add(new Player());
		for (var x:int = 0; x < 10; x++)
			add(new BasicEnemy());
	}
	
	override public function update():void
	{
		super.update();
		var n:int = FP.world.typeCount("enemy");
		if (n < 10)
		{
			for (; n < 10; n++)
				add(new BasicEnemy());
		}
	}
}
}

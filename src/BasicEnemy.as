package  
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Sarah
	 */
	public class BasicEnemy extends Entity
	{

		public static var count:int = 0;
		public var id:int;
		
		public function BasicEnemy() 
		{
			graphic = Image.createRect(5, 5, 0xFF6600);
			(graphic as Image).centerOO();
			x = 640 + FP.rand(100);
			y = FP.rand(480);
			setHitbox(5, 5);
			type = "enemy";
			id = count++;
			layer = 100;
		}

		override public function update () : void {
			x -= 1;
			if (x < 0)
				FP.world.remove(this);
		}
	}

}

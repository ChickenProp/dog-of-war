package  
{
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Laser extends BasicEnemy
	{
		[Embed(source = '../content/sprites/laser.png')]
		private const LASER:Class;
		private var sprite:Image;
		
		public function Laser(xStart:int, yStart:int) 
		{
			sprite = new Image(LASER);
			sprite.centerOrigin();
			graphic = sprite;
			
			setHitbox(25, 3);
			centerOrigin();
			
			x = xStart;
			y = yStart;
			
			type = "bullet"; // Not "enemy" for counting purposes.
			layer = 75;
		}
		
		override public function update():void
		{
			x -= 2;
			if (x < 0)
				FP.world.remove(this);
		}
	}

}

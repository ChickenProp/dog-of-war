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
	public class Laser extends Hittable
	{
		[Embed(source = '../content/sprites/laser.png')]
		private const LASER:Class;
		
		public function Laser(xStart:int, yStart:int) 
		{
			sprite = new Image(LASER);
			sprite.centerOrigin();
			graphic = sprite;
			
			setHitbox(25, 3);
			centerOrigin();
			
			x = xStart;
			y = yStart;
			
			type = "enemy";
			layer = 75;

			pointsValue = 50;
		}
		
		override public function update():void
		{
			if (fadeOut)
			{
				fadeTimer--;
				sprite.alpha = fadeTimer / fadeMax;
				if (sprite.alpha <= 0)
					FP.world.remove(this);
			}
			else
			{
				x -= 2;
				if (x < 0)
					FP.world.remove(this);
			}
		}
	}

}

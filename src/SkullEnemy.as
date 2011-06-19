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
	public class SkullEnemy extends BasicEnemy
	{
		[Embed(source = '../content/sprites/skullFly.png')]
		private const SKULLANIM:Class;
		
		private const stillTime:int = 50;
		private const fireTime:int = 100;
		
		private var sprite:Image;
		private var animatedSprite:Spritemap;
		
		private var timer:Number = 2 * Math.PI;
		private var fireTimer:Number = fireTime;
		private var intervalTimer:Number = stillTime;
		private var fire:Boolean = true;
		
		public function SkullEnemy() 
		{
			super();
			animatedSprite = new Spritemap(SKULLANIM, 100, 100);
			animatedSprite.add("fly", [0, 1, 2, 3], 3);
			animatedSprite.play("fly");			
			
			sprite = animatedSprite;
			sprite.centerOrigin();
			graphic = sprite;
			
			setHitbox(20, 20);
			centerOrigin();
			
			timer = FP.rand(timer + 1);
		}
		
		override public function update():void
		{
			if (fireTimer < 0)
			{
				if (fire)
				{
					FP.world.add(new Laser(x - 10, y - 7));
					FP.world.add(new Laser(x, y - 3));
					fire = false;
				}
				intervalTimer--;
				if (intervalTimer < 0)
				{
					intervalTimer += stillTime;
					fireTimer += fireTime;
					fire = true;
				}
			}
			else
			{
				fireTimer--;
				super.update();
				y += Math.sin(timer);
				timer -= 0.03;
				if (timer < 0)
					timer += 2 * Math.PI;
			}
		}
		
	}

}
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
	public class Hittable extends Entity
	{

		[Embed(source = '../content/sprites/basic.png')]
		private const BASIC:Class;
		public var sprite:Image = new Image(BASIC);

		public static var count:int = 0;
		public var id:int;
		
		public var pointsValue:int = 100;

		public var vel:vec = new vec(-FP.random*2 - 0.5, 0);

		public var fadeOut:Boolean = false;
		public var fadeMax:int = 50;
		public var fadeTimer:int = fadeMax;

		public function Hittable() 
		{
			graphic = sprite;
			(graphic as Image).centerOO();
			x = 660 + FP.rand(80);
			y = FP.rand(420) + 30;
			setHitbox(5, 5);
			centerOrigin();
			type = "enemy";
			id = count++;
			layer = 100;
		}

		override public function update () : void {
			if (fadeOut)
			{
				fadeTimer--;
				sprite.alpha = fadeTimer / fadeMax;
				if (sprite.alpha <= 0)
					FP.world.remove(this);
			}
			else
			{
				x += vel.x;
				y += vel.y;
				if (x < 0)
					FP.world.remove(this);
			}
		}

		public function hit () : Boolean {
			KilledByPlayer();
			return true;
		}
		
		public function KilledByPlayer():void
		{
			Destroy();
		}
		
		public function ExplodeWithParticles():void
		{
			for (var i:int = 0; i < 10 ; i++)
			{
				if(FP.world is Game)
				{
					var tempGame:Game = FP.world as Game;
					
					
					tempGame.mainEmitter.CreateParticles(
						"star_mid",
						x + (10 * Math.sin((Math.PI * 2 / 10) * i)),
						y + (10 * Math.cos((Math.PI * 2 / 10) * i)));
				}
			}
		
		}
		
		public function getScoreMult(m:int) :void
		{
			GameManager.addScore(pointsValue*m, x, y);
		}
		
		public function Destroy() : void
		{
			
			FP.world.remove(this);
		}
	}

}

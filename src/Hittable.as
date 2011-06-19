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

		public static var count:int = 0;
		public var id:int;
		
		public var pointsValue:int = 100;

		public var vel:vec = new vec(-FP.random*2 - 0.5, 0);

		
		public function Hittable() 
		{
			graphic = Image.createRect(5, 5, 0xFF6600);
			(graphic as Image).centerOO();
			x = 640 + FP.rand(100);
			y = FP.rand(360) + 60;
			setHitbox(5, 5);
			centerOrigin();
			type = "enemy";
			id = count++;
			layer = 100;
		}

		override public function update () : void {
			x += vel.x;
			y += vel.y;
			if (x < 0)
				FP.world.remove(this);
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
		
		public function GenerateScoreParticle(forScore:int) :void
		{
			
			if(FP.world is Game)
			{
				var tempGame:Game = FP.world as Game;
				var tempString:String = forScore.toString();
				
				var newParticle:TextParticle = tempGame.mainEmitter.AddTextObject(tempString, x, y, 0, -2);
				newParticle.color = 0xEE8800;

				
			}
		}
		
		public function Destroy() : void
		{
			
			FP.world.remove(this);
		}
	}

}
package  
{

public class BasicEnemy extends Hittable {
		public static var count:int = 0;
		public var id:int;

		[Embed(source = '../content/sprites/basic.png')]
		private const BASIC:Class;
		public var sprite:Image = new Image(BASIC);
		
		public var pointsValue:int = 100;
		public var fadeOut:Boolean = false;
		public var fadeMax:int = 50;
		public var fadeTimer:int = fadeMax;

		public var vel:vec = new vec(-FP.random*2 - 0.5, 0);

		
		public function BasicEnemy() 
		{
			graphic = sprite;
			x = 640 + FP.rand(100);
			y = FP.rand(360) + 60;
			setHitbox(5, 5);
			centerOrigin();
			type = "enemy";
			id = count++;
			layer = 100;
		}

		override public function update () : void 
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
				x += vel.x;
				y += vel.y;
				if (x < 0)
					FP.world.remove(this);
			}
		}

		public function hit (comboSize:int) : void {
			KilledByPlayer(comboSize);
		}
		
		public function KilledByPlayer(comboSize:int):void
		{
			
			GameManager.score += pointsValue * comboSize;
			
			ExplodeWithParticles();
			GenerateScoreParticle(pointsValue * comboSize);
			
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

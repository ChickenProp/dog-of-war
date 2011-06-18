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
	public class BasicEnemy extends Entity
	{

		public static var count:int = 0;
		public var id:int;
		
		public var pointsValue:int = 100;

		
		public function BasicEnemy() 
		{
			graphic = Image.createRect(5, 5, 0xFF6600);
			(graphic as Image).centerOO();
			x = 610 + FP.rand(100);
			y = FP.rand(480);
			setHitbox(5, 5);
			type = "enemy";
			id = count++;
		}

		override public function update () : void {
			x -= 1;
			if (x < 0)
				FP.world.remove(this);
		}
		
		public function KilledByPlayer(comboSize:int):void
		{
			
			GameManager.score += pointsValue * comboSize;
			
			ExplodeWithParticles();
			
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
		
		public function Destroy() : void
		{
			
			FP.world.remove(this);
		}
	}

}

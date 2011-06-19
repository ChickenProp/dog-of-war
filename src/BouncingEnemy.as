package  
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author Sarah
	 */
	public class BouncingEnemy extends Mine
	{
		private var moveAngle:Number;
		[Embed(source = '../content/sprites/mineSprite.png')]
		private const MINE:Class;
		
		public function BouncingEnemy() 
		{
			super();
			sprite = new Image(MINE);
			sprite.scale = 0.25;
			sprite.centerOrigin();
			graphic = sprite;
			centerOrigin();
			moveAngle = FP.rand(160) + 10;
			layer = 100;
			pointsValue = 100;
		}
		
		override public function update () : void 
		{
			moveAngle++;
			vel.y = Math.cos(moveAngle * Math.PI / 180);
			super.update();
		}
		
	}

}

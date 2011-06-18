package  
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author Sarah
	 */
	public class BouncingEnemy extends BasicEnemy
	{
		private var moveAngle:Number;
		
		public function BouncingEnemy() 
		{
			super();
			graphic = Image.createRect(5, 5, 0x7CFC00);
			(graphic as Image).centerOO();
			moveAngle = FP.rand(160) + 10;
			layer = 100;
		}
		
		override public function update () : void 
		{
			// Math.sin(moveAngle * Math.PI / 180);
			y -= Math.cos(moveAngle * Math.PI / 180);
			if (y < 0 || y > 480)
				moveAngle = 180 -moveAngle;
			super.update();
		}
		
	}

}
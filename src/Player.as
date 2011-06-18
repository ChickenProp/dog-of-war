package {
	import flash.events.IMEEvent;
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class Player extends Entity 
	{
		[Embed(source = '../content/sprites/plane.png')]
		private const PLANE:Class;
		[Embed(source = '../content/sprites/live.png')]
		private const LIVE:Class;
		private const lifeIcon:Image = new Image(LIVE);
		private var sprite:Image;
		public var trail:Trail = new Trail();
		public var lives:int = 3;
		
		public function Player () 
		{
			sprite = new Image(PLANE);
			sprite.centerOrigin();
			graphic = sprite;
			x = 0;
			y = 0;
		}
			
		override public function update () : void 
		{		
			super.update();
			
			var v:Vector.<Number> = new Vector.<Number>(2);
			v[0] = Input.mouseX - x;
			v[1] = Input.mouseY - y;
			
			var l:Number = Math.sqrt(v[0] * v[0] + v[1] * v[1]);
			var targetRot:Number = 0;
			
			if (l > 5) 
			{
				targetRot = Math.atan2(v[1] / l, v[0] / l) * FP.DEG;
			} 
			else 
			{
				targetRot += FP.angleDiff(targetRot, 0) * 0.05;
			}
			
			var angleDiff:Number = FP.angleDiff(sprite.angle, targetRot);
			sprite.angle += angleDiff * ((l < 5) ? 0.2 : 0.4);
			
			x = Input.mouseX;
			y = Input.mouseY;

			trail.addxy(x,y);

			var col:int = trail.checkCollision();
			if (col > -1) {
				trail.segments[col].tint = 0x0000FF;
				trail.segments[trail.segments.length - 1].tint = 0x0000FF;
			}
		}

		override public function render () : void {
			trail.draw();
			for (var x:int = 0; x < lives; x++)
			{
				lifeIcon.render(FP.buffer, new Point( 10 + 45 * x, 480 - 10 - 45), FP.camera);
			}
			super.render();
		}
	}
}

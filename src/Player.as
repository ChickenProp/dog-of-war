package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class Player extends Entity 
	{
		[Embed(source = '../content/sprites/plane.png')]
		private const PLANE:Class;
		private var sprite:Image;
		public var trail:Trail = new Trail();
		
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
				closeLoop(col);
				for (var i:int = col; i < trail.segments.length; i++)
					trail.segments[i].tint = 0x0000FF;
			}
		}

		public function closeLoop(seg:int) : void {
			var enemies:Array = [];
			world.getType("enemy", enemies);

			for (var i:int = 0; i < enemies.length; i++) {
				var e:BasicEnemy = enemies[i] as BasicEnemy;
				FP.console.log("testing enemy " + e.id + new vec(e.x, e.y));
				if (trail.contains(new vec(e.x, e.y), seg, trail.segments.length-1)) {
					FP.console.log("removing enemy " + e.id);
					FP.world.remove(e);
				}
			}
		}

		override public function render () : void {
			trail.draw();
			super.render();
		}
	}
}

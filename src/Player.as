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
		
		private var motionPath:Array = new Array();
		private var maxSpeed:Number = 15;
		
		public function Player () 
		{
			sprite = new Image(PLANE);
			sprite.centerOrigin();
			graphic = sprite;
			setHitbox(32, 16);
			type = "player";
			x = 0;
			y = 0;
		}
			
		override public function update () : void 
		{		
			super.update();

			/*x = Input.mouseX;
			y = Input.mouseY;*/
			
			var oldX:Number = x;
			var oldY:Number = y;
			
			//AddToMotionPath();
			//MoveToMotionPath();
			
			MoveToCursor();			
			
			AngleSprite(oldX, oldY, x, y);

			trail.addxy(x,y);
			
			var e:BasicEnemy = collide("enemy", x, y) as BasicEnemy;

			if (e)
			{
				//lives--;
				GameManager.lives--;
				e.x = -1; 	//Will destroy and create new
				if (lives < 1)
					{}
			}
		}
		
		private function AddToMotionPath() : void
		{
			var newPoint:vec = new vec(Input.mouseX, Input.mouseY);
			
			motionPath.push(newPoint);
		}
		
		private function MoveToMotionPath() : void
		{
			var nextPoint:vec;
			
			if(motionPath.length > 0)
			{
				nextPoint = motionPath[0];
			}
			
			if (nextPoint)
			{
				//move to the point
				
				var tempDistance:Number = MathExtra.Pythagoras(x, y, nextPoint.x, nextPoint.y);
				
				if(tempDistance <= maxSpeed)
				{
					x = nextPoint.x;
					y = nextPoint.y;
					
					motionPath.splice(motionPath[0]);
				}
				else
				{
					var tempDirection:vec = new vec(nextPoint.x - x, nextPoint.y - y);
					tempDirection.setNormalize();
					tempDirection.setmul(maxSpeed);
					
					x += tempDirection.x;
					y += tempDirection.y;
				}
				
			}
			
		}
		
		private function MoveToCursor() : void
		{
			var nextPoint:vec = new vec(Input.mouseX, Input.mouseY);
			
			var tempDistance:Number = MathExtra.Pythagoras(x, y, nextPoint.x, nextPoint.y);
			
			if(tempDistance <= maxSpeed)
			{
				x = nextPoint.x;
				y = nextPoint.y;
				
				motionPath.splice(motionPath[0]);
			}
			else
			{
				var tempDirection:vec = new vec(nextPoint.x - x, nextPoint.y - y);
				tempDirection.setNormalize();
				tempDirection.setmul(maxSpeed);
				
				x += tempDirection.x;
				y += tempDirection.y;
			}
		}
		
		private function AngleSprite(oldX:Number, oldY:Number, newX:Number, newY:Number) :void{
			
			var v:Vector.<Number> = new Vector.<Number>(2);
			v[0] = newX - oldX;
			v[1] = newY - oldY;
			
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

			var col:int = trail.checkCollision();
			if (col > -1) {
				trail.segments[col].tint = 0x0000FF;
				trail.segments[trail.segments.length - 1].tint = 0x0000FF;
			}

		}

		override public function render () : void {
			trail.draw();
			//note - Ali moved the life drawing to HUD.as
			/*for (var x:int = 0; x < lives; x++)
			{
				lifeIcon.render(FP.buffer, new Point( 10 + 45 * x, 480 - 10 - 45), FP.camera);
			}*/
			super.render();
		}
	}
}

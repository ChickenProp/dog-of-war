package {
	import flash.events.IMEEvent;
	import flash.geom.Point;
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class Player extends Entity 
	{
		[Embed(source = '../content/sprites/live.png')]
		private const LIVE:Class;
		private const lifeIcon:Image = new Image(LIVE);
		
		[Embed(source = '../content/sprites/dogPlaneAnim.png')]
		private const DOGPLANEANIM:Class;
		
		[Embed(source = '../content/sprites/deadText.png')]
		private const DTEXT:Class;
		private const dText:Image = new Image(DTEXT);
		
		//tinning.mp3 from james duckett - thefreesoundproject
		[Embed(source = '../content/sounds/tinning.mp3')]
		private const TING:Class;
		public var ting:Sfx = new Sfx(TING);
		
		//hit-28.mp3 from adcbicycle - thefreesoundproject
		[Embed(source = '../content/sounds/hit-28.mp3')]
		private const HIT:Class;
		public var hit:Sfx = new Sfx(HIT);
		
		//canon.mp3 from man - thefreesoundproject
		[Embed(source = '../content/sounds/canon.mp3')]
		private const DEATH:Class;
		public var death:Sfx = new Sfx(DEATH);
		
		private var sprite:Image;
		private var animatedSprite:Spritemap;
		public var trail:Trail = new Trail();
		public var dead:Boolean = true;
		
		private var motionPath:Array = new Array();
		private var maxSpeed:Number = 15;
		private var increase:Boolean = false;
		
		private var numberInCombo:int = 0;
		
		private var minSegmentLength:Number = 2;
		
		public function Player () 
		{
			animatedSprite = new Spritemap(DOGPLANEANIM, 100, 100);
			animatedSprite.add("wobble", [0, 1, 2, 3], 1);
			animatedSprite.play("wobble");
			
			sprite = animatedSprite;
			sprite.centerOrigin();
			graphic = sprite;
			setHitbox(16, 16);
			type = "player";
			x = 320;
			y = 240;
			layer = 100;
			centerOrigin();
		}
			
		override public function update () : void 
		{				
			super.update();
			
			var oldX:Number = x;
			var oldY:Number = y;
			
			MoveToCursor();			
			
			AngleSprite(oldX, oldY, x, y);

			updateVulnerability();

			if (!dead)
			{
				sprite.alpha = 1;
				
				var addNewSegment:Boolean = true;
				
				if(trail.numSegments > 1)
				{
					if(MathExtra.Pythagoras(x,y,
						trail.segments[trail.numSegments - 1].end.x,
						trail.segments[trail.numSegments - 1].end.y) < minSegmentLength)
					{
						addNewSegment = false;
					}
				}
				
				if(addNewSegment)
				{
					trail.addxy(x,y);	
				}
				else
				{
					trail.RetractToMinLength();
				}
				
				
				var e:Hittable = collide("enemy", x, y) as Hittable;

				if (e && !e.fadeOut)
				{
					if(!Game.mute)
						hit.play();

					e.Destroy();

					if (!isInvulnerable()) {
						GameManager.lives--;
						makeInvulnerable();
					}

					if (GameManager.lives < 1)
					{
						Data.writeInt("highscore", GameManager.score);
						
						for (var i:int = 0; i < 10 ; i++)
						{
							if(FP.world is Game)
							{
								var tempGame:Game = FP.world as Game;
								
								tempGame.mainEmitter.CreateParticles(
									"smoke",
									x + (10 * Math.sin((Math.PI * 2 / 10) * i)),
									y + (10 * Math.cos((Math.PI * 2 / 10) * i)));
							}
						}
						dead = true;
						if(!Game.mute)
							death.play();
						trail.empty();
						
						var enemiesToFade:Array = [];
						FP.world.getClass(Hittable, enemiesToFade);
						for each(var enemy:Hittable in enemiesToFade)
						{
							enemy.fadeOut = true;
						}
					}
				}
			}
			else
			{
				//blink and click to continue
				if (!increase)
					sprite.alpha -= 0.02;
				if (increase)
					sprite.alpha += 0.02;
				if (sprite.alpha >= 1)
					increase = false;
				if (sprite.alpha <= 0)
					increase = true;
				
				FP.console.log(dead + ", " + !Game.tutorial + ", " + !Game.title);
				
				if (Input.mousePressed && !Game.tutorial && !Game.title)
				{
					// The mouse button was just pressed this frame.
					dead = false;
					GameManager.reset();
				}
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
			if (! Game.haveHadMouseover)
				return;

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
				closeLoop(col);
			}
		}

		public function closeLoop(seg:int) : void {
			var enemies:Array = [];
			world.getClass(Hittable, enemies);
			
			var enemiesKilled:Array = new Array();
			
			for (var i:int = 0; i < enemies.length; i++) 
			{
				var e:Hittable = enemies[i] as Hittable;
				if (e)
				{
					if (trail.contains(new vec(e.x, e.y), seg, trail.segments.length-1)) {
						if (e.hit())
							enemiesKilled.push(e);
					}
				}
			}
			
			numberInCombo = enemiesKilled.length;
			
			for each(var tempEnemy:Hittable in enemiesKilled) {
				tempEnemy.ExplodeWithParticles();
				tempEnemy.getScoreMult(numberInCombo);
			}
			
			if(numberInCombo > 0 && !Game.mute)
				ting.play();

			if (numberInCombo > 1)
				MakeComboText(numberInCombo);

			trail.cut(seg);
		}

		private function MakeComboText(forNumber:int):void
		{

				if(FP.world is Game)
				{
					var tempGame:Game = FP.world as Game;
					var tempString:String = forNumber.toString() + "x COMBO"
					
					var newParticle:TextParticle = tempGame.mainEmitter.AddTextObject(tempString, x, y, 0, -3);
					newParticle.color = 0xFF0000;	
					
					//FP.log("combo " + forNumber.toString());
				}
			
		}
		
		override public function render () : void {
			trail.draw();
			//note - Ali moved the life drawing to HUD.as
			super.render();
			if (dead && !Game.tutorial)
				dText.render(FP.buffer, new Point(640 - dText.width, 480 - dText.height - 10), FP.camera);
		}

		public var invulntime:int = 0;
		public var invulncolor:uint = 0xFFFFFF;

		public function makeInvulnerable () : void {
			invulntime = 30;
		}

		public function isInvulnerable () : Boolean {
			return invulntime > 0;
		}

		public function updateVulnerability () : void {
			if (dead) {
				invulntime = 0;
				invulncolor = 0x000000;
			}
			else {
				invulntime--;
				if (invulntime > 14)
					invulncolor -= 0x001111;
				else if (invulntime > 0)
					invulncolor += 0x001111;
				else if (invulntime <= 0)
					invulncolor = 0xFFFFFF;
			}

			(graphic as Image).color = invulncolor;
		}
	}
}

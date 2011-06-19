package  
{
	import flash.display.InteractiveObject;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Tutorial extends Entity
	{
		[Embed(source = '../content/sprites/tutorial.png')]
		private const TUTORIAL:Class;
		private var tutAnimation:Spritemap;
		private var sprite:Image;
		
		[Embed(source = '../content/sprites/tutText.png')]
		private const TEXT:Class;
		private var text:Image = new Image(TEXT);
		
		[Embed(source = '../content/sprites/ttext.png')]
		private const TTEXT:Class;
		private var ttext:Image = new Image(TTEXT);
		
		private const timeMax:int = 300;
		private var timer:Number = timeMax;
		
		public function Tutorial() 
		{
			tutAnimation = new Spritemap(TUTORIAL, 150, 150);
			tutAnimation.add("run", [0, 1, 2, 3, 4, 4, 4, 4, 4], 3);
			tutAnimation.play("run");
			
			sprite = tutAnimation;
			sprite.centerOrigin();
			graphic = sprite;
			
			x = 640 / 2;
			y = 480 / 2;
			
			layer = 0;
		}
		
		override public function update():void
		{
			super.update();
			tutAnimation.update();
			timer--;
			sprite.alpha = timer / timeMax;
			text.alpha = sprite.alpha;
			
			var pl:Array = [];
			FP.world.getClass(Player, pl);
			ttext.alpha = pl[0].graphic.alpha;
			
			if (timer < 0)
			{
				FP.world.remove(this);
				Game.tutorial = false;
			}
			FP.console.log(x + ", " + y);
		}
		
		override public function render():void
		{
			super.render();
			text.render(FP.buffer, new Point(x - text.width / 2, y - 150), FP.camera);
			ttext.render(FP.buffer, new Point(), FP.camera);
		}
	}

}
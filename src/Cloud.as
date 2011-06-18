package  
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Sarah
	 */
	public class Cloud extends Entity
	{
		[Embed(source = '../content/sprites/cloud1.png')]
		private const CLOUD1:Class;
		[Embed(source = '../content/sprites/cloud2.png')]
		private const CLOUD2:Class;
		[Embed(source = '../content/sprites/cloud3.png')]
		private const CLOUD3:Class;
		private var sprite:Image;
		
		public function Cloud() 
		{
			super();	
			var sRand:int = FP.rand(2);
			switch(sRand)
			{
				case(0): sprite = new Image(CLOUD1); break;
				case(1): sprite = new Image(CLOUD2); break;
				case(2): sprite = new Image(CLOUD3); break;
			}
			graphic = sprite;
			x = 640 + FP.rand(640);
			y = FP.rand(480);
			type = "cloud";
			layer = 150;
		}
		
		override public function update():void
		{
			x--;
			if (x + sprite.width < 0)
				FP.world.remove(this);
		}
		
	}

}
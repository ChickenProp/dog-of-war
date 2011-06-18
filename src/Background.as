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
	public class Background extends Entity
	{	
		[Embed(source = '../content/sprites/background.png')]
		private const BG:Class;
		private var sprite:Image;
		private const changeInterval:int = 15000;
		private var previousScore:int = 0;
		private var change:Boolean = false;
		
		public function Background() 
		{
			super();
			sprite = new Image(BG);
			graphic = sprite;
			layer = 200;
		}
		
		override public function update():void
		{
			var scoreDiff:int = GameManager.distanceTravelled - previousScore;
			if (scoreDiff > changeInterval)
			{
				previousScore = GameManager.distanceTravelled;
				if (x == 0)
					change = true;
				if (x == -960)
					change = true;
			}
			if (change)
			{
				x--;
				if (x == 0 || x == -960)
					change = false;
				if (x == -1920)
				{
					x = 0;
					change = false;
				}
				previousScore = 0;
			}
			FP.console.log(x);
		}
	}

}
package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	public class Mine extends Hittable 
	{
		[Embed(source = '../content/sprites/mineSprite.png')]
		private const MINE:Class;
		
		public function Mine () 
		{
			super();
			sprite = new Image(MINE);
			sprite.scale = 0.25;
			sprite.centerOrigin();
			graphic = sprite;
			centerOrigin();

			pointsValue = 75;
		}
		
	}

}

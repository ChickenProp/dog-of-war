package  
{
	import net.flashpunk.*;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author Sarah
	 */
	public class SkullEnemy extends BasicEnemy
	{
		[Embed(source = '../content/sprites/skullFly.png')]
		private const SKULLANIM:Class;
		
		private var sprite:Image;
		private var animatedSprite:Spritemap;
		
		public function SkullEnemy() 
		{
			super();
			animatedSprite = new Spritemap(SKULLANIM, 100, 100);
			animatedSprite.add("fly", [0, 1, 2, 3], 3);
			animatedSprite.play("fly");			
			
			sprite = animatedSprite;
			sprite.centerOrigin();
			graphic = sprite;
			
			setHitbox(20, 20);
			centerOrigin();
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}
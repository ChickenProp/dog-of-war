package  
{
import flash.events.IMEEvent;
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class StrongEnemy extends BasicEnemy {
	public var health:int = 2;
	
	public var wobbleTimer:Number = 0;
	public var wobbleAngle:Number = 20;
	public var wobbleSpeed:Number = 0.05;

	[Embed(source = '../content/sprites/ufoSprite.png')]
	private const UFO:Class;
	private var sprite:Image;
	
	public function StrongEnemy() {
		super();

		sprite = new Image(UFO);
		graphic = sprite;
		sprite.scale = 0.5;
		sprite.centerOrigin();
		
		setHitbox(20, 20);
		centerOrigin();
	}

	override public function hit (comboSize:int) : void {
		health--;
		
		wobbleTimer += wobbleSpeed;
		var tempAngle:Number = Math.sin(wobbleTimer * Math.PI);

		graphic = Image.createRect(5, 5, 0xBB00BB);
		(graphic as Image).centerOrigin();

		if (health == 0)
			KilledByPlayer(comboSize);
	}
}
}

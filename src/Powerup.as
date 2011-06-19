package  
{
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class Powerup extends Hittable {
	public var health:int = 3;

	[Embed(source = '../content/sprites/powerup.png')]
	private const POWERUP:Class;
	
	public function Powerup() {
		super();

		sprite = new Image(POWERUP);
		sprite.centerOrigin();
		graphic = sprite;
		
		setHitbox(10, 10);
		centerOrigin();

		type = "powerup";
	}

	override public function hit () : Boolean {
		health--;
		
		if (health == 0) {
			KilledByPlayer();
			return true;
		}
		else
			return false;
	}

	override public function KilledByPlayer () : void {
		GameManager.lives++;
		Destroy();
	}
}

}

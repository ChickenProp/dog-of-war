package  
{
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class Powerup extends Hittable {
	public var health:int = 3;

	public function Powerup() {
		super();

		graphic = Image.createCircle(10, 0x00FFFF);
		(graphic as Image).centerOrigin();
		
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

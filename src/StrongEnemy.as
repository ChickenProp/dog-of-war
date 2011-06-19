package  
{
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class StrongEnemy extends BasicEnemy {
	public var health:int = 2;

	public function StrongEnemy() {
		super();

		graphic = Image.createRect(5, 5, 0xFF00FF);
		(graphic as Image).centerOrigin();
	}

	override public function hit (comboSize:int) : void {
		health--;

		graphic = Image.createRect(5, 5, 0xBB00BB);
		(graphic as Image).centerOrigin();

		if (health == 0)
			KilledByPlayer(comboSize);
	}
}
}

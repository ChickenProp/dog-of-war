package  
{
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class StrongEnemy extends BasicEnemy {
	public function StrongEnemy() {
		super();

		graphic = Image.createRect(5, 5, 0xFF00FF);
		(graphic as Image).centerOrigin();
	}
}
}

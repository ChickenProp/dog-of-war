package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;
import flash.ui.Mouse;


public class Game extends World {
	public function Game () {
		//Input.mouseCursor = "hide";
		Mouse.hide();
		add(new Player());
	}
}
}

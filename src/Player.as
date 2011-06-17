package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class Player extends Entity {
		public function Player () {
			graphic = Image.createTriangle(5, 0xFFFFFF);
			(graphic as Image).centerOO();
		}

		override public function update () : void {
			x = Input.mouseX;
			y = Input.mouseY;
		}
	}
}

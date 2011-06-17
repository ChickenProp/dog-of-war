package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class Player extends Entity {
		public var trail:Trail = new Trail();
		
		public function Player () {
			graphic = Image.createCircle(5, 0xFFFFFF);
			(graphic as Image).centerOO();
		}

		override public function update () : void {
			x = Input.mouseX;
			y = Input.mouseY;

			trail.addxy(x,y);
		}

		override public function render () : void {
			trail.draw();
			super.render();
		}
	}
}

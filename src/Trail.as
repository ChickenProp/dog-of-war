package {
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.debug.*;

public class Trail {
	public var coords:Vector.<vec> = new Vector.<vec>();

	public function Trail () {
	}

	public function add(loc:vec) : void {
		coords.push(loc);

		if (coords.length > 60)
			coords = coords.slice(-60);
	}
	public function addxy(x:Number, y:Number) : void {
		add(new vec(x,y));
	}

	public function draw () : void {
		if (coords.length < 2)
			return;

		for (var i:int = 0; i < coords.length-1; i++) {
			var here:vec = coords[i];
			var there:vec = coords[i+1];
			Draw.line(here.x, here.y, there.x, there.y, 0xFFFFFF);
		}
	}
}
}

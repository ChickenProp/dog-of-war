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

	// Check whether the final section intersects any other section. Returns
	// the index of that section, or -1 if none.
	public function checkCollision () : int {
		if (coords.length < 3)
			return -1;

		var v1:vec = coords[coords.length-1];
		var v2:vec = coords[coords.length-2];

		for (var i:int = 0; i < coords.length - 3; i++) {
			var v3:vec = coords[i];
			var v4:vec = coords[i+1];
			if (vec.intersecting(v1, v2, v3, v4))
				return i;
		}

		return -1;
	}
}
}

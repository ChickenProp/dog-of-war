package {
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.debug.*;


public class Trail {
	public var segments:Vector.<TrailSegment> = new Vector.<TrailSegment>();

	public function Trail () {
	}

	public function add(end:vec) : void {
		var start:vec;
		if (segments.length > 0)
			start = segments[segments.length-1].end;
		else
			start = end;

		segments.push(new TrailSegment(start, end));

		if (segments.length > 60)
			segments = segments.slice(-60);
	}
	public function addxy(x:Number, y:Number) : void {
		add(new vec(x,y));
	}

	public function draw () : void {
		if (segments.length < 2)
			return;

		for (var i:int = 0; i < segments.length; i++) {
			segments[i].draw();
		}
	}
	
	// Check whether the final section intersects any other section. Returns
	// the index of that section, or -1 if none.
	public function checkCollision () : int {
		if (segments.length < 3)
			return -1;

		var v1:vec = segments[segments.length-1].start;
		var v2:vec = segments[segments.length-1].end;

		for (var i:int = 0; i < segments.length - 2; i++) {
			var v3:vec = segments[i].start;
			var v4:vec = segments[i].end;
			if (vec.intersecting(v1, v2, v3, v4))
				return i;
		}

		return -1;
	}

	// This assumes the segments from 'start' to 'end' form a closed loop.
	// Uses the winding number algorithm: take the number of times the
	// polygon crosses a ray clockwise minus anticlockwise; this is zero iff
	// we're outside. If the ray hits a vertex, we get a phantom crossing,
	// but we can ignore this because real crossings alternate.
	public function contains (point:vec, start:int, end:int) : Boolean {
		var wind:int = 0;

		var v1:vec = point;
		var v2:vec = new vec(point.x, 0);

		var lastChange:int = 0;

		for (var i:int = start; i <= end; i++) {
			var v3:vec = segments[i].start;
			var v4:vec = segments[i].end;

			// The start and end segments will be partly outside the
			// loop, so only consider the relevant parts of them.
			if (i == start)
				v3 = vec.intersection(v3, v4, segments[end].start, segments[end].end);
			else if (i == end)
				v4 = vec.intersection(v3, v4, segments[start].start, segments[start].end);

			if (vec.intersecting(v1, v2, v3, v4)) {
				var change:int = (v3.x < v4.x ? 1 : -1);
				if (change == lastChange) // phantom
					continue;

				wind += change;
				lastChange = change;
			}
		}

		return wind != 0;
	}
}
}


package {
import net.flashpunk.*;
import net.flashpunk.debug.*;
import net.flashpunk.utils.*;


public class Trail {
	public var segments:Vector.<Segment> = new Vector.<Segment>();
	
	//swosh.mp3 from qubodup - thefreesoundproject
	[Embed(source = '../content/sounds/swosh.mp3')]
	private const CUT:Class;
	public var cutSound:Sfx = new Sfx(CUT);
	
	public var minLength:int = 5;

	public function Trail () {
	}

	public function add(end:vec) : void {
		var start:vec;
		if (segments.length > 0)
			start = segments[segments.length-1].end;
		else
			start = end;

		segments.push(new Segment(start, end));

		if (segments.length > 60)
			segments = segments.slice(-60);
	}
	public function addxy(x:Number, y:Number) : void {
		add(new vec(x,y));
	}

	public function cut(seg:int) : void 
	{
		if(!Game.mute)
			cutSound.play();
		
		for (var i:int = 0; i < numSegments - 1; i++) {
			var s:Segment = segments[i];
			(FP.world as Game).mainEmitter.CreateParticles(
			        (s.isLight() ? 
						((Math.random() < 0.5)? "lightFabric1" : "lightFabric2") : 
						((Math.random() < 0.5)? "darkFabric1" : "darkFabric2")),
				s.start.x, s.start.y
			        );
		}

		var inter:vec = segments[seg].intersection(segments[numSegments - 1]);

		segments = segments.slice(-1);
		segments[0].start = inter;
	}

	public function draw () : void {
		if (segments.length < 2)
			return;

		FP.sprite.graphics.clear();

		/* var dir1:vec;
		var dir2:vec;
		var dir3:vec;
		var offdirS:vec;
		var offdirE:vec;
		var offS:Number = 0;
		var offE:Number = 0;
		*/
		for (var i:int = 0; i < segments.length; i++) {
			/*if (i == segments.length - 1) {
				offdirE = dir2.perp();
			}

			dir1 = dir2;
			dir2 = dir3;
			dir3 = segments[i+1].dir();

			offdirS = offdirE;
			offdirE = dir2.add(dir3).normalize();

			segments[i].draw(new Segment(offdirS.mul(offS),
			offdirE.mul(offE)));
			*/

			segments[i].draw(new Segment(new vec(0,0),
			                             new vec(0,0)));
		}

		FP.buffer.draw(FP.sprite, null, null);
	}
	
	// Check whether the final section intersects any other section. Returns
	// the index of that section, or -1 if none. If the loop would have a
	// circumference of less than 50 pixels, ignore it.
	public function checkCollision () : int {
		if (segments.length < 3)
			return -1;

		var end:Segment = segments[numSegments-1];

		// Don't check the penultimate segment, since we're always
		// intersecting that.
		for (var i:int = 0; i < numSegments - 2; i++) {
			if (end.intersecting(segments[i])) {
				var len:Number = lengthFrom(i+1) + new Segment(end.intersection(segments[i]), segments[i].end).length();
				return (len > 50 ? i : -1);
			}
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

		var top:vec = new vec(point.x, 0);
		var ray:Segment = new Segment(point, top);
		
		var v1:vec = point;
		var v2:vec = new vec(point.x, 0);

		var lastChange:int = 0;

		for (var i:int = start; i <= end; i++) {
			var edge:Segment = segments[i];

			// The start and end segments will be partly outside the
			// loop, so only consider the relevant parts of them.
			if (i == start)
				edge = new Segment(edge.intersection(segments[end]), edge.end);
			else if (i == end)
				edge = new Segment(edge.start, edge.intersection(segments[start]));

			if (! ray.intersecting(edge))
				continue;
			
			var change:int = (edge.start.x < edge.end.x ? 1 : -1);
			if (change == lastChange) // phantom
				continue;

			wind += change;
			lastChange = change;
		}

		return wind != 0;
	}
	
	public function empty():void
	{
		segments = new Vector.<Segment>();
	}
	
	

	public function lengthFrom(i:int) : Number {
		var l:int = 0;
		for (var j:int = i; j < segments.length; j++)
			l += segments[j].length();
		return l;
	}

	public function get numSegments():int { return segments.length; }
	
	public function RetractToMinLength() :void
	{
		if(numSegments > minLength)
		{
			segments = segments.slice(-(numSegments - 1));
		}
	}
}
}


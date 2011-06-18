package {

public class vec {
	public var x:Number = 0;
	public var y:Number = 0;

	public function vec(_x:Number, _y:Number) {
		x = _x;
		y = _y;
	}

	public function get length() : Number {
		return Math.sqrt(x*x + y*y);
	}

	public function add(v:vec):vec {
		return new vec(x + v.x, y + v.y);
	}
	public function setadd(v:vec):vec {
		x += v.x; y += v.y;
		return this;
	}

	public function mul(n:Number):vec {
		return new vec(x * n, y * n);
	}
	public function setmul(n:Number):vec {
		x *= n; y *= n;
		return this;
	}

	public function normalize() : vec {
		var l:Number = length;

		if (l == 0)
			return new vec(0,0);
		else
			return new vec(x/l, y/l);
	}

	public function toString () : String {
		return "(" + x + ", " + y + ")";
	}

	// Returns the point of intersection of the (infinite) lines passing
	// through v1 and v2, and v3 and v4. NB. This may not be in the finite
	// line segments bounded by these points.

	// If the lines are parallel, this returns (NaN, NaN), even if they
	// overlap.
	public static function intersection (v1:vec, v2:vec, v3:vec, v4:vec)
		: vec
	{
		var denom:Number = ( (v1.x - v2.x)*(v3.y - v4.y)
		                     - (v1.y - v2.y)*(v3.x - v4.x) );

		if (denom == 0)
			return new vec(NaN, NaN);

		var px:Number = ( (v1.x*v2.y - v1.y*v2.x)*(v3.x - v4.x)
		                  - (v1.x - v2.x)*(v3.x*v4.y - v3.y*v4.x) ) ;
		var py:Number = ( (v1.x*v2.y - v1.y*v2.x)*(v3.y - v4.y)
		                  - (v1.y - v2.y)*(v3.x*v4.y - v3.y*v4.x) ) ;

		return new vec(px/denom, py/denom);
	}

	// Returns true if the finite line segments bounded by v1 and v2, and v3
	// and v4, are intersecting. Parallel lines are assumed not to
	// intersect, even if they do. NB. this is stricter than "intersection":
	// if that would return a point not contained in one of the vectors,
	// this returns false.
	public static function intersecting (v1:vec, v2:vec, v3:vec, v4:vec)
		: Boolean
	{
		var inter:vec = intersection(v1, v2, v3, v4);
		if (isNaN(inter.x)
		    || inter.x < v1.x && inter.x < v2.x
		    || inter.x < v3.x && inter.x < v4.x
		    || inter.y < v1.y && inter.y < v2.y
		    || inter.y < v3.y && inter.y < v4.y
		    || inter.x > v1.x && inter.x > v2.x
		    || inter.x > v3.x && inter.x > v4.x
		    || inter.y > v1.y && inter.y > v2.y
		    || inter.y > v3.y && inter.y > v4.y)
			return false;

		return true;
	}

}
}

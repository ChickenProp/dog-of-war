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
}

}

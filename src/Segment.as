package {
import flash.display.Graphics;
import flash.geom.Point;
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.debug.*;

public class Segment {
	public var start:vec;
	public var end:vec;
	public var tint:uint = 0xFFFFFF;

	public function Segment(st:vec, en:vec) {
		start = st;
		end = en;
	}

	// This only draws to FP.sprite.graphics, not to FP.buffer.
	public function draw () : void {
		var off:vec = new vec(10, 0);
		quad(this, new Segment(this.start.add(off), this.end.add(off)),
		     isLight() ? 0xFF2400 : 0xB22222 );
	}

	public function isLight() : Boolean {
		return end.y <= start.y;
	}

	public function length () : Number {
		return start.sub(end).length;
	}

	public function quad (l1:Segment, l2:Segment, color:uint) : void {
		color = color & tint;
		var thickness:Number = 1;
		var alpha:Number = 1;

		var g:Graphics = FP.sprite.graphics;

		g.lineStyle();
		g.beginFill(color, alpha);

		g.moveTo(l1.start.x, l1.start.y);
		g.lineTo(l1.end.x, l1.end.y);
		g.lineTo(l2.end.x, l2.end.y);
		g.lineTo(l2.start.x, l2.start.y);

		g.endFill();

		g.lineStyle(thickness, 0x000000, alpha);

		g.moveTo(l1.start.x, l1.start.y);
		g.lineTo(l1.end.x, l1.end.y);
		g.moveTo(l2.start.x, l2.start.y);
		g.lineTo(l2.end.x, l2.end.y);
	}

	public function intersection (other:Segment) : vec {
		return vec.intersection(start, end, other.start, other.end);
	}

	public function intersecting (other:Segment) : Boolean {
		return vec.intersecting(start, end, other.start, other.end);
	}
}
}

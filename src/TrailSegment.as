package {
import flash.display.Graphics;
import flash.geom.Point;
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.debug.*;

public class TrailSegment {
	public var start:vec;
	public var end:vec;
	public var tint:uint = 0xFFFFFF;

	public function TrailSegment(st:vec, en:vec) {
		start = st;
		end = en;
	}

	public function draw () : void {
		var v:Vector.<Point> = new Vector.<Point>(4);
		v[0] = new Point(start.x, start.y);
		v[1] = new Point(start.x + 10, start.y);
		v[2] = new Point(end.x + 10, end.y);
		v[3] = new Point(end.x, end.y);
		if (end.y > start.y)
			polygon(v, 0xB22222);
		else
			polygon(v, 0xFF2400);
		Draw.linePlus(start.x, start.y, end.x, end.y, 0x000000);
		Draw.linePlus(start.x+10, start.y, end.x+10, end.y, 0x000000);
	}

	public function polygon (points:Vector.<Point>, color:uint = 0xFFFFFF, alpha:Number = 1, filled:Boolean = true, thickness:Number = 0):void
	{
		color = color & tint;
	
		var g:Graphics = FP.sprite.graphics;
		var x:Number;
		var y:Number;
		
		g.clear();

		if (filled) {
			g.beginFill(color, alpha);
		} else {
			g.lineStyle(thickness, color, alpha);
		}

		g.moveTo(points[0].x, points[0].y);
		
		for (var i:int = 1; i < points.length; i++) {
			g.lineTo(points[i].x, points[i].y);
		}
		
		if (filled) {
			g.endFill();
		} else {
			g.lineTo(points[0].x, points[0].y);
		}
		
		FP.buffer.draw(FP.sprite, null, null);
	}
}
}

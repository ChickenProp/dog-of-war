package {
import flash.display.Graphics;
import flash.geom.Point;
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
			var v:Vector.<Point> = new Vector.<Point>(4);
			v[0] = new Point(here.x, here.y);
			v[1] = new Point(here.x + 10, here.y);
			v[2] = new Point(there.x + 10, there.y);
			v[3] = new Point(there.x, there.y);
			if (there.y > here.y)
				polygon(v, 0xB22222);
			else
				polygon(v, 0xFF2400);
			Draw.linePlus(here.x, here.y, there.x, there.y, 0x000000);
			Draw.linePlus(here.x + 10, here.y, there.x + 10, there.y, 0x000000);
		}
	}
	
	public static function polygon (points:Vector.<Point>, color:uint = 0xFFFFFF, alpha:Number = 1, filled:Boolean = true, thickness:Number = 0):void
	{
		color = color & 0xFFFFFF;
	
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

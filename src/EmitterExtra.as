package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Particle;
	import net.flashpunk.graphics.Text;
	
	
	public class EmitterExtra extends Emitter
	{
		
		[Embed(source = '../content/sprites/particles.png')]
				private const PARTICLES:Class;
		
		private var textObjects:Array = new Array();
				
		public function EmitterExtra()
		{
			super(PARTICLES, 20, 20);
			
			newType("star_mid", [0]);
			setAlpha("star_mid", 1, 0);
			setMotion("star_mid", 0, 150, 1, 360, 0);
			setGravity("star_mid", 3);
			
			newType("star_small", [1]);
			setAlpha("star_small", 1, 0);
			setGravity("star_small", 3);
			
		}
		
		override public function update() :void
		{
			super.update();
			
			var oldTextObjects:Array = new Array();
			for each(var myText:TextParticle in textObjects)
			{
				myText.update();
			
				
			}
		}
		
		public function CreateParticles(myType:String, atX:Number = 0, atY:Number = 0) : void
		{
			var newParticle:Particle = emit(myType, atX, atY);
		}
		
		public function AddTextObject(myString:String, atX:Number = 0, atY:Number = 0, movX:Number = 0, movY:Number = 0) : TextParticle
		{
			var newTextObj:TextParticle = new TextParticle(myString, atX, atY, movX, movY);
			
			textObjects.push(newTextObj);
			
			return newTextObj;
			
		}
		
		
		override public function render(target:BitmapData, point:Point, camera:Point):void
		{
			super.render(target,point,camera);
			
			
		}
	}
}
package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Particle;
	import net.flashpunk.graphics.Text;
	
	
	public class EmitterExtra extends Emitter
	{
		
		[Embed(source = '../content/sprites/particles2.png')]
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
			setMotion("star_small", 0, 150, 1, 360, 0);
			
			newType("smoke", [3]);
			setAlpha("smoke", 0.6, 0);
			setGravity("smoke", 0);
			setMotion("smoke", 90, 100, 2, 20);
			
			newType("darkFabric1", [4]);
			setAlpha("darkFabric1", 1, 0);
			setGravity("darkFabric1", 1);
			setMotion("darkFabric1", 0, 50, 1.5, 360, 0);
			
			newType("darkFabric2", [5]);
			setAlpha("darkFabric2", 1, 0);
			setGravity("darkFabric2", 1);
			setMotion("darkFabric2", 0, 50, 1.5, 360, 0);
			
			newType("lightFabric1", [6]);
			setAlpha("lightFabric1", 1, 0);
			setGravity("lightFabric1", 1);
			setMotion("lightFabric1", 0, 50, 1.5, 360, 0);
			
			newType("lightFabric2", [8]);
			setAlpha("lightFabric2", 1, 0);
			setGravity("lightFabric2", 1);
			setMotion("lightFabric2", 0, 50, 1.5, 360, 0);
		}
		
		override public function update() :void
		{
			super.update();
			
			var oldTextObjects:Array = new Array();
			for each(var myText:TextParticle in textObjects)
			{
				myText.update();
			
				if(myText.toDelete)
				{
					oldTextObjects.push(myText);
				}
				
			}
			
			for each(var textToDelete:TextParticle in oldTextObjects)
			{
				textObjects.splice(textToDelete);
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
			
			for each(var myText:TextParticle in textObjects)
			{
				
				myText.render(FP.buffer, new Point(), FP.camera);
				FP.log("RENDERS " + myText.text);
			}
			
			
		}
	}
}
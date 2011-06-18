package
{
	import net.flashpunk.graphics.Text;

	public class TextParticle extends Text
	{
		public var movX:Number = 0;
		public var movY:Number = 0;
		public var maxTime:Number = 60;
		public var timer:Number = 0;
		
		public var toDelete:Boolean = false;
		
		public function TextParticle(myText:String, myX:Number, myY:Number, myMovX:Number, myMovY:Number)
		{
			super(myText, myX, myY);
			
			movX = myMovX;
			movY = myMovY;
		}
		
		public override function update() : void
		{
			super.update();
			
			x += movX;
			y += movY;
			
			timer ++;
			if(timer >= maxTime)
			{
				toDelete = true;
			}
		}
	}
}
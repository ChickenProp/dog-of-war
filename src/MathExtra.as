package
{
	public class MathExtra
	{
		public function MathExtra()
		{
		}
		
		public static function Pythagoras(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var tempPyth:Number = ((x1 - x2) * (x1 - x2)) + ((y1 - y2) * (y1 - y2));
			
			tempPyth = Math.sqrt(tempPyth);
			
			return tempPyth;
			
		}
	}
}
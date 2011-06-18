package
{
	import net.flashpunk.FP;

	public class GameManager
	{
		static public var playtime:Number = 0;
		static public var distanceTravelled:Number = 0;
		static public var travellingSpeed:Number = 50;
		
		static public var score:int = 0;
		static public var visibleScore:int = 0;
		static public var scoreCountUpSpeed:int = 25;
		
		static public var lives:int = 3;
		
		public function GameManager()
		{
			
		}
		
		static public function update():void
		{
			playtime += 1;
			distanceTravelled += travellingSpeed;
			
			if(visibleScore < score)
			{
				visibleScore += scoreCountUpSpeed;
			}
			
			if(visibleScore >= score)
			{
				visibleScore = score;
			}
			
			//FP.log(distanceTravelled);
		}
	}
}
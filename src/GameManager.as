package
{
	import net.flashpunk.FP;

	public class GameManager
	{
		static public var playtime:Number = 0;
		static public var distanceTravelled:Number = 0;
		static public var travellingSpeed:Number = 5;
		
		static public var score:int = 0;
		static public var visibleScore:int = 0;
		static public var scoreCountUpSpeed:int = 25;
		
		static public var lives:int = 3;
		
		public function GameManager()
		{
			
		}

		static public function addScore(s:int, x:Number, y:Number) : void {
			var tempGame:Game = FP.world as Game;
			var tempString:String = s.toString();
				
			var newParticle:TextParticle = tempGame.mainEmitter.AddTextObject(tempString, x, y, 0, -2);
			newParticle.color = 0xEE8800;

			score += s;

			if (Math.floor(score / 5000) > Math.floor((score - s)/5000))
				FP.world.add(new Powerup());
		}
		
		static public function reset():void
		{
			playtime = 0;
			distanceTravelled = 0;
			travellingSpeed = 5;
		
			score = 0;
			visibleScore = 0;
			scoreCountUpSpeed = 25;
			
			lives = 3;
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

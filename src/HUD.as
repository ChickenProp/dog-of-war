package
{
	import flash.geom.Point;
	
	import net.flashpunk.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;

	public class HUD
	{
		[Embed(source = '../content/sprites/live.png')]
					private const LIVE:Class;
		private const lifeIcon:Image = new Image(LIVE);
		
		private var game:Game;
		
		private var distanceText:Text;
		private var scoreText:Text;
		private var hiscoreText:Text;
		
		public function HUD(myGame:Game)
		{
			game = myGame;
			
			scoreText = new Text("temp", 30, 50);
			hiscoreText = new Text("hisc", 30, 30);
			distanceText = new Text("dist", 30, 480 - 80);
			
			scoreText.color = 0x005522;
			hiscoreText.color = 0x005522;
			distanceText.color = 0x005522;
			
		}
		
		public function update():void
		{
			scoreText.text = "SCORE: " + GameManager.visibleScore.toString();
			hiscoreText.text = "HIGH SCORE: " + Data.readInt("highscore");
			distanceText.text = "DISTANCE: " +GameManager.distanceTravelled.toString() + "m";
			
			//FP.log("herpa derp derp");
		}
		
		public function render () : void {
			for (var x:int = 0; x < GameManager.lives; x++)
			{
				lifeIcon.render(FP.buffer, new Point( 10 + 45 * x, 480 - 10 - 45), FP.camera);
			}
			
			scoreText.render(FP.buffer, new Point(), FP.camera);
			hiscoreText.render(FP.buffer, new Point(), FP.camera);
			distanceText.render(FP.buffer, new Point(), FP.camera);
			
		}
	}
}

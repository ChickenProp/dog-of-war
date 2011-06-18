package
{
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class HUD
	{
		[Embed(source = '../content/sprites/live.png')]
					private const LIVE:Class;
		private const lifeIcon:Image = new Image(LIVE);
		
		private var game:Game;
		
		
		public function HUD(myGame:Game)
		{
			game = myGame;
		}
		
		public function update():void{
			
		}
		
		public function render () : void {
			for (var x:int = 0; x < GameManager.lives; x++)
			{
				lifeIcon.render(FP.buffer, new Point( 10 + 45 * x, 480 - 10 - 45), FP.camera);
			}
			
		}
	}
}
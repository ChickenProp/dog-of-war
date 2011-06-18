package {
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.debug.*;
import flash.events.*;

[SWF(width = "640", height = "480")]

public class Dog extends Engine 
{	
	public static var focused:Boolean = false;
	
	public function Dog() 
	{
		super(640, 480, 60, false);
		Data.load("dog-of-war-data");
		FP.console.enable();
		FP.console.toggleKey = Key.ENTER;
	}

	override public function init():void 
	{
		FP.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseClick);
		FP.world = new Game;
	}
	
	private function mouseClick(e:Event):void
	{
		FP.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseClick);
		FP.stage.addEventListener(Event.ACTIVATE, focusGain);
		FP.stage.addEventListener(Event.DEACTIVATE, fLost);
		focusGain();
	}

	private function focusGain(e:Event = null):void
	{
		focused = true;
	}

	private function fLost(e:Event = null):void
	{
		focused = false;
		Game.pause = true;
	}

}
}

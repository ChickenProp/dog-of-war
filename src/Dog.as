package {
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.debug.*;

[SWF(width = "640", height = "480")]

public class Dog extends Engine {
        public function Dog() {
                super(640, 480, 60, false);
                Data.load("dog-of-war-data");
		FP.screen.color = 0xE0FFFF;
		FP.console.enable();
		FP.console.toggleKey = Key.ENTER;
        }

	override public function init():void {
		FP.world = new Game;
	}
}
}

package {
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.debug.*;

public class Dog extends Engine {
        public function Dog() {
                super(640, 480, 60, false);
                Data.load("dog-of-war-data");
        }

        override public function init():void {
                FP.world = new Game;
        }

}
}

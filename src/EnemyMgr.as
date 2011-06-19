package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class EnemyMgr {
	public var enemyTypes:Vector.<Class> = new Vector.<Class>();

	public function EnemyMgr() {
		enemyTypes.push(BasicEnemy);
		enemyTypes.push(BouncingEnemy);
		enemyTypes.push(StrongEnemy);
	}

	public function update () : void {
		var n:int = FP.world.typeCount("enemy");
		for (; n < 20; n++) {
			var type:Class = enemyTypes[FP.rand(3)];
			FP.world.add(new type());
		}
	}
}
}

package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class EnemyMgr {
	public var enemyTypes:Vector.<Class> = new Vector.<Class>();
	public var delay:int = 10;
	public var timeout:int = 0;

	public function EnemyMgr() {
		enemyTypes.push(BasicEnemy);
		enemyTypes.push(BouncingEnemy);
		enemyTypes.push(StrongEnemy);
		enemyTypes.push(SkullEnemy);
	}

	public function update () : void {
		var n:int = FP.world.typeCount("enemy");
		if (n < targetEnemies() && canAddEnemy())
			addEnemy();

		timeout--;
	}

	public function targetEnemies () : int {
		return 20;
	}

	public function canAddEnemy () : Boolean {
		return timeout <= 0;
	}

	// Weighted towards the enemies which appear first in the array.
	public function addEnemy () : void {
		var len:int = enemyTypes.length;
		var t:int = Math.floor(Math.sqrt(FP.rand(len*len)));
		var type:Class = enemyTypes[len - t - 1];
		FP.world.add(new type());
		timeout = delay;
	}
}
}

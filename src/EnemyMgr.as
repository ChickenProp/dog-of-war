package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class EnemyMgr {
	public var enemyTypes:Vector.<Class> = new Vector.<Class>();
	public var delayM:int = 10;
	public var delayE:int = 30;
	public var timeoutM:int = 0;
	public var timeoutE:int = 0;

	public function EnemyMgr() {
		//enemyTypes.push(Mine);
		//enemyTypes.push(BouncingEnemy);
		enemyTypes.push(StrongEnemy);
		enemyTypes.push(SkullEnemy);
	}

	public function update () : void {
		if (subclassCount(BasicEnemy) < targetEnemies() && canAddEnemy())
			addEnemy();

		if (subclassCount(Mine) < targetMines() && canAddMine())
			addMine();

		timeoutM--;
		timeoutE--;
	}

	// FP.world.classCount doesn't get subclasses.
	public function subclassCount (c:Class) : int {
		var a:Array = [];
		FP.world.getClass(c, a);
		return a.length;
	}

	public function targetEnemies () : int {
		return difficulty();
	}

	public function targetMines () : int {
		return difficulty() * 2;
	}

	public function canAddEnemy () : Boolean {
		return timeoutE <= 0;
	}

	public function canAddMine () : Boolean {
		return timeoutM <= 0;
	}

	public function difficulty () : int {
		return 2 + Math.floor(GameManager.distanceTravelled / 3000
		                      + GameManager.score / 1000);
	}

	// Weighted towards the enemies which appear first in the array.
	public function addEnemy () : void {
		var len:int = enemyTypes.length;
		var t:int = Math.floor(Math.sqrt(FP.rand(len*len)));
		var type:Class = enemyTypes[len - t - 1];
		FP.world.add(new type());
		timeoutE = delayE;
	}

	public function addMine () : void {
		if (FP.random <= 0.5)
		        FP.world.add(new Mine);
		else
			FP.world.add(new BouncingEnemy);

		timeoutM = delayM;
	}
}
}

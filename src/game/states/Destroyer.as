package game.states
{
	import core.GameManager;
	
	import game.Level;

	public class Destroyer	{
		private var level:Level;
		private var gameManager:GameManager;
		
		public function Destroyer(level:Level)	{
			this.level = level;
			this.gameManager = GameManager.getInstance();
		}
		
		public function destroy():Boolean {
			if (level.destroyPull.length > 0) {
				for (var key:String in level.destroyPull) {
					level.destroyPull[key].chip.destroy(level.destroyPull[key]);
				}
				return true;
			}
			return false
		}
	}
}
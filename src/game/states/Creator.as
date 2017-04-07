package game.states
{
	import com.greensock.TweenLite;
	
	import core.Constants;
	import core.GameManager;
	
	import game.Chip;
	import game.Level;
	
	import starling.display.Image;

	public class Creator	{
		private var level:Level;
		private var gameManager:GameManager;
		
		public function Creator(level:Level)	{
			this.level = level;
			this.gameManager = GameManager.getInstance();			
		}
		
		public function drawLevel():void {
			for (var i:int = 0; i < Constants.MAX_LEVEL_SIZE_X; i++) {
				for (var j:int = 0; j<Constants.MAX_LEVEL_SIZE_Y; j++) {
					if (Helpers.empty(level.cells[i][j])) continue;
					level.cells[i][j].x = Constants.LEVEL_OFFSET_X + (level.cells[i][j].width * i);
					level.cells[i][j].y = Constants.LEVEL_OFFSET_Y + (level.cells[i][j].height * j);
					level.add_cell(level.cells[i][j]);
					
					if (level.cells[i][j].emitter) {
						var emitterImage:Image = new Image(GameManager.getInstance().getAssets().getTexture("emitter"));
						emitterImage.x = level.cells[i][j].x + (level.cells[i][j].width - emitterImage.width) / 2;
						emitterImage.y = level.cells[i][j].y;
						level.add_emitter(emitterImage);
					}					
				}
			}						
		}
		
		public function generateStartChips():void {
			for (var i:int = 0; i < Constants.MAX_LEVEL_SIZE_X; i++) {
				for (var j:int = 0; j<Constants.MAX_LEVEL_SIZE_Y; j++) {
					if (Helpers.empty(level.cells[i][j]) || !Helpers.empty(level.cells[i][j].box)) continue;
					do {
						var id:int = Math.ceil(Math.random() * level.config.chipsConfig.length-1);
						var c:Chip = new Chip(level.config.chipsConfig[id]);
						level.cells[i][j].chip = c;						
					} while (!Helpers.empty(level.matcher.checkTripleAtPoint(i,j, false)));						
					level.cells[i][j].chip.x = level.cells[i][j].x + (level.cells[i][j].width - level.cells[i][j].chip.width) / 2;
					level.cells[i][j].chip.y = level.cells[i][j].y + (level.cells[i][j].height - level.cells[i][j].chip.height) / 2;
					level.add_chip(level.cells[i][j].chip);					
				}
			}
		}		
		
		public function checkEmitter(): Boolean {
			var wasEmitter:Boolean = false;
			for (var i:int = 0; i < Constants.MAX_LEVEL_SIZE_X; i++) {
				for (var j:int = 0; j<Constants.MAX_LEVEL_SIZE_Y; j++) {
					if (Helpers.empty(level.cells[i][j])) continue;
					if (Helpers.empty(level.cells[i][j].chip) && level.cells[i][j].emitter) {
						var id:int = Math.ceil(Math.random() * level.config.chipsConfig.length-1);
						var c:Chip = new Chip(level.config.chipsConfig[id]);
						level.cells[i][j].chip = c;	
						level.cells[i][j].chip.alpha = 0.5;
						level.cells[i][j].chip.x = level.cells[i][j].x + (level.cells[i][j].width - level.cells[i][j].chip.width) / 2;
						level.cells[i][j].chip.y = level.cells[i][j].y + ((level.cells[i][j].height - level.cells[i][j].chip.height) / 2) - level.cells[i][j].height;						
						level.add_chip(level.cells[i][j].chip);
						var newY:int = level.cells[i][j].y + ((level.cells[i][j].height - level.cells[i][j].chip.height) / 2);					
						TweenLite.to(level.cells[i][j].chip, Constants.ANIM_TIME_SWAP, {alpha:1, y: newY});		
						wasEmitter = true;
					}
				}
			}
			return wasEmitter;
			
		}
	}
}
package game.states
{
	import core.Constants;
	import core.GameManager;
	
	import game.Cell;
	import game.Chip;
	import game.Level;
	
	import starling.display.Sprite;

	public class Swapper extends Sprite{
		private var level:Level;
		private var gameManager:GameManager;
		
		public function Swapper(level:Level) {
			this.level = level;
			this.gameManager = GameManager.getInstance();			
		}
						
		public function swap(cell1:Cell, cell2:Cell, step = 1):void {				
			if (!Helpers.empty(cell1.chip)) {
				gameManager.currentLevel.swapblePull.push(cell1.chip);
				cell1.chip.goToCell(cell2, step);
			}
			if (!Helpers.empty(cell2.chip)) {
				gameManager.currentLevel.swapblePull.push(cell2.chip);
				cell2.chip.goToCell(cell1, step);
			}
			
			var tmpChip:Chip = cell2.chip;					
			cell2.chip = cell1.chip;
			cell1.chip = tmpChip;																
		}
		
		public function checkSwap():Boolean {
			if (!Helpers.empty(level.currentCell1) && !Helpers.empty(level.currentCell2)) {
				var m1:Boolean = level.matcher.checkTripleAtPoint(level.currentCell1.coord_x, level.currentCell1.coord_y);
				var m2:Boolean = level.matcher.checkTripleAtPoint(level.currentCell2.coord_x, level.currentCell2.coord_y);
				if (!m1 && !m2) {
					return false;									
				} 
			} 	
			return true;
		}				
				
		public function gravity(delta:int = 0):Boolean {			
			var wasGravity:Boolean = false;
			for (var j:int = Constants.MAX_LEVEL_SIZE_Y-1; j >= 0; --j) {
				for (var i:int = 0; i<Constants.MAX_LEVEL_SIZE_X; i++) {
					if (checkChipGoDown(level.cells[i][j], delta)) {
						wasGravity = true;
					}
				}
			}	
			return wasGravity;
		}	
		
		public function checkChipGoDown(cell:Cell, delta:int = 0):Boolean {
			if (Helpers.empty(cell) || Helpers.empty(cell.chip)) return false;
			var goToCell:Cell = null;	
			if (cell.coord_x == 8 && cell.coord_y == 7) {
				trace("stop");
			}
			trace(cell.coord_x+":"+cell.coord_y);
			if (cell.coord_x + delta < 0 || cell.coord_x + delta >= Constants.MAX_LEVEL_SIZE_X) return false
			var coord_x:int = cell.coord_x + delta;
			for (var i:int=cell.coord_y; i<Constants.MAX_LEVEL_SIZE_Y; i++) {
				if (!Helpers.empty(level.cells[coord_x][i + 1]) && Helpers.empty(level.cells[coord_x][i + 1].chip) && Helpers.empty(level.cells[coord_x][i + 1].box)) {
					goToCell = level.cells[coord_x][i + 1];
				} else {				
					break;											
				}
			}
			
			if (!Helpers.empty(goToCell)) {
				trace(cell.coord_x+":"+cell.coord_y+" => "+goToCell.coord_x+":"+goToCell.coord_y);
				swap(cell, goToCell, goToCell.coord_y - cell.coord_y); 
				return true;
			}			
			return false
		}	
		
	}
}
package game.states
{
	import core.Constants;
	import core.GameManager;
	
	import game.Cell;
	import game.Level;

	public class Matcher {
		private var level:Level;
		private var gameManager:GameManager;
		
		public function Matcher(level:Level) {
			this.level = level;
			this.gameManager = GameManager.getInstance();
		}				
		
		public function checkDestroy():Boolean {
			var wasDestroy:Boolean = false;
			for (var i:int = 0; i < Constants.MAX_LEVEL_SIZE_X; i++) {
				for (var j:int = 0; j<Constants.MAX_LEVEL_SIZE_Y; j++) {
					if (Helpers.empty(level.cells[i][j])) continue;
					if (!Helpers.empty(level.cells[i][j].chip)) {
						if (level.matcher.checkTripleAtPoint(level.cells[i][j].coord_x, level.cells[i][j].coord_y)) {
							wasDestroy = true;
							
						}
					}					
				}
			}			
			for (var key:String in level.destroyPull) {
				//trace("need destroy "+level.destroyPull[key].coord_x+":"+level.destroyPull[key].coord_y);
				level.destroyPull[key].chip.destroy(level.destroyPull[key]);
				if (level.destroyPull[key].sand != null) {
					level.destroyPull[key].sand.remove();
					level.destroyPull[key].sand = null;
					GameManager.getInstance().currentLevel.killSandCount++;
				}
				var boxes:Vector.<Cell> = checkBoxesAround(level.destroyPull[key]);
				for (var b:String in boxes) {
					boxes[b].box.remove();
					boxes[b].box = null;
					GameManager.getInstance().currentLevel.killBoxesCount++;
				}
			}
			
			return wasDestroy;
		}
		
		private function checkBoxesAround(cell):Vector.<Cell> {
			var res:Vector.<Cell> = new Vector.<Cell>();
			if ((cell.coord_y - 1 >= 0) && !Helpers.empty(level.cells[cell.coord_x][cell.coord_y - 1]) && level.cells[cell.coord_x][cell.coord_y - 1].box != null) {
				res.push(level.cells[cell.coord_x][cell.coord_y - 1]);				
			}
//			if ((cell.coord_x + 1 < Constants.MAX_LEVEL_SIZE_X) && (cell.coord_y - 1 >= 0) && !Helpers.empty(level.cells[cell.coord_x + 1][cell.coord_y - 1]) && level.cells[cell.coord_x + 1][cell.coord_y - 1].box != null) {
//				res.push(level.cells[cell.coord_x + 1][cell.coord_y - 1]);				
//			}
			if ((cell.coord_x + 1 < Constants.MAX_LEVEL_SIZE_X) && !Helpers.empty(level.cells[cell.coord_x + 1][cell.coord_y]) && level.cells[cell.coord_x + 1][cell.coord_y].box != null) {
				res.push(level.cells[cell.coord_x + 1][cell.coord_y]);				
			}
//			if ((cell.coord_x + 1 < Constants.MAX_LEVEL_SIZE_X) && (cell.coord_y + 1 < Constants.MAX_LEVEL_SIZE_Y) && !Helpers.empty(level.cells[cell.coord_x + 1][cell.coord_y + 1]) && level.cells[cell.coord_x + 1][cell.coord_y + 1].box != null) {
//				res.push(level.cells[cell.coord_x + 1][cell.coord_y + 1]);				
//			}
			if ((cell.coord_y + 1 < Constants.MAX_LEVEL_SIZE_Y) && !Helpers.empty(level.cells[cell.coord_x][cell.coord_y + 1]) && level.cells[cell.coord_x][cell.coord_y + 1].box != null) {
				res.push(level.cells[cell.coord_x][cell.coord_y + 1]);				
			}
//			if ((cell.coord_x - 1 >= 0) && (cell.coord_y + 1 < Constants.MAX_LEVEL_SIZE_Y) && !Helpers.empty(level.cells[cell.coord_x - 1][cell.coord_y + 1]) && level.cells[cell.coord_x - 1][cell.coord_y + 1].box != null) {
//				res.push(level.cells[cell.coord_x - 1][cell.coord_y + 1]);				
//			}
			if ((cell.coord_x - 1 >= 0) && !Helpers.empty(level.cells[cell.coord_x - 1][cell.coord_y]) && level.cells[cell.coord_x - 1][cell.coord_y].box != null) {
				res.push(level.cells[cell.coord_x - 1][cell.coord_y]);				
			}
//			if ((cell.coord_x - 1 >= 0) && (cell.coord_y - 1 >= 0) && !Helpers.empty(level.cells[cell.coord_x - 1][cell.coord_y - 1]) && level.cells[cell.coord_x - 1][cell.coord_y - 1].box != null) {
//				res.push(level.cells[cell.coord_x - 1][cell.coord_y - 1]);				
//			}
			return res;
		}
		
		public function checkTripleAtPoint(x:int, y:int, addToPull:Boolean = true):Boolean {
			if (Helpers.empty(level.cells[x][y]) || Helpers.empty(level.cells[x][y].chip)) return false;
			var start:int = x - 4 > 0 ? x - 4 : 0;
			var finish:int = x + 4 > Constants.MAX_LEVEL_SIZE_X ? Constants.MAX_LEVEL_SIZE_X : x + 4; 			
			var chipId:int = level.cells[x][y].chip.id;
			var cellsToBoomHorizontal:Vector.<Cell> = new Vector.<Cell>;
			for (var i:int = start; i < finish; i++) {
				if (Helpers.empty(level.cells[i][y]) || Helpers.empty(level.cells[i][y].chip) || level.cells[i][y].chip.id != chipId || !Helpers.empty(level.cells[i][y].box)) {
					if (cellsToBoomHorizontal.length < 3) {
						cellsToBoomHorizontal.splice(0, cellsToBoomHorizontal.length);
					} else {
						break;
					}
				} else {
					//if (cellsToBoomHorizontal.indexOf(level.cells[x][j]) == -1) {
						cellsToBoomHorizontal.push(level.cells[i][y]);
					//} 
				}
			}
			
			start = y - 4 > 0 ? y - 4 : 0;
			finish = y + 4 > Constants.MAX_LEVEL_SIZE_Y ? Constants.MAX_LEVEL_SIZE_Y : y + 4; 			
			var cellsToBoomVertical:Vector.<Cell> = new Vector.<Cell>;
			for (var j:int = start; j < finish; j++) {
				if (Helpers.empty(level.cells[x][j]) || Helpers.empty(level.cells[x][j].chip) || level.cells[x][j].chip.id != chipId || !Helpers.empty(level.cells[x][j].box)) {
					if (cellsToBoomVertical.length < 3) {
						cellsToBoomVertical.splice(0, cellsToBoomVertical.length);
					} else {
						break;
					}
				} else {
					//if (cellsToBoomVertical.indexOf(level.cells[x][j]) == -1) {
						cellsToBoomVertical.push(level.cells[x][j]);
					//} 
				}
			}
			var res:Boolean = false;
			
			if (cellsToBoomHorizontal.length >= 3) {
				if (addToPull) {
					for (var h:String in cellsToBoomHorizontal) {
						if (level.destroyPull.indexOf(cellsToBoomHorizontal[h]) == -1) {
							level.destroyPull.push(cellsToBoomHorizontal[h]);
						}
					}
				}
				res = true;
			}
			if (cellsToBoomVertical.length >= 3) {
				if (addToPull) {
					for (var v:String in cellsToBoomVertical) {
						if (level.destroyPull.indexOf(cellsToBoomVertical[v]) == -1) {
							level.destroyPull.push(cellsToBoomVertical[v]);
						}
					}
				}
				res = true;
			}			

			cellsToBoomVertical.splice(0, cellsToBoomVertical.length);
			cellsToBoomHorizontal.splice(0, cellsToBoomHorizontal.length);
			return res;									
		}
	}
}
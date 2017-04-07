package game
{
	import configuration.CellConfiguration;
	
	import core.Constants;
	import core.GameManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class Cell extends Sprite {		
		public var coord_x:int;
		public var coord_y:int;
		
		public var texture:Texture = GameManager.getInstance().getAssets().getTexture("cell");
		
		public var emitter:Boolean;		
		
		public var chip:Chip = null;		
		public var sand:Sand = null;
		public var box:Box = null;
		
		public function Cell(data:CellConfiguration, level:Level) {
			coord_x = data.x;
			coord_y = data.y;
			
			addChild(new Image(this.texture));
			
			emitter = data.hasEmitter;					 								
			
			if (data.hasSand) {
				sand = new Sand();
				sand.x = Constants.LEVEL_OFFSET_X + (sand.width /2) + (this.width * coord_x) + (this.width - sand.width) / 2;
				sand.y = Constants.LEVEL_OFFSET_Y + (sand.height /2) + (this.height * coord_y) + (this.height - sand.height) / 2;
				level.add_sand(sand);
			}
			
			if (data.hasBox) {
				box = new Box();
				box.x = Constants.LEVEL_OFFSET_X + (box.width /2) + (this.width * coord_x) + (this.width - box.width) / 2;
				box.y = Constants.LEVEL_OFFSET_Y + (box.height /2) + (this.height * coord_y) + (this.height - box.height) / 2;
				level.add_box(box);
			}
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void {
			if (GameManager.getInstance().currentLevel.state != Constants.STATE_WAIT) return;
			var touch:Touch = e.getTouch(e.currentTarget as Sprite, TouchPhase.BEGAN);
			var touchEnd:Touch = e.getTouch(e.currentTarget as Sprite, TouchPhase.ENDED);
			var touchHover:Touch = e.getTouch(e.currentTarget as Sprite, TouchPhase.HOVER);			
			if (touchEnd) {
				if (!Helpers.empty(this.chip)) {
					if (!Helpers.empty(GameManager.getInstance().currentLevel.currentCell1)) {
						if (isNeighbors(GameManager.getInstance().currentLevel.currentCell1)) {
							GameManager.getInstance().currentLevel.currentCell2 = this;
							//GameManager.getInstance().currentLevel.swapper.swap(GameManager.getInstance().currentCell1, GameManager.getInstance().currentCell2);
							GameManager.getInstance().currentLevel.swapper.swap(GameManager.getInstance().currentLevel.currentCell1, GameManager.getInstance().currentLevel.currentCell2);
						} else {
							GameManager.getInstance().currentLevel.currentCell1.chip.jumpAnimStop();
							GameManager.getInstance().currentLevel.currentCell1 = null;
						}						
					} else {
						GameManager.getInstance().currentLevel.currentCell1 = this;
						GameManager.getInstance().currentLevel.currentCell1.chip.jumpAnim();
					}
				} else {
					
				}
			}
			if (touchHover) {
				if (this.chip != null) {
					GameManager.getInstance().userHightLabel.text = this.chip.id.toString();
				} else {
					GameManager.getInstance().userHightLabel.text = "emprty";
				}
			}
		}
		
		private function isNeighbors(cell:Cell):Boolean {
			if (this.coord_x - 1 == cell.coord_x && this.coord_y == cell.coord_y) return true;
			if (this.coord_x + 1 == cell.coord_x && this.coord_y == cell.coord_y) return true;
			if (this.coord_y - 1 == cell.coord_y && this.coord_x == cell.coord_x) return true;
			if (this.coord_y + 1 == cell.coord_y && this.coord_x == cell.coord_x) return true;
			return false;
		}
	}
}
package game
{
	import configuration.CellConfiguration;
	import configuration.LevelConfiguration;
	
	import core.Constants;
	import core.GameManager;
	
	import game.states.Creator;
	import game.states.Destroyer;
	import game.states.Matcher;
	import game.states.Swapper;
	
	import starling.display.Image;
	import starling.display.Sprite;

	public class Level extends Sprite{
		public var config:LevelConfiguration;
		
		public var cells:Array = [];
				
		public var killSandCount	:int = 0;
		public var killBoxesCount	:int = 0;
		
		public var swapblePull:Vector.<Chip> = new Vector.<Chip>();
		public var destroyPull:Vector.<Cell> = new Vector.<Cell>();
		
		private var chipLayer:Sprite 	= new Sprite();
		private var cellsLayer:Sprite 	= new Sprite();
		private var sandLayer:Sprite	= new Sprite();
		private var emitterLayer:Sprite = new Sprite();
		private var boxesLayer:Sprite	= new Sprite();
		private var scoresLayer:Sprite	= new Sprite();
		
		public var creator	:Creator;
		public var matcher	:Matcher;
		public var swapper	:Swapper;
		public var destroyer:Destroyer;
		
		public var currentCell1:Cell = null;
		public var currentCell2:Cell = null;
		
		public var state:int = Constants.STATE_WAIT;
		
		public function Level(data:LevelConfiguration) {
			addChild(cellsLayer);
			addChild(sandLayer);
			addChild(chipLayer);
			addChild(boxesLayer);
			addChild(emitterLayer);
			addChild(scoresLayer);
			
			creator = new Creator(this);
			matcher = new Matcher(this);
			swapper = new Swapper(this);
			destroyer = new Destroyer(this);
			
			config = data;
			for (var key:int in config.cellsConfig) {
				var cc:CellConfiguration = config.cellsConfig[key];
				if (Helpers.empty(cells[cc.x])) {
					cells[cc.x] = [];
				}
				cells[cc.x][cc.y] = new Cell(cc, this);
			}													
		}
		
		public function start():void {
			creator.drawLevel();	
			creator.generateStartChips();			
		}
		
		public function check_state():void {
			state = Constants.STATE_MATHCER;
			if (!swapper.checkSwap()) {
				swapper.swap(currentCell1, currentCell2);
				destroyPull.length = 0;
				currentCell1 = null;
				currentCell2 = null;
				state = Constants.STATE_WAIT;
				return;
			} else {
				destroyPull.length = 0;
				currentCell1 = null;
				currentCell2 = null;
			}
						
			if (swapper.gravity()) {trace("gravity"); return;}			
			if (creator.checkEmitter()){check_state(); trace("emitter"); return;}
			if (matcher.checkDestroy()) {trace("destroy"); return;} 			
			if (swapper.gravity(1)) {trace("gravity + 1"); return;}
			if (swapper.gravity(-1)) {trace("gravity - 1"); return;}
			
			state = Constants.STATE_WAIT;
		}							
		
		public function add_chip(chip:Chip):void {
			this.chipLayer.addChild(chip);	
		}
		
		public function add_cell(cell:Cell):void {
			this.cellsLayer.addChild(cell);
		}
		
		public function add_emitter(emitter:Image):void {
			this.emitterLayer.addChild(emitter);
		}		
		
		public function add_sand(sand:Sand):void {
			this.sandLayer.addChild(sand);
		}
		
		public function add_box(box:Box):void {
			this.boxesLayer.addChild(box);
		}
	}
}

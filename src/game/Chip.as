package game
{
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.geom.Point;
	
	import configuration.ChipConfiguration;
	
	import core.Constants;
	import core.GameManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class Chip extends Sprite {
		public var id:int;
		public var texture:Texture;
		public var score:int;
		
		// =============================
		private var jump:TweenMax = null;
		
		public function Chip(data:ChipConfiguration) {
			
			id = data.id;
			score = data.score;		
			texture = GameManager.getInstance().getAssets().getTexture(data.name);		
			this.touchable = false;
			addChild(new Image(texture));
		}
		
		public function destroy(cell:Cell):void {			
			TweenLite.to(this, Constants.ANIM_TIME_BOOM, {alpha:0, onComplete: function():void {afterDestroy(cell)}});
		}		
		
		private function afterDestroy(cell:Cell):void {
			GameManager.getInstance().currentLevel.destroyPull.splice(GameManager.getInstance().currentLevel.destroyPull.indexOf(cell), 1);
			dispose();
			cell.chip = null;
			GameManager.getInstance().userScoresLabel.text = GameManager.getInstance().currentLevel.destroyPull.length.toString(); 
			if (GameManager.getInstance().currentLevel.destroyPull.length == 0) {
				GameManager.getInstance().currentLevel.check_state();
			}
		}
		
		public function goToCell(cell:Cell, step = 1):void {
			var newX:int = cell.x + (cell.width - this.width) / 2;
			var newY:int = cell.y + (cell.height - this.height) / 2;
			
			TweenLite.to(this, Constants.ANIM_TIME_SWAP * step, {x: newX, y: newY, onComplete: afterGoToCell});			
		}
		
		private function afterGoToCell():void {
			GameManager.getInstance().currentLevel.swapblePull.splice(GameManager.getInstance().currentLevel.swapblePull.indexOf(this), 1);
			GameManager.getInstance().userLevelLabel.text = GameManager.getInstance().currentLevel.swapblePull.length.toString(); 
			if (GameManager.getInstance().currentLevel.swapblePull.length == 0) {
				GameManager.getInstance().currentLevel.check_state();
			}
		}
		
		public function jumpAnim():void {
			var points0:Array = [];
			points0.push(new Point(x,y - 5));
			points0.push(new Point(x,y));
			jump = TweenMax.to(this, 0.3, { bezier:{
				values:points0,
				type:"soft"
			}, ease:Linear.easeNone, repeat:-1, onComplete:function():void {jump = null;}});	
		}		
		
		public function jumpAnimStop():void {
			jump.repeat(0);	
		}
		
		private function onTouch(e:TouchEvent):void {
			var touch:Touch = e.getTouch(e.currentTarget as Sprite, TouchPhase.BEGAN);
			var touchEnd:Touch = e.getTouch(e.currentTarget as Sprite, TouchPhase.ENDED);
			var touchHover:Touch = e.getTouch(e.currentTarget as Sprite, TouchPhase.HOVER);
			if (touchHover) {
				
			} else {
			
			}
			if (touchEnd) {
			}
		}
	}
}
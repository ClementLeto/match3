package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import core.Constants;
	
	import starling.core.Starling;
	
	[SWF(width="640", height="640", frameRate="60", backgroundColor="#DDDDDD")]
	
	public class Main extends Sprite {
		
		public function Main()  {
			this.addEventListener(Event.ADDED_TO_STAGE, init);		
		}
		
		public function init(e:Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			var viewPortRectangle:Rectangle= new Rectangle();
			//stage.stageWidth
			viewPortRectangle.width =  Constants.STAGE_WIDTH;
			viewPortRectangle.height = Constants.STAGE_HEIGHT;
			
			var starling:Starling = new Starling(Game, this.stage, viewPortRectangle, null, "auto", "auto");
			starling.start();
		}
	}
}
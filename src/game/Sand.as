package game
{
	import com.greensock.TweenLite;
	
	import core.GameManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.deg2rad;

	public class Sand extends Sprite
	{
		public var texture:Texture = GameManager.getInstance().getAssets().getTexture("sand");
		
		public function Sand() {			
			addChild(new Image(texture));
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
			this.touchable = false;
		}
		
		public function remove():void {
			
			TweenLite.to(this, 0.3, { alpha:0, rotation:360, onComplete: function d():void{ dispose() }});
		}	
		
	}
}
package game
{
	import com.greensock.TweenLite;
	
	import core.GameManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Box extends Sprite
	{
		public var texture:Texture = GameManager.getInstance().getAssets().getTexture("box");
		
		public function Box() {
			addChild(new Image(texture));
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
			this.touchable = false;
		}
		
		public function remove():void {
			TweenLite.to(this, 0.15, { alpha:0, scale:1.5, onComplete: function d():void{ dispose() }});
		}
	}
}
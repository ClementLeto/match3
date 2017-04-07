package configuration
{
	public class CellConfiguration
	{
		public var x:int = 0;
		public var y:int = 0;
		
		public var hasSand:Boolean = false;
		public var hasBox:Boolean = false;
		public var hasEmitter:Boolean = false;
		
		public var chipId:int = 0;
		
		public function CellConfiguration(data:XML)	{
			this.x = data.@x;
			this.y = data.@y;
			
			if (data.hasOwnProperty("@sand")) {
				this.hasSand = data.@sand;
			}
			
			if (data.hasOwnProperty("@box")) {
				this.hasBox = data.@box;
			}
			
			if (data.hasOwnProperty("@emitter")) {
				this.hasEmitter = data.@emitter;
			}
			
			if (data.hasOwnProperty("@chip_id")) {
				this.chipId = data.@chip_id;
			}
		}
	}
}
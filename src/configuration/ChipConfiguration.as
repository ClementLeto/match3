package configuration
{
	public class ChipConfiguration
	{
		public var id:int = 0;
		public var name:String;
		public var score:int = 0;
		
		public function ChipConfiguration(data:XML)	{
			if (data.hasOwnProperty("@id")) {
				id = data.@id;	
			}
			if (data.hasOwnProperty("@name")) {
				name = data.@name;	
			}
			if (data.hasOwnProperty("@score")) {
				score = data.@score;
			}
		}
	}
}
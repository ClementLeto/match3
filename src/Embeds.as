package
{	
	public class Embeds
	{
		public function Embeds()
		{
		}
		//Map
		[Embed (source="../res/graphics/background.jpg" )]
		public static const Background:Class;		

		[Embed (source="../res/graphics/box.png" )]
		public static const Box:Class;
	
		[Embed (source="../res/graphics/cell.png" )]
		public static const Cell:Class;
		
		[Embed (source="../res/graphics/emitter.png" )]
		public static const Emitter:Class;
		
		[Embed (source="../res/graphics/sand.png" )]
		public static const Sand:Class;
		
		// Chips
		[Embed (source="../res/graphics/chip_1.png" )]
		public static const Chip1:Class;
		
		[Embed (source="../res/graphics/chip_2.png" )]
		public static const Chip2:Class;
		
		[Embed (source="../res/graphics/chip_3.png" )]
		public static const Chip3:Class;
	
		[Embed (source="../res/graphics/chip_4.png" )]
		public static const Chip4:Class;
		
		[Embed (source="../res/graphics/chip_5.png" )]
		public static const Chip5:Class;
		
		[Embed (source="../res/levels/levels_list.xml", mimeType="application/octet-stream" )]
		public static const LevelsList:Class;
	}
}
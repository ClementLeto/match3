package configuration
{
	import configuration.CellConfiguration;

	public class LevelConfiguration {
		public var id:int;
		public var name:String;
		
		public var cellsConfig:Vector.<CellConfiguration> = new Vector.<CellConfiguration>;	
		public var chipsConfig:Vector.<ChipConfiguration> = new Vector.<ChipConfiguration>;
		public var killSandCount:int = 0;
		public var killBoxesCount:int = 0;
		
		//XML можно создавать в каком-нибудь редакторе уровней, чтобы не заполнять ручками
		public function LevelConfiguration(params:XML) {
			if (params.hasOwnProperty("@id")) {
				id = params.@id;
			}
			
			if (params.hasOwnProperty("@name")) {
				name = params.@name;
			}
			
			if (params.hasOwnProperty("conditions")) {
				if (params.conditions.hasOwnProperty("kill_sand")) {
					// Не будем доходит до паранойи и проверять все подряд. Если написать конвертор XML в Object можно сделать хороший загрузчик					
					killSandCount = params.conditions.kill_sand.@count;
				}
				if (params.conditions.hasOwnProperty("kill_box")) {
					killBoxesCount = params.conditions.kill_box.@count;
				}
			}
			
			if (params.hasOwnProperty("cells")) {
				for (var i:int = 0; i < params.cells.cell.length(); i++) {
					cellsConfig.push(new CellConfiguration(params.cells.cell[i]));					
				}
			}
			
			if (params.hasOwnProperty("chips")) {
				for (var j:int = 0; j < params.chips.chip.length(); j++) {
					chipsConfig.push(new ChipConfiguration(params.chips.chip[j]));
				}
			}
		}
		
	}
}

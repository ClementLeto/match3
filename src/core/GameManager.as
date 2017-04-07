package core
{
	import flash.display.Bitmap;
	
	import configuration.LevelConfiguration;
	
	import game.Cell;
	import game.Level;
	
	import net.Request;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class GameManager extends Sprite{
		
		private static var _instance:GameManager;
				
		private static var levelsNames:Array = [];				
		private static var loadLevelCount:int = 0;
		
		public var levelsConfigurations:Array = [];
		
		public var currentLevel:Level;		
		
		public var userLevelLabel	:TextField;
		public var userScoresLabel	:TextField;
		public var userHightLabel	:TextField;
		
		public function GameManager() {
			loadResources();
		}
		
		private var assets:AssetManager;
		
		public static function getInstance() : GameManager {
			if (Helpers.empty(_instance)) {
				_instance = new GameManager();
			}
			return _instance;
		}
		
		public function getAssets():AssetManager {
			return assets;
		}
		
		private function loadResources():void {
			
			//TODO: Тут бы Texture packer был бы в тему
			//TODO: Графику грузить с сервера
			
			// Грузим чипсы
			var chip1:Bitmap = new Embeds.Chip1 as Bitmap;
			var chip1_texture:Texture = Texture.fromBitmap(chip1);
			
			var chip2:Bitmap = new Embeds.Chip2 as Bitmap;
			var chip2_texture:Texture = Texture.fromBitmap(chip2);

			var chip3:Bitmap = new Embeds.Chip3 as Bitmap;
			var chip3_texture:Texture = Texture.fromBitmap(chip3);
			
			var chip4:Bitmap = new Embeds.Chip4 as Bitmap;
			var chip4_texture:Texture = Texture.fromBitmap(chip4);
			
			var chip5:Bitmap = new Embeds.Chip5 as Bitmap;
			var chip5_texture:Texture = Texture.fromBitmap(chip5);
			
			// Грузим карту
			
			var background:Bitmap = new Embeds.Background as Bitmap;
			var background_texture:Texture = Texture.fromBitmap(background);
			
			var box:Bitmap = new Embeds.Box as Bitmap;
			var box_texture:Texture = Texture.fromBitmap(box);
			
			var cell:Bitmap = new Embeds.Cell as Bitmap;
			var cell_texture:Texture = Texture.fromBitmap(cell);
			
			var emitter:Bitmap = new Embeds.Emitter as Bitmap;
			var emitter_texture:Texture = Texture.fromBitmap(emitter);
			
			var sand:Bitmap = new Embeds.Sand as Bitmap;
			var sand_texture:Texture = Texture.fromBitmap(sand);
			
			assets = new AssetManager();
			assets.addTexture("chip_1", chip1_texture);
			assets.addTexture("chip_2", chip2_texture);
			assets.addTexture("chip_3", chip3_texture);
			assets.addTexture("chip_4", chip4_texture);
			assets.addTexture("chip_5", chip5_texture);
			
			assets.addTexture("background", background_texture);
			assets.addTexture("box", box_texture);
			assets.addTexture("cell", cell_texture);
			assets.addTexture("emitter", emitter_texture);
			assets.addTexture("sand", sand_texture);	
			
			var levelsNamesXML:XML = XML(new Embeds.LevelsList());
						
			for (var i:int; i < levelsNamesXML.level.length(); i++) {
				if (levelsNamesXML.level[i].@need_load == true) {
					var fileName:String = levelsNamesXML.level[i].@file_name;
					levelsNames.push(fileName);
				}
			}
			
			// Разнообразим код вот такой загрузкой. Это типа с сервера.
			for (var key:String in levelsNames) {
				Request.loadLevel(levelsNames[key], function(response):void {
					if (!Helpers.empty(response)) {
						var levelConfig:LevelConfiguration =  new LevelConfiguration(response);
						levelsConfigurations[levelConfig.id] = levelConfig;
						loadLevelCount++;
					}
					// Тут можно сделать проверку получше
					if (loadLevelCount == levelsNames.length) {
						dispatchEvent(new Event(Constants.LEVELS_LOADED));
					}
				});
			}
			
			
		}
	}
}
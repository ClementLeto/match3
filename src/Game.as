package
{
	
	import configuration.User;
	
	import core.Board;
	import core.Constants;
	import core.GameManager;
	
	import game.Cell;
	import game.Level;
	import game.Sand;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class Game extends Sprite{
		
		public var user:User = new User();		
		
		public var gameManager:GameManager;
					
		
		public var levelNameLabel:TextField;		
		
		public function Game() {
			super();
			
			gameManager = GameManager.getInstance();
			
			// Для всех графических элементов пишется обертка
			var bg:Image = new Image(gameManager.getAssets().getTexture("background")); 
			bg.width = Constants.STAGE_WIDTH;
			bg.width = Constants.STAGE_HEIGHT;
			addChild(bg);								
			
			// Тут нужно применять резиновый текст
			// Все строки нужно выносить в .strings_ru .strings_us файлы для локализации и брать ресурс менеджером в зависимости от локали
			gameManager.userLevelLabel = new TextField(80, 34, "Уровень: "+user.level);
			gameManager.userLevelLabel.x = 20;
			gameManager.userLevelLabel.y = 2;
			addChild(gameManager.userLevelLabel);
			
			gameManager.userScoresLabel = new TextField(150, 34, "Очки: "+user.score);
			gameManager.userScoresLabel.x = 80;
			gameManager.userScoresLabel.y = 2;
			addChild(gameManager.userScoresLabel);
			
			gameManager.userHightLabel = new TextField(200, 34, "Лучший счет: "+user.hightScore);
			gameManager.userHightLabel.x = 230;
			gameManager.userHightLabel.y = 2;
			addChild(gameManager.userHightLabel);	
			
			levelNameLabel = new TextField(100, 34, "");
			levelNameLabel.x = 480;
			levelNameLabel.y = 2;
			addChild(levelNameLabel);			
			
			gameManager.addEventListener(Constants.LEVELS_LOADED, startGame); 	
		}
		
		private function startGame():void {				
			gameManager.currentLevel = new Level(gameManager.levelsConfigurations[user.level]);
			addChild(gameManager.currentLevel);
			gameManager.currentLevel.start();
		}
		
		private function gameOver():void {
			
		}
		
		private function nextLevel():void {
			
		}

	}
				
}
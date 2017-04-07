package net
{	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class Request {
		 	
		private var _callback:Function;
		
		// TODO: После допила этот класс будет использоваться для отправки запросов на сервер. 		 
		
		public function Request(callback:Function) {
			this._callback = callback;
		}
		
		public static function loadLevel(fileName:String, callback:Function):void {
			var link:String = "levels/"+fileName;
			var req:Request = new Request(callback);
			req.addRequest(link);
		}
		
		private function addRequest(link:String):void {
			var urlRequest:URLRequest = new URLRequest(link);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.load(urlRequest);
			urlLoader.addEventListener(Event.COMPLETE, requestCompete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, requestError);			
		}		
		
		private function requestCompete(event:Event):void {
			var XMLResult:XML = new XML(event.currentTarget.data);		
			//var xmlDoc:XMLDocument = new XMLDocument(XMLResult.toString());										
			
			if (!Helpers.empty(this._callback)) {				
				this._callback(XMLResult);
				this._callback = null;
			}
		}
		
		private function requestError(event:Event):void {
			//TODO: need other structure of response
			if (!Helpers.empty(this._callback)) {				
				this._callback = null;
			}
		}
	}
}
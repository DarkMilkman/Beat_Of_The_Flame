package  
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Ryan Sobczak
	 */
	public class ArrowKeyInput 
	{
		/*static var left:Boolean;
		static var right:Boolean;
		static var up:Boolean;
		static var down:Boolean;*/
		static var space:Boolean;
		
		static var value:Boolean;
		
		static public function Init(stage:Stage)
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKey);
		}
		
		static private function handleKey(e:KeyboardEvent):void 
		{
			var type:String = e.type;
			var key:int= e.keyCode;
			if (type == KeyboardEvent.KEY_DOWN) value = true;
			else value = false;
			
			/*if (key == Keyboard.A) left = value;
			if (key == Keyboard.D) right = value;
			if (key == Keyboard.W) up = value;
			if (key == Keyboard.S) down = value;*/
			if (key == Keyboard.SPACE) space = value;
		}
		
	}

}
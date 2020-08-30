package;


@:expose("Vilog") extern class Vilog {
	static var focusedPlayer(default,null) : VilogPlayer;
	private static var frame : Int;
	private static var images : js.lib.Map<js.html.Element,VilogImage>;
	static var keyboardMode(default,null) : vilog.enums.VilogKeyboardMode;
	private static var lastActiveElement : js.html.Element;
	private static var lastTime : Float;
	private static var players : js.lib.Map<js.html.Element,VilogPlayer>;
	static function changeKeyboardMode(keyboardMode : vilog.enums.VilogKeyboardMode) : Void;
	private static function enterFrame(timestamp : Float) : Void;
	private static function findFocusedPlayer() : Void;
	private static function focusFirst() : Void;
	static function getImage(id : js.html.Element) : VilogImage;
	static function getPlayer(id : js.html.Element) : VilogPlayer;
	private static function isAlive(element : js.html.Node) : Bool;
	@:keep private static function main() : Void;
	private static function onKeyDown(e : js.html.KeyboardEvent) : Void;
	private static function onKeyUp(e : js.html.KeyboardEvent) : Void;
	static function reload() : Void;
	private static function resetFocus() : Void;
}

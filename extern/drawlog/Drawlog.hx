package;

@:expose("Drawlog") extern class Drawlog {
	static var focusedPlayer(default,null) : DrawlogPlayer;
	private static var frame : Int;
	private static var images : js.lib.Map<js.html.Element,DrawlogImage>;
	static var keyboardMode(default,null) : drawlog.enums.DrawlogKeyboardMode;
	private static var lastActiveElement : js.html.Element;
	private static var lastTime : Float;
	private static var players : js.lib.Map<js.html.Element,DrawlogPlayer>;
	static function changeKeyboardMode(keyboardMode : drawlog.enums.DrawlogKeyboardMode) : Void;
	private static function enterFrame(timestamp : Float) : Void;
	private static function findFocusedPlayer() : Void;
	private static function focusFirst() : Void;
	static function getImage(id : js.html.Element) : DrawlogImage;
	static function getPlayer(id : js.html.Element) : DrawlogPlayer;
	private static function isAlive(element : js.html.Node) : Bool;
	@:keep private static function main() : Void;
	private static function onKeyDown(e : js.html.KeyboardEvent) : Void;
	private static function onKeyUp(e : js.html.KeyboardEvent) : Void;
	static function reload() : Void;
	private static function resetFocus() : Void;
	private static function start() : Void;
}

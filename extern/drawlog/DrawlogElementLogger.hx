package;

@:expose("DrawlogElementLogger") extern class DrawlogElementLogger implements DrawlogLogger {
	var background(default,null) : js.html.Element;
	var container(default,null) : js.html.Element;
	var fileName(default,null) : String;
	var foreground(default,null) : js.html.Element;
	var logLevel(default,null) : Int;
	var showsFileName(default,null) : Bool;
	var showsLineNumber(default,null) : Bool;
	function new(fileName : String, logLevel : Int, container : js.html.Element) : Void;
	function clear() : Void;
	function clearBackground() : Void;
	function log(line : Int, message : String, level : drawlog.enums.DrawlogLogLevel, isForBackground : Bool) : Void;
	function setFileName(fileName : String) : Void;
	function setLogLevel(logLevel : Int) : Void;
}

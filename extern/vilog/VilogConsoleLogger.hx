package;

@:expose("VilogConsoleLogger") extern class VilogConsoleLogger implements VilogLogger {
	var fileName(default,null) : String;
	var logLevel(default,null) : Int;
	function new(fileName : String, logLevel : Int) : Void;
	function clear() : Void;
	function clearBackground() : Void;
	function log(line : Int, message : String, level : vilog.enums.VilogLogLevel, isForBackground : Bool) : Void;
	function setFileName(fileName : String) : Void;
	function setLogLevel(logLevel : Int) : Void;
}

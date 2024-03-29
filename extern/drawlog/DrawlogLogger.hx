package;

@:expose("DrawlogLogger") extern interface DrawlogLogger {
	var fileName(default,null) : String;
	var logLevel(default,null) : Int;
	function clear() : Void;
	function clearBackground() : Void;
	function log(line : Int, message : String, level : drawlog.enums.DrawlogLogLevel, isForBackground : Bool) : Void;
	function setFileName(fileName : String) : Void;
	function setLogLevel(logLevel : Int) : Void;
}

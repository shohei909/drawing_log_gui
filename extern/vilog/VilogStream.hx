package;

@:expose("VilogStream") extern class VilogStream {
	private var appendBackground(default,null) : Null<VilogBackground>;
	private var appendContext(default,null) : vilog.enums.VilogStreamContext;
	private var appendFillStyle(default,null) : VilogDrawStyle;
	private var appendLineStyle(default,null) : VilogDrawStyle;
	private var appendTextStyle(default,null) : VilogTextStyle;
	private var arrows : Array<VilogArrow>;
	private var arrowsAngle : Float;
	private var arrowsWaiting : Bool;
	var backgrounds(default,null) : js.lib.Map<Int,VilogBackground>;
	private var changeHandlers : Array<Void -> Void>;
	var content(default,null) : String;
	var currentStep(default,null) : Int;
	private var currentX : Float;
	private var currentY : Float;
	var frames(default,null) : Array<VilogFrame>;
	var lineIndexs(default,null) : Array<Int>;
	private var output : VilogOutput;
	private var position : Int;
	function new(output : VilogOutput) : Void;
	private function _append(text : String) : Void;
	private function _draw(startLine : Int, endLine : Int, isForBackground : Bool, fillStyle : VilogDrawStyle, lineStyle : VilogDrawStyle, textStyle : VilogTextStyle) : Void;
	private function addArrow(line : Int, context : vilog.enums.VilogStreamContext, command : String, isForward : Bool) : Void;
	function addChangeHandler(func : Void -> Void) : Void;
	function append(text : String) : Void;
	private function dispatchChange() : Void;
	private function draw(index : Int) : Void;
	private function drawBackground(index : Int) : Void;
	private function drawFrame(index : Int) : Void;
	private function endBackground() : Void;
	private function error(lineNumber : Int, message : String) : Void;
	function getLength() : Int;
	function getLineNumber() : Int;
	function goto(index : Int) : Void;
	private function log(lineNumber : Int, command : String, level : vilog.enums.VilogLogLevel, isForBackground : Bool) : Void;
	private function matchColor(line : Int, defaultValue : Void -> UInt) : UInt;
	private function matchFloat(line : Int, defaultValue : Void -> Float) : Float;
	private function matchInt(line : Int, defaultValue : Void -> Int) : Int;
	private function matchString(lineNumber : Int, defaultValue : Void -> String) : String;
	private function preprocessLine() : Bool;
	function readFillStyle(line : Int, context : vilog.enums.VilogStreamContext, command : String, currrentFillStyle : VilogDrawStyle) : VilogDrawStyle;
	function readLineStyle(line : Int, context : vilog.enums.VilogStreamContext, command : String, currrentLineStyle : VilogDrawStyle) : VilogDrawStyle;
	function readTextStyle(line : Int, context : vilog.enums.VilogStreamContext, command : String, currrentTextStyle : VilogTextStyle) : VilogTextStyle;
	function removeChangeHandler(func : Void -> Void) : Void;
	function reset() : Void;
	private function setArrowsBack(func : Void -> Float) : Void;
	function setContent(content : String) : Void;
	function step() : Void;
	private static var atomRegExp : js.lib.RegExp;
	private static var backgroundRegExp : js.lib.RegExp;
	private static var color3 : js.lib.RegExp;
	private static var color6 : js.lib.RegExp;
	private static var color8 : js.lib.RegExp;
	private static var emptyString : String;
	private static var newlineRegExp : js.lib.RegExp;
	private static var stepRegExp : js.lib.RegExp;
}
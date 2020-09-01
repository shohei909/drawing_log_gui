package;

@:expose("DrawlogStream") extern class DrawlogStream {
	private var appendBackground(default,null) : Null<DrawlogBackground>;
	private var appendContext(default,null) : drawlog.enums.DrawlogStreamContext;
	private var appendFillStyle(default,null) : DrawlogDrawStyle;
	private var appendLineStyle(default,null) : DrawlogDrawStyle;
	private var appendTextStyle(default,null) : DrawlogTextStyle;
	private var arrows : Array<DrawlogArrow>;
	private var arrowsAngle : Float;
	private var arrowsWaiting : Bool;
	var backgrounds(default,null) : js.lib.Map<Int,DrawlogBackground>;
	private var changeHandlers : Array<Void -> Void>;
	var content(default,null) : String;
	var currentStep(default,null) : Int;
	private var currentX : Float;
	private var currentY : Float;
	var frames(default,null) : Array<DrawlogFrame>;
	var lineIndexs(default,null) : Array<Int>;
	private var output : DrawlogOutput;
	private var position : Int;
	function new(output : DrawlogOutput) : Void;
	private function _append(text : String) : Void;
	private function _draw(startLine : Int, endLine : Int, isForBackground : Bool, fillStyle : DrawlogDrawStyle, lineStyle : DrawlogDrawStyle, textStyle : DrawlogTextStyle) : Void;
	private function addArrow(line : Int, context : drawlog.enums.DrawlogStreamContext, command : String, isForward : Bool) : Void;
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
	private function log(lineNumber : Int, command : String, level : drawlog.enums.DrawlogLogLevel, isForBackground : Bool) : Void;
	private function matchColor(line : Int, defaultValue : Void -> UInt) : UInt;
	private function matchFloat(line : Int, defaultValue : Void -> Float) : Float;
	private function matchInt(line : Int, defaultValue : Void -> Int) : Int;
	private function matchString(lineNumber : Int, defaultValue : Void -> String) : String;
	private function preprocessLine() : Bool;
	function readFillStyle(line : Int, context : drawlog.enums.DrawlogStreamContext, command : String, currrentFillStyle : DrawlogDrawStyle) : DrawlogDrawStyle;
	function readLineStyle(line : Int, context : drawlog.enums.DrawlogStreamContext, command : String, currrentLineStyle : DrawlogDrawStyle) : DrawlogDrawStyle;
	function readTextStyle(line : Int, context : drawlog.enums.DrawlogStreamContext, command : String, currrentTextStyle : DrawlogTextStyle) : DrawlogTextStyle;
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

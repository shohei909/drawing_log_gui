package vilog;

@:expose("DrawlogBackground") extern class DrawlogBackground {
	var depth(default,null) : Int;
	var end : Int;
	var fillStyle(default,null) : DrawlogDrawStyle;
	var lineStyle(default,null) : DrawlogDrawStyle;
	var start(default,null) : Int;
	var textStyle(default,null) : DrawlogTextStyle;
	function new(start : Int, end : Int, depth : Int, fillStyle : DrawlogDrawStyle, lineStyle : DrawlogDrawStyle, textStyle : DrawlogTextStyle) : Void;
}

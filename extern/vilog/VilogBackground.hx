package;

@:expose("VilogBackground") extern class VilogBackground {
	var depth(default,null) : Int;
	var end : Int;
	var fillStyle(default,null) : VilogDrawStyle;
	var lineStyle(default,null) : VilogDrawStyle;
	var start(default,null) : Int;
	var textStyle(default,null) : VilogTextStyle;
	function new(start : Int, end : Int, depth : Int, fillStyle : VilogDrawStyle, lineStyle : VilogDrawStyle, textStyle : VilogTextStyle) : Void;
}

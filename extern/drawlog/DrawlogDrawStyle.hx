package vilog;

@:expose("DrawlogDrawStyle") extern class DrawlogDrawStyle {
	var fillColor(default,null) : UInt;
	var kind(default,null) : vilog.enums.DrawlogDrawStyleKind;
	var lineColor(default,null) : UInt;
	var lineThickness(default,null) : Float;
	function new(kind : vilog.enums.DrawlogDrawStyleKind, fillColor : UInt, lineThickness : Float, lineColor : UInt) : Void;
	private function getColorString(color : UInt) : String;
	function getFillAlpha() : Float;
	function getFillColorString() : String;
	function getLineAlpha() : Float;
	function getLineColorString() : String;
}

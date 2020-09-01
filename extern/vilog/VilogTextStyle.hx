package;

@:expose("DrawlogTextStyle") extern class DrawlogTextStyle {
	var fontFamily(default,null) : String;
	var fontSize(default,null) : Float;
	var italic(default,null) : Bool;
	var pivotX(default,null) : Float;
	var pivotY(default,null) : Float;
	var weight(default,null) : Int;
	function new(fontFamily : String, fontSize : Float, weight : Int, italic : Bool, pivotX : Float, pivotY : Float) : Void;
}

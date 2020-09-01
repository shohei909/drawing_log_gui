package vilog;

@:expose("DrawlogArrow") extern class DrawlogArrow {
	var angle : Float;
	var corner(default,null) : Float;
	var isForward(default,null) : Bool;
	var radius(default,null) : Float;
	var x(default,null) : Float;
	var y(default,null) : Float;
	function new(x : Float, y : Float, radius : Float, corner : Float, isForward : Bool, angle : Float) : Void;
}

package;

@:expose("DrawlogFrame") extern class DrawlogFrame {
	var background(default,null) : js.lib.Map<Int,Array<Int>>;
	private var backgroundSortedCount : Int;
	var clear(default,null) : Bool;
	var end : Int;
	var fillStyle(default,null) : DrawlogDrawStyle;
	var hasBackgroundUpdate(default,null) : Bool;
	var lineStyle(default,null) : DrawlogDrawStyle;
	var start(default,null) : Int;
	var textStyle(default,null) : DrawlogTextStyle;
	function new(start : Int, end : Int, clear : Bool, fillStyle : DrawlogDrawStyle, lineStyle : DrawlogDrawStyle, textStyle : DrawlogTextStyle, background : js.lib.Map<Int,Array<Int>>, hasBackgroundUpdate : Bool) : Void;
	function isEmpty() : Bool;
	function setBackground(background : js.lib.Map<Int,Array<Int>>) : Void;
	@:has_untyped function sortBackground() : Void;
}

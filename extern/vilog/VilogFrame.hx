package;

@:expose("VilogFrame") extern class VilogFrame {
	var background(default,null) : js.lib.Map<Int,Array<Int>>;
	private var backgroundSortedCount : Int;
	var clear(default,null) : Bool;
	var end : Int;
	var fillStyle(default,null) : VilogDrawStyle;
	var hasBackgroundUpdate(default,null) : Bool;
	var lineStyle(default,null) : VilogDrawStyle;
	var start(default,null) : Int;
	var textStyle(default,null) : VilogTextStyle;
	function new(start : Int, end : Int, clear : Bool, fillStyle : VilogDrawStyle, lineStyle : VilogDrawStyle, textStyle : VilogTextStyle, background : js.lib.Map<Int,Array<Int>>, hasBackgroundUpdate : Bool) : Void;
	function isEmpty() : Bool;
	function setBackground(background : js.lib.Map<Int,Array<Int>>) : Void;
	@:has_untyped function sortBackground() : Void;
}

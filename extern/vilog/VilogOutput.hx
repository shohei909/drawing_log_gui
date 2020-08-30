package;

@:expose("VilogOutput") extern interface VilogOutput extends VilogLogger {
	function arc(cx : Float, cy : Float, r : Float, startAngle : Float, sweepAngle : Float, isForBackground : Bool) : Void;
	function cubicTo(x0 : Float, y0 : Float, x1 : Float, y1 : Float, x2 : Float, y2 : Float, isForBackground : Bool) : Void;
	function drawArrows(arrows : Array<VilogArrow>, isForBackground : Bool, pathStyle : VilogDrawStyle) : Void;
	function drawCircle(x : Float, y : Float, radius : Float, isForBackground : Bool, style : VilogDrawStyle) : Void;
	function drawGrid(x : Float, y : Float, width : Float, height : Float, repeatX : Int, repeatY : Int, padding : Float, isForBackground : Bool, style : VilogDrawStyle) : Void;
	function drawRect(x : Float, y : Float, width : Float, height : Float, isForBackground : Bool, style : VilogDrawStyle) : Void;
	function drawText(message : String, x : Float, y : Float, maxWidth : Float, isForBackground : Bool, style : VilogDrawStyle, textStyle : VilogTextStyle) : Void;
	function endPath(isForBackground : Bool, style : VilogDrawStyle) : Void;
	function initializeCanvas(width : Float, height : Float, defaultFps : Float) : Void;
	function lineTo(x : Float, y : Float, isForBackground : Bool) : Void;
	function quadTo(x0 : Float, y0 : Float, x1 : Float, y1 : Float, isForBackground : Bool) : Void;
	function startPath(x : Float, y : Float, isForBackground : Bool, style : VilogDrawStyle) : Void;
}

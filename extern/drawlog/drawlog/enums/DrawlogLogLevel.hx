package drawlog.enums;

@:expose("DrawlogLogLevel")
enum abstract DrawlogLogLevel(Int) to Int
{
	public static var All:Int = 0;
	public static var Off:Int = 8;
	
	var Trace = 1;
	var Info  = 3;
	var Warn  = 5;
	var Error = 7;
}

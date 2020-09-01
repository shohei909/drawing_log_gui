package drawlog.enums;

@:expose("DrawlogKeyboardMode")
enum abstract DrawlogKeyboardMode(Int)
{
	var Always        = 0;
	var FocusedOrBody = 1;
	var Focused       = 2;
	var Never         = 3;
}

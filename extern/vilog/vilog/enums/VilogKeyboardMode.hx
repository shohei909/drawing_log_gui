package vilog.enums;

@:expose("VilogKeyboardMode")
enum abstract VilogKeyboardMode(Int)
{
	var Always        = 0;
	var FocusedOrBody = 1;
	var Focused       = 2;
	var Never         = 3;
}

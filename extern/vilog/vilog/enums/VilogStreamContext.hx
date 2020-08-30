package vilog.enums;

@:expose("VilogStreamContext")
enum abstract VilogStreamContext(Int)
{
	var Header = 0;
	var Body   = 1;
	var Path   = 2;
}

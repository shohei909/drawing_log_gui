package drawlog.enums;

@:expose("DrawlogStreamContext")
enum abstract DrawlogStreamContext(Int)
{
	var Header = 0;
	var Body   = 1;
	var Path   = 2;
}

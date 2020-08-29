package ;
import golden_layout.Container;
import golden_layout.ContentItem;

class FocusManager 
{
	public static var focusedItem:ContentItem;
	
	public static function focus(container:Container):Void
	{
		focusedItem = container.parent;
	}	
}

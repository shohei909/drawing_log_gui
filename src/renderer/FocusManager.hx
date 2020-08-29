package ;
import golden_layout.Container;
import golden_layout.ContentItem;
import js.Browser;
import js.html.Node;

class FocusManager 
{
	public static var focusedItem(get, null):ContentItem;
	private static function get_focusedItem():ContentItem 
	{
		if (focusedItem != null && !isAlive(focusedItem.element.get(0)))
		{
			focusedItem = null;
		}
		return focusedItem;
	}
	
	private static function isAlive(element:Node):Bool
	{
		if (element == null) return false;
		while ((element = element.parentNode) != null) {
			if (element == Browser.document) {
				return true;
			}
		}
        return false;
	}
	
	public static function focus(container:Container):Void
	{
		focusedItem = container.parent;
	}	
}

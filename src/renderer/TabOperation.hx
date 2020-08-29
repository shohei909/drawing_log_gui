package ;

class TabOperation 
{
	public static function close():Void
	{
		var item = FocusManager.focusedItem;
		if (item == null) return;
		if (item.isComponent)
		{
			item.remove();
		}
	}
	
	public static function closeOthers():Void
	{
		var item = FocusManager.focusedItem;
		if (item == null) return;
		if (item.parent == null || !item.parent.isStack) return;
		
		for (i in item.parent.contentItems)
		{
			if (i.isComponent && i != item)
			{
				i.remove();
			}
		}
	}
	
	public static function closeAll():Void
	{
		closeOthers();
		close();
	}
}
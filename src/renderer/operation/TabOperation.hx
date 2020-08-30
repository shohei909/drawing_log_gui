package operation;

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
	
	public static function reload():Void
	{
		var item = FocusManager.focusedItem;
		if (item == null) return;
		if (item.isComponent)
		{
			FileOperation.reload(item);
		}
	}
	
	public static function closeAll():Void
	{
		closeOthers();
		close();
	}
	
	
	public static function next():Void
	{
		var item = FocusManager.focusedItem;
		if (item == null) return;
		if (item.parent == null || !item.parent.isStack) return;
		
		var index = item.parent.contentItems.indexOf(item);
		var length = item.parent.contentItems.length;
		var targetItem = item.parent.contentItems[(index + 1) % length];
		
		item.parent.setActiveContentItem(targetItem);
		targetItem.element.focus();
	}
	public static function prev():Void
	{
		var item = FocusManager.focusedItem;
		if (item == null) return;
		if (item.parent == null || !item.parent.isStack) return;
		
		var index = item.parent.contentItems.indexOf(item);
		var length = item.parent.contentItems.length;
		var targetItem = item.parent.contentItems[(index + length - 1) % length];
		
		item.parent.setActiveContentItem(targetItem);
		targetItem.element.focus();
	}
}
package operation;
import js.html.CanvasElement;
import js.html.Element;

class TabOperation 
{
	
	public static function zoomIn():Void
	{
		var item = FocusManager.focusedItem;
		if (item == null) return;
		if (item.isComponent)
		{
			zoom(1.5);
		}
	}
	public static function zoomOut():Void
	{
		var item = FocusManager.focusedItem;
		if (item == null) return;
		if (item.isComponent)
		{
			zoom(1 / 1.5);
		}
	}
	public static function zoom(value:Float):Void
	{
		var item = FocusManager.focusedItem;
		var element = item.element.get(0).getElementsByClassName("vi-image").item(0);
		var scale:Float = untyped if (item.config.scale == null || item.config.scale == 0) 1.0 else item.config.scale;
		if (1 <= value || 0.1 <= scale)
		{
			scale *= value;
			untyped item.config.scale = scale;
			applyZoom(element, scale);
		}
	}
	public static function applyZoom(element:Element, scale:Float):Void
	{
		var width = 0;
		var height = 0;
		for (canvas in element.getElementsByTagName("canvas"))
		{
			var canvas:CanvasElement = cast canvas;
			width = canvas.width;
			height = canvas.height;
			canvas.style.width = width * scale + "px";
			canvas.style.height = height * scale + "px";
		}
		if (width != 0)
		{
			element.style.width = width * scale + "px";
			element.style.height = height * scale + "px";
			element.style.imageRendering = if (1 < scale) "pixelated" else "";
		}
		
	}
	public static function zoomReset():Void
	{
		var item = FocusManager.focusedItem;
		if (item == null) return;
		if (item.isComponent)
		{
			var element = item.element.get(0).getElementsByClassName("vi-image").item(0);
			var scale = 1;
			untyped item.config.scale = scale;
			applyZoom(element, scale);
		}
	}
	
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
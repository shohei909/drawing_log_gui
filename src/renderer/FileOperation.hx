package ;
import electron.main.Dialog;
import electron.renderer.Remote;
import golden_layout.ContentItem;
import js.Node;
import js.node.Path;

class FileOperation 
{
	public static function open():Void
	{
		var dialog = untyped Remote.dialog;
		var openDialog = dialog.showOpenDialog(
			Remote.getCurrentWindow(),
			{
				properties: ['openFile', 'multiSelections'],
				filters: [
					{
						name: 'Visual Log',
						extensions: ['vilog']
					}
				]
			}
		).then(openFiles);
	}
	public static function openFile(path:String):Void
	{
		var path = Path.resolve(path);
		var existing = Main.goldenLayout.root.getItemsByFilter(
			(item:ContentItem) -> {
				var state = item.config.componentState;
				if (state == null) return false;
				untyped state.path == path;
			}
		);
		if (0 < existing.length)
		{
			var target = existing[0];
			if (target.parent != null && target.parent.isStack)
			{
				target.parent.setActiveContentItem(target);
			}
		}
		else
		{
			var stack = findStackFromBottom(FocusManager.focusedItem);
			if (stack == null)
			{
				stack = findStackFromTop(Main.goldenLayout.root);
			}
			stack.addChild(Main.createFileContent(path));
		}
	}
	
	private static function openFiles(event:Dynamic):Void 
	{
		var filePaths:Array<String> = event.filePaths;
		for (path in filePaths)
		{
			openFile(path);
		}
	}
	
	private static function findStackFromBottom(item:ContentItem):ContentItem
	{
		if (item == null) return null;
		if (item.isStack) return item;
		return findStackFromBottom(item.parent);
	}
	private static function findStackFromTop(item:ContentItem):ContentItem
	{
		if (item.isStack)
		{
			return item;
		}
		if (item.isComponent)
		{
			item.parent.addChild({ type: "stack", content:[] });
			var stack = item.parent.contentItems[item.parent.contentItems.length - 1];
			item.parent.removeChild(item);
			stack.addChild(item);
			return stack;
		}
		if (item.contentItems.length == 0)
		{
			item.addChild({ type: "stack", content:[] });
			return item.contentItems[item.contentItems.length - 1];
		}
		return findStackFromTop(item.contentItems[0]);
	}
	
	public static function export():Void
	{
		
	}
}

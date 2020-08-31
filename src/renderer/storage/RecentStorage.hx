package storage;
import electron.main.BrowserWindow;
import electron.main.BrowserWindow.BrowserWindowEvent;
import electron.renderer.Remote;
import haxe.Json;
import js.node.Path;
import sys.FileSystem;
import sys.io.File;

class RecentStorage 
{
	private static var PATH:String = untyped Remote.app.getPath("userData") + "/state/recent.json";
	public static var history:Array<String> = [];
	
	private static function save():Void
	{
		var dir = Path.dirname(PATH);
		if (!FileSystem.exists(dir))
		{
			FileSystem.createDirectory(dir);
		}
		File.saveContent(PATH, Json.stringify(history));
	}
	public static function load(browserWindow:BrowserWindow):Void
	{
		browserWindow.on(
			BrowserWindowEvent.close,
			save
		);
		if (FileSystem.exists(PATH))
		{
			try {
				var data = Json.parse(File.getContent(PATH));
				if (data != null)
				{
					history = data;
				}
			} catch (d:Dynamic) {}
		}
	}
	
	public static function remove(path:String):Void 
	{
		if (history.remove(path))
		{
			MenuBuilder.updateMenu();
		}
	}
	
	public static function add(path:String):Void 
	{
		var index = history.indexOf(path);
		if (index == 0) return;
		if (index != -1)
		{
			history.remove(path);
		}
		history.unshift(path);
		if (history.length > 40)
		{
			history.pop();
		}
		MenuBuilder.updateMenu();
	}
}

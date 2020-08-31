package storage;
import electron.main.BrowserWindow;
import electron.main.BrowserWindow.BrowserWindowEvent;
import electron.renderer.Remote;
import golden_layout.Config.ItemConfig;
import haxe.Json;
import js.node.Path;
import sys.FileSystem;
import sys.io.File;

class LayoutStorage 
{
	private static var PATH:String = untyped Remote.app.getPath("userData") + "/state/layout.json";
	private static function save():Void
	{
		var dir = Path.dirname(PATH);
		if (!FileSystem.exists(dir))
		{
			FileSystem.createDirectory(dir);
		}
		
		if (Main.goldenLayout.isInitialised)
		{
			var content:Array<ItemConfig> = Main.goldenLayout.toConfig().content;
			File.saveContent(PATH, Json.stringify(content[0]));
		}
	}
	public static function load(browserWindow:BrowserWindow, fileNames:Array<String>):ItemConfig
	{
		browserWindow.on(
			BrowserWindowEvent.close,
			save
		);
		return if (fileNames.length == 0)
		{
			if (FileSystem.exists(PATH))
			{
				try {
					var data = Json.parse(File.getContent(PATH));
					if (data.content != null)
					return data;
				} catch (d:Dynamic) {}
			} 
			{
				type: "stack",
				content: []
			}
		}
		else
		{
			{
				type: "stack",
				content: [for (fileName in fileNames) createFileContent(fileName)]
			}
		}
	}
	
	public static function createFileContent(path:String):ItemConfig
	{
		return {
			type: 'component',
			componentName: 'file',
			componentState: {
				path: Path.resolve(path),
				sizes: [80, 20],
			},
			id : "f" + Std.random(0x7FFFFFF),
			title: Path.basename(path)
		};
	}
}

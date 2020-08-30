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
	private static var DIR:String = untyped Remote.app.getPath("userData") + "/state/layout";
	private static function save(key:String):Void
	{
		if (!FileSystem.exists(DIR))
		{
			FileSystem.createDirectory(DIR);
		}
		
		var path = DIR + "/" + key + ".json";
		if (Main.goldenLayout.isInitialised)
		{
			var content:Array<ItemConfig> = Main.goldenLayout.toConfig().content;
			File.saveContent(path, Json.stringify(content[0]));
		}
	}
	public static function load(browserWindow:BrowserWindow, fileNames:Array<String>, key:String):ItemConfig
	{
		browserWindow.on(
			BrowserWindowEvent.close,
			function ()
			{
				save(key);
			}
		);
		var path = DIR + "/" + key + ".json";
		return if (fileNames.length == 0)
		{
			if (FileSystem.exists(path))
			{
				Json.parse(File.getContent(path));
			}
			else
			{
				{
					type: "stack",
					content: []
				}
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

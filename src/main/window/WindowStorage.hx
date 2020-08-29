package window;
import electron.Rectangle;
import electron.main.App;
import electron.main.BrowserWindow;
import haxe.Json;
import js.html.Event;
import sys.FileSystem;
import sys.io.File;

class WindowStorage 
{
	private static var DIR:String = App.getPath("userData") + "window";
	
	private static function save(browserWindow:BrowserWindow, key:String):Void
	{
		if (!FileSystem.exists(DIR))
		{
			FileSystem.createDirectory(DIR);
		}
		var path = DIR + "/" + key + ".json";
		var bounds = browserWindow.getBounds();
		File.saveContent(
			path,
			Json.stringify(
				{
					x           : bounds       .x             ,
					y           : bounds       .y             ,
					width       : bounds       .width         ,
					height      : bounds       .height        ,
					isMaximized : browserWindow.isMaximized() ,
					isMinimized : browserWindow.isMinimized() ,
					isFullScreen: browserWindow.isFullScreen(),
				}
			)
		);
	}
	
	public static function load(browserWindow:BrowserWindow, key:String):Void
	{
		browserWindow.on(
			BrowserWindowEvent.close,
			function ()
			{
				save(browserWindow, key);
			}
		);
		var path = DIR + "/" + key + ".json";
		if (FileSystem.exists(path))
		{
			var data:WindowStorageData = Json.parse(File.getContent(path));
			browserWindow.setBounds({
				x           : data.x     ,
				y           : data.y     ,
				width       : data.width ,
				height      : data.height,
			});
			if (data.isMaximized)
			{
				browserWindow.maximize();
			}
			if (data.isMinimized)
			{
				browserWindow.minimize();
			}
			if (data.isFullScreen)
			{
				browserWindow.setFullScreen(true);
			}
		}
	}
}

private typedef WindowStorageData =
{
	x           : Float,
	y           : Float,
	width       : Float,
	height      : Float,
	isMaximized : Bool ,
	isMinimized : Bool ,
	isFullScreen: Bool ,
}

package ;
import electron.Event;
import electron.main.App;
import electron.main.BrowserWindow;
import js.Node;
import js.node.Process;
import window.WindowStorage;

class Main 
{
	public static var WINDOW_STORAGE_KEY:String = "viewer";
	public static function main() 
	{
		App.on('window-all-closed', function(e:Event) { App.quit(); });
		App.on(ready, onReady);
	}
	
	private static function onReady():Void
	{
		var window = new BrowserWindow({
			x         : 150,
			y         : 150,
			width     : 1000,
			height    : 750,
			webPreferences: {
				nodeIntegration : true,
				contextIsolation: false,
				enableRemoteModule: true,
				preload: Node.__dirname + '/renderer.js',
			},
			title: "Visual Log Viewer",
			autoHideMenuBar: false,
			show : true,
			icon : Node.__dirname + "/icon.png",
		});
		window.setMenu(MenuBuilder.build());
		WindowStorage.load(window, WINDOW_STORAGE_KEY);
		window.webContents.on("did-finish-load", onLoad.bind(window));
		window.loadFile('index.html');
	}
	
	private static function onLoad(window:BrowserWindow):Void
	{
		var args = Node.process.argv.slice(if (App.isPackaged) 1 else 2);
		window.webContents.send("init", args);
	}
}

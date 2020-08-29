package ;
import electron.renderer.IpcRenderer;
import electron.renderer.Remote;
import golden_layout.Config.ItemConfig;
import golden_layout.Container;
import golden_layout.GoldenLayout;
import js.Browser;
import js.Node;
import js.Syntax;
import js.node.Path;

class Main 
{
	public static var goldenLayout:GoldenLayout;
	public static function main():Void
	{
		var currentWindow = Remote.getCurrentWindow();
		currentWindow.setMenu(MenuBuilder.build());
		IpcRenderer.on("init", init);
	}

	private static function init(event:Dynamic, fileNames:Array<Dynamic>):Void
	{
		untyped Browser.window.$ = Browser.window.jQuery = Node.require("jquery");
		Syntax.code('var GoldenLayout = require("golden-layout")');
		var contents = [for (fileName in fileNames) createFileContent(fileName)];
		var config = {
			content:[{
				type: "stack",
				content: contents
			}]
		};
		goldenLayout = new GoldenLayout(config);
		goldenLayout.registerComponent("file", openFile);
		goldenLayout.init();
	}
	
	private static function openFile(container:Container, componentState :Dynamic):Void
	{
		var element = container.getElement().get(0);
	}
	
	private static function createFileContent(path:String):ItemConfig
	{
		return {
			type: 'component',
			componentName: 'file',
			componentState: { path: path },
			title: Path.basename(path)
		};
	}
}

package ;
import electron.renderer.IpcRenderer;
import electron.renderer.Remote;
import golden_layout.Config;
import golden_layout.Config.ItemConfig;
import golden_layout.Container;
import golden_layout.GoldenLayout;
import js.Browser;
import js.Node;
import js.Syntax;
import js.html.DragEvent;
import js.html.Event;
import js.lib.BufferSource;
import js.node.Path;
import Vilog;
import vilog.enums.VilogKeyboardMode;
import vilog.enums.VilogLogLevel;

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
		var vilog = Node.require("./vilog.min.js");
		untyped window.Vilog = vilog.Vilog;
		untyped window.VilogElementLogger = vilog.VilogElementLogger;
		
		Vilog.changeKeyboardMode(VilogKeyboardMode.FocusedOrBody);
		
		untyped Browser.window.$ = Browser.window.jQuery = Node.require("jquery");
		Syntax.code('var GoldenLayout = require("golden-layout")');
		var contents = [for (fileName in fileNames) createFileContent(fileName)];
		var config:Config = {
			settings: {
				showPopoutIcon: false,
				showMaximiseIcon: false,
			},
			content:[{
				type: "stack",
				content: contents
			}]
		};
		goldenLayout = new GoldenLayout(config);
		goldenLayout.registerComponent("file", openFile);
		goldenLayout.init();
		
		Browser.document.ondragover = Browser.document.ondrop = function(e) {
			e.preventDefault();
			return false;
		};
		Browser.document.body.addEventListener("drop", onDrop);
	}
	
	private static function onDrop(e:DragEvent):Void
	{
		if (0 < e.dataTransfer.files.length)
		{
			e.preventDefault();
			FileOperation.openFile(untyped e.dataTransfer.files[0].path);
		}
	}
	
	private static function openFile(container:Container, componentState :Dynamic):Void
	{
		var element = container.getElement().get(0);
		element.tabIndex = 0;
		
		var id = "player_" + container.parent.config.id;
		container.getElement().get(0).innerHTML = '
<div id="$id" class="vilog-player">
<div class="vi-row vi-content"><div class="vilog"></div></div>
</div>
<code class="vilog-log"></code>
';
		container.on(ContainerEvent.Show, onOpen.bind(container));
	}
	
	private static function onOpen(container:Container):Void
	{
		container.off(ContainerEvent.Show);
		var id = "player_" + container.parent.config.id;
		var element = Browser.document.getElementById(id);
		var player = Vilog.getPlayer(element);
		var image:VilogImage = Vilog.getImage(element.getElementsByClassName("vilog").item(0));
		var path = untyped container.parent.config.componentState.path;
		image.loadFile(path);
		
		image.addLogger(new VilogElementLogger(path, VilogLogLevel.All, container.getElement().get(0).getElementsByClassName("vilog-log").item(0)));
		
		container.on(ContainerEvent.Show, FocusManager.focus.bind(container));
		element.addEventListener("focus", FocusManager.focus.bind(container));
		container.on(ContainerEvent.Show, onFocus.bind(container));
		element.addEventListener("focus", onFocus.bind(container));
		
		FocusManager.focus(container);
		onFocus(container);
	}
	private static function onFocus(container:Container):Void 
	{
		var id = "player_" + container.parent.config.id;
		var element = Browser.document.getElementById(id);
		if (element != null && element != Browser.document.activeElement) { element.focus(); }
	}
	
	public static function createFileContent(path:String):ItemConfig
	{
		return {
			type: 'component',
			componentName: 'file',
			componentState: { path: Path.resolve(path) },
			id : "f" + Std.random(0x7FFFFFF),
			title: Path.basename(path)
		};
	}
}

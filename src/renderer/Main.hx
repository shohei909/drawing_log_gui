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
import js.html.WheelEvent;
import js.lib.BufferSource;
import js.node.Path;
import Vilog;
import operation.FileOperation;
import operation.TabOperation;
import storage.LayoutStorage;
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

	private static function init(event:Dynamic, fileNames:Array<String>):Void
	{
		var vilog = Node.require("./vilog.min.js");
		untyped window.Vilog = vilog.Vilog;
		untyped window.VilogElementLogger = vilog.VilogElementLogger;
		
		Vilog.changeKeyboardMode(VilogKeyboardMode.FocusedOrBody);
		
		untyped Browser.window.$ = Browser.window.jQuery = Node.require("jquery");
		untyped window.GoldenLayout = require("golden-layout");
		var contents = LayoutStorage.load(Remote.getCurrentWindow(), fileNames, "main");
		var config:Config = {
			settings: {
				showPopoutIcon: false,
				showMaximiseIcon: false,
			},
			content:[contents]
		};
		goldenLayout = new GoldenLayout(config);
		goldenLayout.registerComponent("file", openFile);
		goldenLayout.init();
		
		Browser.document.ondragover = Browser.document.ondrop = function(e) {
			e.preventDefault();
			return false;
		};
		Browser.document.body.addEventListener("drop", onDrop);
		Browser.window.addEventListener("wheel", onWheel);
	}
	private static function onWheel(e:WheelEvent):Void
	{
		if (e.ctrlKey)
		{
			if (e.deltaY != 0)
			{
				TabOperation.zoom(Math.pow(1.125, -e.deltaY / 100));
			}
		}
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
		var config = container.parent.config;
		var id = "player_" + config.id;
		var playerElement = Browser.document.getElementById(id);
		var player = Vilog.getPlayer(playerElement);
		var imageElement = playerElement.getElementsByClassName("vilog").item(0);
		var image:VilogImage = Vilog.getImage(imageElement);
		var path = untyped config.componentState.path;
		image.stream.addChangeHandler(() -> {
			var scale:Float = untyped if (config.scale == null || config.scale == 0) 1.0 else config.scale;
			TabOperation.applyZoom(container.getElement().get(0).getElementsByClassName("vi-image").item(0), scale);	
		});
		image.loadFile(path);
		
		var logElement = container.getElement().get(0).getElementsByClassName("vilog-log").item(0);
		image.addLogger(new VilogElementLogger(path, VilogLogLevel.All, logElement));
		
		container.on(ContainerEvent.Show, FocusManager.focus.bind(container));
		playerElement.addEventListener("focus", FocusManager.focus.bind(container));
		container.on(ContainerEvent.Show, onFocus.bind(container));
		playerElement.addEventListener("focus", onFocus.bind(container));
		var split:Dynamic = Node.require("./splitjs/split.min.js");
		
		split(
			[playerElement, logElement], 
			{
				direction: 'vertical',
				sizes: untyped config.componentState.sizes,
				gutterSize: 7,
			}
		);
		
		FocusManager.focus(container);
		onFocus(container);
	}
	
	private static function onFocus(container:Container):Void 
	{	
		var id = "player_" + container.parent.config.id;
		var element = Browser.document.getElementById(id);
		if (element != null && element != Browser.document.activeElement) { element.focus(); }
	}
}

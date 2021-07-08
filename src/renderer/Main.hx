package ;
import electron.renderer.IpcRenderer;
import electron.renderer.Remote;
import golden_layout.Config;
import golden_layout.Config.ItemConfig;
import golden_layout.Container;
import golden_layout.GoldenLayout;
import golden_layout.Tab;
import js.Browser;
import js.Node;
import js.Syntax;
import js.html.DragEvent;
import js.html.Event;
import js.html.WheelEvent;
import js.lib.BufferSource;
import js.node.Path;
import Drawlog;
import locale.Locale;
import operation.FileOperation;
import operation.TabOperation;
import setting.KeyConfig;
import storage.LayoutStorage;
import storage.RecentStorage;
import drawlog.enums.DrawlogKeyboardMode;
import drawlog.enums.DrawlogLogLevel;

class Main 
{
	public static var goldenLayout:GoldenLayout;
	public static function main():Void
	{
		var currentWindow = Remote.getCurrentWindow();
		Locale.load();
		KeyConfig.load();
		RecentStorage.load(currentWindow);
		MenuBuilder.updateMenu();
		
		IpcRenderer.on("init", init);
	}

	private static function init(event:Dynamic, fileNames:Array<String>):Void
	{
		var drawlog = Node.require("./drawlog.min.js");
		untyped window.Drawlog = drawlog.Drawlog;
		untyped window.DrawlogElementLogger = drawlog.DrawlogElementLogger;
		
		Drawlog.changeKeyboardMode(DrawlogKeyboardMode.FocusedOrBody);
		
		untyped Browser.window.$ = Browser.window.jQuery = Node.require("jquery");
		untyped window.GoldenLayout = require("golden-layout");
		
		var contents = LayoutStorage.load(Remote.getCurrentWindow(), fileNames);
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
<div id="$id" class="drawlog-player">
<div class="vi-row vi-content"><div class="drawlog"></div></div>
</div>
<code class="drawlog-log" data-shows="line"></code>
';
		container.on(ContainerEvent.Show, onOpen.bind(container));
		container.on(
			ContainerEvent.Tab,
			tab -> {
				container.tab.element.attr("title", untyped container.parent.config.componentState.path);
			}
		);
	}
	
	private static function onOpen(container:Container):Void
	{
		container.off(ContainerEvent.Show);
		var config = container.parent.config;
		var id = "player_" + config.id;
		var playerElement = Browser.document.getElementById(id);
		var player = Drawlog.getPlayer(playerElement);
		var imageElement = playerElement.getElementsByClassName("drawlog").item(0);
		var image:DrawlogImage = Drawlog.getImage(imageElement);
		var path = untyped config.componentState.path;
		var logElement = container.getElement().get(0).getElementsByClassName("drawlog-log").item(0);
		image.addLogger(new DrawlogElementLogger(path, DrawlogLogLevel.All, logElement));
		
		var initialized = false;
		image.stream.addChangeHandler(() -> {
			var scale:Float = untyped if (config.scale == null || config.scale == 0) 1.0 else config.scale;
			TabOperation.applyZoom(container.getElement().get(0).getElementsByClassName("vi-image").item(0), scale);	
			if (!initialized)
			{
				var split:Dynamic = Node.require("./splitjs/split.min.js");
				split(
					[playerElement, logElement], 
					{
						direction: 'vertical',
						sizes: untyped config.componentState.sizes,
						gutterSize: 7,
					}
				);
				initialized = true;
			}
		});
		image.loadFile(path);
		
		
		container.on(ContainerEvent.Show, FocusManager.focus.bind(container));
		playerElement.addEventListener("focus", FocusManager.focus.bind(container));
		container.on(ContainerEvent.Show, onFocus.bind(container));
		playerElement.addEventListener("focus", onFocus.bind(container));
		
		
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

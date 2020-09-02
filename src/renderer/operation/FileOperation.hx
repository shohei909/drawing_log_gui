package operation;
import electron.main.Dialog;
import electron.renderer.Remote;
import golden_layout.ContentItem;
import js.Browser;
import js.Node;
import js.node.ChildProcess;
import js.node.Path;
import js.node.Process;
import locale.Locale;
import locale.StringKey;
import storage.LayoutStorage;
import storage.RecentStorage;
import sys.FileSystem;

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
						name: 'Drawing Log',
						extensions: ['drawlog']
					}
				]
			}
		).then(openFiles);
	}
	public static function openFile(path:String):Void
	{
		var path = Path.resolve(path);
		RecentStorage.add(path);
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
				reload(target);
				target.parent.setActiveContentItem(target);
			}
		}
		else
		{
			resolveStack().addChild(LayoutStorage.createFileContent(path));
		}
	}
	private static function resolveStack():ContentItem
	{
		var stack = findStackFromBottom(FocusManager.focusedItem);
		if (stack == null)
		{
			stack = findStackFromTop(Main.goldenLayout.root);
		}
		return stack;
	}
	public static function reload(contentItem:ContentItem):Void
	{
		var id = "player_" + contentItem.config.id;
		var element = Browser.document.getElementById(id);
		var player = Drawlog.getPlayer(element);
		var image:DrawlogImage = Drawlog.getImage(element.getElementsByClassName("drawlog").item(0));
		image.loadFile(untyped contentItem.config.componentState.path);
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
	
	public static function exportSequencialPng():Void
	{
		openExportDialog(
			Locale.get(StringKey.file_filter_sequencial_png),
			"png", 
			"[].png",
			"--png"
		);
	}
	
	public static function exportAnimationPng():Void
	{
		openExportDialog(
			Locale.get(StringKey.file_filter_animation_png),
			"png", 
			".png", 
			"--apng"
		);
	}
	
	public static function exportAnimationGif():Void
	{
		openExportDialog(
			Locale.get(StringKey.file_filter_animation_gif),
			"gif", 
			".gif",
			"--gif"
		);
	}
	
	public static function exportAvi():Void
	{
		openExportDialog(
			Locale.get(StringKey.file_filter_avi_video),
			"avi", 
			".avi",
			"--avi"
		);
	}
	
	private static function openExportDialog(
		filterName:String,
		ext:String, 
		suffix:String,
		option:String
	):Void
	{
		var executable = getExportExecutable();
		var dialog:Dynamic = untyped Remote.dialog;
		if (executable == null)
		{
			showExportError();
			return;
		}
		Browser.console.log("Command `" + executable + "` will be used.");
		var item = FocusManager.focusedItem;
		if (item != null)
		{
			var path = untyped item.config.componentState.path;
			dialog.showSaveDialog(
				Remote.getCurrentWindow(),
				{
					defaultPath: Path.join(Path.dirname(path), Path.basename(path, Path.extname(path)) + suffix),
					properties: ["createDirectory", "showOverwriteConfirmation"],
					filters: [
						{
							name: filterName,
							extensions: [ext], 
						}
					]
				}
			).then(export.bind(path, option));
		}
		else
		{
			dialog.showMessageBox({
				title  : '',
				message: '',
			});	
		}
	}
	private static function showExportError():Void 
	{
		var dialog:Dynamic = untyped Remote.dialog;
		dialog.showMessageBox({
			title  :  Locale.get(StringKey.cli_not_found_title      ),
			message:  Locale.get(StringKey.cli_not_found_description),
			buttons: [	
				Locale.get(StringKey.cli_how_to_install), 
				Locale.get(StringKey.ok_button         ),
			],
		}).then(onExportError);
	}
	private static function onExportError(event:Dynamic):Void 
	{
		if (event.response == 0)
		{
			untyped Remote.shell.openExternal("https://github.com/shohei909/drawing_log_cli");
		}
	}
	private static function export(inputPath:String, option:String, event:Dynamic):Void 
	{
		if (event.canceled) return;
		var exe = getExportExecutable();
		if (exe == null) {
			showExportError();
			return;
		}
		var item = FocusManager.focusedItem;
		var logElement = item.element.get(0).getElementsByClassName("drawlog-log").item(0);
		logElement.innerHTML = "";
		var spawn = ChildProcess.spawn(exe, ["-i", inputPath, option, event.filePath]);
		function log(level:String, message:String):Void {
			var element = Browser.document.createElement("pre");
			element.className = "vi-log-" + level;
			element.textContent = message;
			logElement.append(element);
		}
		log("info", Locale.get(StringKey.export_start));
		
		spawn.stdout.on('data', function (data) {
			log("info", data);
		});
		spawn.stderr.on('data', function (data) {
			log("warn", data);
		});
		spawn.on('close', function (code) {
			var element = Browser.document.createElement("pre");
			if (code == 0) 
			{
				log("info", Locale.get(StringKey.export_succeeded));
			} 
			else 
			{
				log("error", Locale.get(StringKey.export_failed) + " "+ code);
			}
			logElement.append(element);
		});
	}
	
	private static function getExportExecutable():Null<String>
	{
		var name = if (Node.process.platform == "win32") "drawlog.exe" else "drawlog";
		var base = if (untyped Remote.app.isPackaged) 
		{
			Path.join(Path.dirname(untyped Remote.app.getPath("module")), "bin");
		}
		else
		{
			var os = switch (Node.process.platform)
			{
				case 'win32' : "win";
				case 'darwin': "mac";
				case other   : other;
			}
			Path.join(Node.process.cwd(), "bin", os, Node.process.arch);
		}
		var path = Path.join(base, name);
		if (FileSystem.exists(path))
		{
			return path;
		}
		var hasbin = Node.require('hasbin');
		if (hasbin.sync("drawlog")) 
		{
			return "drawlog";
		}
		return null;
	}
}

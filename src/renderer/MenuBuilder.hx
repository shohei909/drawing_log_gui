import electron.Event;
import electron.Shell;
import electron.main.App;
import electron.main.Dialog;
import electron.main.Menu;
import electron.main.MenuItem;
import electron.renderer.Remote;
import js.node.Path;
import operation.FileOperation;
import operation.TabOperation;
import storage.RecentStorage;
import sys.FileSystem;

class MenuBuilder 
{
	public static function updateMenu():Void 
	{
		var template:Array<Dynamic> = [
			{
				label: '&File',
				id: "file",
				role: "fileMenu",
				submenu: ([
					{
						label: '&Open',
						accelerator: 'CommandOrControl+O',
						click: FileOperation.open,
					},
					{
						id: "recent",
						label: 'Re&cent Files',
						submenu: [
							for (path in RecentStorage.history)
							{
								label: path,
								click: function(item, focusedWindow) {
									if (FileSystem.exists(path))
									{
										FileOperation.openFile(path);
									}
									else
									{
										var dialog = untyped Remote.dialog;
										dialog.showMessageBox({
											title: 'File not found',
											message: 'File not found: ' + path,
										});	
										RecentStorage.remove(path);
									}
								},
							}
						],
					},
					{ type: 'separator' },
					{
						label: 'Export &Animation PNG',
						accelerator: 'CommandOrControl+P',
						click: FileOperation.exportAnimationPng,
					},
					{
						label: 'Export &Sequencial PNG',
						accelerator: 'CommandOrControl+Shift+P',
						click: FileOperation.exportSequencialPng,
					},
					{
						label: 'Export Animation &GIF',
						accelerator: 'CommandOrControl+G',
						click: FileOperation.exportAnimationGif,
					},
					{
						label: '&Export AVI Video',
						accelerator: 'CommandOrControl+Shift+A',
						click: FileOperation.exportAvi,
					},
					{ type: 'separator' },
					{
						label: '&Restart',
						click: function(item, focusedWindow) {
							untyped Remote.app.relaunch({});
							untyped Remote.app.exit();
						}
					},
				]:Array<Dynamic>),
			},
			{
				label: '&View',
				id: "file",
				role: "viewMenu",
				submenu: ([
					{
						label: '&Close Tab',
						accelerator: 'CommandOrControl+W',
						click: TabOperation.close,
					},
					{
						label: 'Close &Other Tabs',
						accelerator: 'CommandOrControl+Shift+W',
						click: TabOperation.closeOthers,
					},
					{
						label: 'Close &All Tabs',
						accelerator: 'CommandOrControl+Alt+W',
						click: TabOperation.closeAll,
					},
					{ type: 'separator' },
					{
						label: '&Next Tab',
						accelerator: 'CommandOrControl+Tab',
						click: TabOperation.next,
					},
					{
						label: '&Previous Tab',
						accelerator: 'CommandOrControl+Shift+Tab',
						click: TabOperation.prev,
					},
					{ type: 'separator' },
					{
						label: '&Reload Tab',
						accelerator: 'F5',
						click: TabOperation.reload,
					},
					{ type: 'separator' },
					{
						label: 'Open &Directory',
						accelerator: 'Alt+Shift+R',
						click: function(item, focusedWindow) {
							var item = FocusManager.focusedItem;
							if (item != null && item.isComponent && untyped item.config.componentState.path != null)
							{
								untyped Remote.shell.openPath(Path.dirname(untyped item.config.componentState.path));
							}
						}
					},
					{ type: 'separator' },
					{
						label: 'Zoom &In',
						accelerator: 'CommandOrControl+Plus',
						click: TabOperation.zoomIn,
					},
					{
						label: '&Zoom Out',
						accelerator: 'CommandOrControl+-',
						click: TabOperation.zoomOut,
					},
					{
						label: 'Zoom R&eset',
						accelerator: 'CommandOrControl+0',
						click: TabOperation.zoomReset,
					},
				]:Array<Dynamic>),
			},
			{
				label: '&Help',
				submenu: ([
					{
						label: '&Github Repogitory',
						click: function(item, focusedWindow) {
							untyped Remote.shell.openExternal("https://github.com/shohei909/visual_log_viewer");
						}
					},
					{
						label: '&Online Documentation',
						click: function(item, focusedWindow) {
							untyped Remote.shell.openExternal("http://vilog.corge.net/");
						}
					},
					{
						label: '&Version',
						click: function(item, focusedWindow) {
							var dialog = untyped Remote.dialog;
							dialog.showMessageBox({
								title: 'About Visual Log Viewer',
								message: 'Visual Log Viewer: ' + untyped Remote.app.getVersion()
							});	
						}
					},
					{ type: 'separator' },
					{
						label: '&Open Storage Directory',
						click: function(item, focusedWindow) {
							untyped Remote.shell.openPath(untyped Remote.app.getPath("userData"));
						}
					},
					{
						label: 'Open &Installation Directory',
						click: function(item, focusedWindow) {
							untyped Remote.shell.openPath(Path.dirname(untyped Remote.app.getPath("module")));
						}
					},
					{ type: 'separator' },
					{
						label: '&Toggle Developer Tools',
						accelerator: 'F12',
						role: 'toggleDevTools',
					},
				]:Array<Dynamic>)
			},
		];
		var menu:Menu = untyped Remote.Menu.buildFromTemplate(template);
		
		var currentWindow = Remote.getCurrentWindow();
		currentWindow.setMenu(menu);
	}	
}

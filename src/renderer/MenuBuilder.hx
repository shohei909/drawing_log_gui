import electron.Event;
import electron.Shell;
import electron.main.App;
import electron.main.Dialog;
import electron.main.Menu;
import electron.main.MenuItem;
import electron.renderer.Remote;
import js.node.Path;
import locale.Locale;
import locale.StringKey;
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
				label: Locale.get(StringKey.menu_file),
				id: "file",
				role: "fileMenu",
				submenu: ([
					{
						label: Locale.get(StringKey.menu_file_open),
						accelerator: 'CommandOrControl+O',
						click: FileOperation.open,
					},
					{
						id: "recent",
						label: Locale.get(StringKey.menu_file_recent),
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
						label: Locale.get(StringKey.menu_file_export_apng),
						accelerator: 'CommandOrControl+P',
						click: FileOperation.exportAnimationPng,
					},
					{
						label: Locale.get(StringKey.menu_file_export_png),
						accelerator: 'CommandOrControl+Shift+P',
						click: FileOperation.exportSequencialPng,
					},
					{
						label: Locale.get(StringKey.menu_file_export_gif),
						accelerator: 'CommandOrControl+G',
						click: FileOperation.exportAnimationGif,
					},
					{
						label: Locale.get(StringKey.menu_file_export_avi),
						accelerator: 'CommandOrControl+Shift+A',
						click: FileOperation.exportAvi,
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_file_restart),
						click: function(item, focusedWindow) {
							untyped Remote.app.relaunch({});
							untyped Remote.app.exit();
						}
					},
				]:Array<Dynamic>),
			},
			{
				label: Locale.get(StringKey.menu_view),
				id: "file",
				role: "viewMenu",
				submenu: ([
					{
						label: Locale.get(StringKey.menu_view_close_tab),
						accelerator: 'CommandOrControl+W',
						click: TabOperation.close,
					},
					{
						label: Locale.get(StringKey.menu_view_close_other_tabs),
						accelerator: 'CommandOrControl+Shift+W',
						click: TabOperation.closeOthers,
					},
					{
						label: Locale.get(StringKey.menu_view_close_all_tabs),
						accelerator: 'CommandOrControl+Alt+W',
						click: TabOperation.closeAll,
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_view_next_tab),
						accelerator: 'CommandOrControl+Tab',
						click: TabOperation.next,
					},
					{
						label: Locale.get(StringKey.menu_view_prev_tab),
						accelerator: 'CommandOrControl+Shift+Tab',
						click: TabOperation.prev,
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_view_reload_tab),
						accelerator: 'F5',
						click: TabOperation.reload,
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_view_open_dir),
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
						label: Locale.get(StringKey.menu_view_zoom_in),
						accelerator: 'CommandOrControl+Plus',
						click: TabOperation.zoomIn,
					},
					{
						label: Locale.get(StringKey.menu_view_zoom_out),
						accelerator: 'CommandOrControl+-',
						click: TabOperation.zoomOut,
					},
					{
						label: Locale.get(StringKey.menu_view_zoom_reset),
						accelerator: 'CommandOrControl+0',
						click: TabOperation.zoomReset,
					},
				]:Array<Dynamic>),
			},
			{
				label: Locale.get(StringKey.menu_help),
				submenu: ([
					{
						label: Locale.get(StringKey.menu_help_github),
						click: function(item, focusedWindow) {
							untyped Remote.shell.openExternal("https://github.com/shohei909/drawing_log_gui");
						}
					},
					{
						label: Locale.get(StringKey.menu_help_doc),
						click: function(item, focusedWindow) {
							untyped Remote.shell.openExternal("http://drawlog.corge.net/");
						}
					},
					{
						label: Locale.get(StringKey.menu_help_ver),
						click: function(item, focusedWindow) {
							var dialog = untyped Remote.dialog;
							dialog.showMessageBox({
								title: Locale.get(StringKey.help_title),
								message: 'Drawing Log GUI: ' + untyped Remote.app.getVersion()
							});	
						}
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_help_storage_dir),
						click: function(item, focusedWindow) {
							untyped Remote.shell.openPath(untyped Remote.app.getPath("userData"));
						}
					},
					{
						label: Locale.get(StringKey.menu_help_install_dir),
						click: function(item, focusedWindow) {
							untyped Remote.shell.openPath(Path.dirname(untyped Remote.app.getPath("module")));
						}
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_help_devtools),
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

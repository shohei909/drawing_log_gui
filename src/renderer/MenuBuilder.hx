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
import operation.BulkOperation;
import operation.TabOperation;
import setting.KeyConfig;
import setting.KeyConfigKey;
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
						accelerator: KeyConfig.get(KeyConfigKey.file_open),
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
						accelerator: KeyConfig.get(KeyConfigKey.file_export_apng),
						click: FileOperation.exportAnimationPng,
					},
					{
						label: Locale.get(StringKey.menu_file_export_png),
						accelerator: KeyConfig.get(KeyConfigKey.file_export_png),
						click: FileOperation.exportSequencialPng,
					},
					{
						label: Locale.get(StringKey.menu_file_export_gif),
						accelerator: KeyConfig.get(KeyConfigKey.file_export_gif),
						click: FileOperation.exportAnimationGif,
					},
					{
						label: Locale.get(StringKey.menu_file_export_avi),
						accelerator: KeyConfig.get(KeyConfigKey.file_export_avi),
						click: FileOperation.exportAvi,
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_file_restart),
						accelerator: KeyConfig.get(KeyConfigKey.file_restart),
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
						accelerator: KeyConfig.get(KeyConfigKey.view_close_tab),
						click: TabOperation.close,
					},
					{
						label: Locale.get(StringKey.menu_view_close_other_tabs),
						accelerator: KeyConfig.get(KeyConfigKey.view_close_other_tabs),
						click: TabOperation.closeOthers,
					},
					{
						label: Locale.get(StringKey.menu_view_close_all_tabs),
						accelerator: KeyConfig.get(KeyConfigKey.view_close_all_tabs),
						click: TabOperation.closeAll,
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_view_next_tab),
						accelerator: KeyConfig.get(KeyConfigKey.view_next_tab),
						click: TabOperation.next,
					},
					{
						label: Locale.get(StringKey.menu_view_prev_tab),
						accelerator: KeyConfig.get(KeyConfigKey.view_prev_tab),
						click: TabOperation.prev,
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_view_reload_tab),
						accelerator: KeyConfig.get(KeyConfigKey.view_reload_tab),
						click: TabOperation.reload,
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_view_open_dir),
						accelerator: KeyConfig.get(KeyConfigKey.view_open_dir),
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
						accelerator: KeyConfig.get(KeyConfigKey.view_zoom_in),
						click: TabOperation.zoomIn,
					},
					{
						label: Locale.get(StringKey.menu_view_zoom_out),
						accelerator: KeyConfig.get(KeyConfigKey.view_zoom_out),
						click: TabOperation.zoomOut,
					},
					{
						label: Locale.get(StringKey.menu_view_zoom_reset),
						accelerator: KeyConfig.get(KeyConfigKey.view_zoom_reset),
						click: TabOperation.zoomReset,
					},
				]:Array<Dynamic>),
			},
			{
				label: Locale.get(StringKey.menu_bulk),
				id: "file",
				role: "viewMenu",
				submenu: ([
					{
						label: Locale.get(StringKey.menu_bulk_play),
						accelerator: KeyConfig.get(KeyConfigKey.bulk_play),
						click: BulkOperation.togglePlay,
					},
					{
						label: Locale.get(StringKey.menu_bulk_backward),
						accelerator: KeyConfig.get(KeyConfigKey.bulk_backward),
						click: BulkOperation.fastBackward,
					},
					{
						label: Locale.get(StringKey.menu_bulk_forward),
						accelerator: KeyConfig.get(KeyConfigKey.bulk_forward),
						click: BulkOperation.fastForward,
					},
					{
						label: Locale.get(StringKey.menu_bulk_back_step),
						accelerator: KeyConfig.get(KeyConfigKey.bulk_back_step),
						click: BulkOperation.stepBackward,
					},
					{
						label: Locale.get(StringKey.menu_bulk_fore_step),
						accelerator: KeyConfig.get(KeyConfigKey.bulk_fore_step),
						click: BulkOperation.stepForward,
					},
					{
						label: Locale.get(StringKey.menu_bulk_back_fast_step),
						accelerator: KeyConfig.get(KeyConfigKey.bulk_back_fast_step),
						click: BulkOperation.stepFastBackward,
					},
					{
						label: Locale.get(StringKey.menu_bulk_fore_fast_step),
						accelerator: KeyConfig.get(KeyConfigKey.bulk_fore_fast_step),
						click: BulkOperation.stepFastForward,
					},
				]:Array<Dynamic>),
			},
			{
				label: Locale.get(StringKey.menu_help),
				submenu: ([
					{
						label: Locale.get(StringKey.menu_help_github),
						submenu: ([
							{
								label: Locale.get(StringKey.menu_help_github_gui),
								click: function(item, focusedWindow) {
									untyped Remote.shell.openExternal("https://github.com/shohei909/drawing_log_gui");
								}
							},
							{
								label: Locale.get(StringKey.menu_help_github_cli),
								click: function(item, focusedWindow) {
									untyped Remote.shell.openExternal("https://github.com/shohei909/drawing_log_cli");
								}
							},
						])
					},
					{
						label: Locale.get(StringKey.menu_help_doc),
						accelerator: KeyConfig.get(KeyConfigKey.help_doc),
						click: function(item, focusedWindow) {
							untyped Remote.shell.openExternal("http://drawlog.corge.net/");
						}
					},
					{
						label: Locale.get(StringKey.menu_help_playground),
						accelerator: KeyConfig.get(KeyConfigKey.help_doc),
						click: function(item, focusedWindow) {
							untyped Remote.shell.openExternal("http://drawlog.corge.net/playground");
						}
					},
					{
						label: Locale.get(StringKey.menu_help_ver),
						accelerator: KeyConfig.get(KeyConfigKey.help_ver),
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
						accelerator: KeyConfig.get(KeyConfigKey.help_storage_dir),
						click: function(item, focusedWindow) {
							untyped Remote.shell.openPath(untyped Remote.app.getPath("userData"));
						}
					},
					{
						label: Locale.get(StringKey.menu_help_install_dir),
						accelerator: KeyConfig.get(KeyConfigKey.help_install_dir),
						click: function(item, focusedWindow) {
							untyped Remote.shell.openPath(Path.dirname(untyped Remote.app.getPath("module")));
						}
					},
					{ type: 'separator' },
					{
						label: Locale.get(StringKey.menu_help_devtools),
						accelerator: KeyConfig.get(KeyConfigKey.help_devtools),
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

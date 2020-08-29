import electron.main.Menu;
import electron.renderer.Remote;

class MenuBuilder 
{
	public static function build():Menu
	{
		var template:Array<Dynamic> = [
			{
				label: '&File',
				submenu: [
					{
						label: '&Open',
						accelerator: 'CommandOrControl+O',
						click: FileOperation.open,
					},
					{
						label: '&Export',
						accelerator: 'CommandOrControl+E',
						click: FileOperation.export,
					},
				],
			},
			{
				label: '&View',
				submenu: [
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
				],
			},
			{
				label: '&Help',
				submenu: [
					{
						label: '&Toggle Developer Tools',
						accelerator: 'F12',
						click: function(item, focusedWindow) {
							if (focusedWindow != null) focusedWindow.webContents.toggleDevTools();
						}
					},
				]
			},
		];
		var menu = untyped Remote.Menu.buildFromTemplate(template);
		return menu;
	}	
}

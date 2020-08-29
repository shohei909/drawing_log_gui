import electron.main.Menu;
import electron.renderer.Remote;

class MenuBuilder 
{
	public static function build():Menu
	{
		var template:Array<haxe.extern.EitherType<Dynamic, Dynamic>> = [
			{
				label: '&File',
				submenu: [
					{
						label: '&Open',
						accelerator: 'CommandOrControl+O',
					},
					{
						label: '&Export',
						accelerator: 'CommandOrControl+E',
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

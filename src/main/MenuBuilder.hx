import electron.main.Menu;

class MenuBuilder 
{
	public static function build():Menu
	{
		var template:Array<haxe.extern.EitherType<Dynamic, Dynamic>> = [
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
		var menu = Menu.buildFromTemplate(template);
		return menu;
	}	
}

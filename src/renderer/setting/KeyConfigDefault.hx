package setting;
import setting.KeyConfigKey;

class KeyConfigDefault 
{	
	public static function resolve(key:KeyConfigKey):String
	{
		return switch (key)
		{
			case KeyConfigKey.file_open               : 'CommandOrControl+O';
			case KeyConfigKey.file_export_apng        : 'CommandOrControl+P';
			case KeyConfigKey.file_export_png         : 'CommandOrControl+Shift+P';
			case KeyConfigKey.file_export_gif         : 'CommandOrControl+G';
			case KeyConfigKey.file_export_avi         : 'CommandOrControl+Shift+A';
			case KeyConfigKey.file_restart            : "";
			case KeyConfigKey.view_close_tab          : 'CommandOrControl+W';
			case KeyConfigKey.view_close_other_tabs   : 'CommandOrControl+Shift+W';
			case KeyConfigKey.view_close_all_tabs     : 'CommandOrControl+Alt+W';
			case KeyConfigKey.view_next_tab           : 'CommandOrControl+Tab';
			case KeyConfigKey.view_prev_tab           : 'CommandOrControl+Shift+Tab';
			case KeyConfigKey.view_reload_tab         : 'F5';
			case KeyConfigKey.view_open_dir           : 'Alt+Shift+R';
			case KeyConfigKey.view_zoom_in            : 'CommandOrControl+Plus';
			case KeyConfigKey.view_zoom_out           : 'CommandOrControl+-';
			case KeyConfigKey.view_zoom_reset         : 'CommandOrControl+0';
			case KeyConfigKey.bulk_play               : 'CommandOrControl+Space';
			case KeyConfigKey.bulk_backward           : 'CommandOrControl+Shift+Left';
			case KeyConfigKey.bulk_forward            : 'CommandOrControl+Shift+Right';
			case KeyConfigKey.bulk_back_step          : 'CommandOrControl+Left';
			case KeyConfigKey.bulk_fore_step          : 'CommandOrControl+Right';
			case KeyConfigKey.bulk_back_fast_step     : 'CommandOrControl+PageUp';
			case KeyConfigKey.bulk_fore_fast_step     : 'CommandOrControl+PageDown';
			case KeyConfigKey.help_doc                : "";
			case KeyConfigKey.help_ver                : "";
			case KeyConfigKey.help_storage_dir        : "";
			case KeyConfigKey.help_install_dir        : "";
			case KeyConfigKey.help_devtools           : 'F12';
		}
	}
}

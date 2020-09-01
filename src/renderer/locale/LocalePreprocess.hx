package locale;
import haxe.Json;
import locale.StringKey;
import sys.io.File;
import tool.AbstractEnumTools;

class LocalePreprocess 
{
	public static function main():Void
	{
		// English
		var en:Map<StringKey, String> = [
			for (key in AbstractEnumTools.getValues(StringKey))
			{
				key => switch (key)
				{
					case menu_file                    : "&File";
					case menu_file_open               : "&Open";
					case menu_file_recent             : "Re&cent Files";
					case menu_file_export_apng        : "Export &Animation PNG";
					case menu_file_export_png         : "Export &Sequencial PNG";
					case menu_file_export_gif         : "Export Animation &GIF";
					case menu_file_export_avi         : "Export A&VI Video";
					case menu_file_restart            : "&Restart";
					case menu_view                    : "&View";
					case menu_view_close_tab          : "&Close Tab";
					case menu_view_close_other_tabs   : "Close &Other Tabs";
					case menu_view_close_all_tabs     : "Close &All Tabs";
					case menu_view_next_tab           : "&Next Tab";
					case menu_view_prev_tab           : "&Previous Tab";
					case menu_view_reload_tab         : "&Reload Tab";
					case menu_view_open_dir           : "Open &Parent Directory";
					case menu_view_zoom_in            : "Zoom &In";
					case menu_view_zoom_out           : "&Zoom Out";
					case menu_view_zoom_reset         : "Zoom &Reset";
					case menu_help                    : "&Help";
					case menu_help_github             : "&Github Repository";
					case menu_help_doc                : "&Online Documentaion";
					case menu_help_ver                : "&Version";
					case menu_help_storage_dir        : "&Storage Directory";
					case menu_help_install_dir        : "&Installation Directory";
					case menu_help_devtools           : "&Toggle Developper Tools";
				}
			}
		];
		File.saveContent("bin/locale/en.json", Json.stringify(en, null, "\t"));
		
		// Japanese
		
		var ja:Map<StringKey, String> = [
			for (key in AbstractEnumTools.getValues(StringKey))
			{
				key => switch (key)
				{
					case menu_file                    : "ファイル(&F)";
					case menu_file_open               : "開く(&O)";
					case menu_file_recent             : "最近開いたファイル(&C)";
					case menu_file_export_apng        : "アニメーションPNGを出力(&A)";
					case menu_file_export_png         : "連番PNGを出力(&S)";
					case menu_file_export_gif         : "アニメーション&GIFを出力";
					case menu_file_export_avi         : "A&VI動画を出力";
					case menu_file_restart            : "再起動(&R)";
					case menu_view                    : "表示(&V)";
					case menu_view_close_tab          : "タブを閉じる(&C)";
					case menu_view_close_other_tabs   : "他のタブを閉じる(&O)";
					case menu_view_close_all_tabs     : "すべてのタブを閉じる(&A)";
					case menu_view_next_tab           : "次のタブ(&N)";
					case menu_view_prev_tab           : "前のタブ(&P)";
					case menu_view_reload_tab         : "タブを再読み込み(&R)";
					case menu_view_open_dir           : "親ディレクトリを開く(&P)";
					case menu_view_zoom_in            : "拡大(&I)";
					case menu_view_zoom_out           : "縮小(&Z)";
					case menu_view_zoom_reset         : "拡縮をリセット(&R)";
					case menu_help                    : "ヘルプ(&H)";
					case menu_help_github             : "&Github レポジトリ";
					case menu_help_doc                : "オンラインドキュメント(&O)";
					case menu_help_ver                : "バージョン(&V)";
					case menu_help_storage_dir        : "アプリケーションフォルダを開く(&S)";
					case menu_help_install_dir        : "インストールフォルダを開く(&I)";
					case menu_help_devtools           : "デベロッパー ツール(&T)";
				}
			}
		];
		File.saveContent("bin/locale/ja.json", Json.stringify(ja, null, "\t"));
	}
}

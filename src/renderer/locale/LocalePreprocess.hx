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
					case menu_help_github_cli         : "Drawing Log &CLI";
					case menu_help_github_gui         : "Drawing Log &GUI";
					case menu_help_doc                : "&Online Documentaion";
					case menu_help_playground         : "&Playground";
					case menu_help_ver                : "&Version";
					case menu_help_storage_dir        : "&Storage Directory";
					case menu_help_install_dir        : "&Installation Directory";
					case menu_help_devtools           : "&Toggle Developper Tools";
					case menu_bulk                    : "&Bulk Action";
					case menu_bulk_play               : "&Play/Stop";
					case menu_bulk_backward           : "&Rewind";
					case menu_bulk_forward            : "&Fast Forward";
					case menu_bulk_back_step          : "Step B&ackward";
					case menu_bulk_fore_step          : "&Step Forward";
					case menu_bulk_back_fast_step     : "10 Steps Ba&ckward";
					case menu_bulk_fore_fast_step     : "&10 Steps Forward";
					
					case help_title                   : "About Drawing Log GUI";
					
					case file_filter_animation_gif  : 'Animation GIF image';
					case file_filter_animation_png  : 'Animation PNG image';
					case file_filter_sequencial_png : 'Sequencial PNG image';
					case file_filter_avi_video      : 'AVI Video';
					
					case no_file_title              : 'No file is selected';
					case no_file_description        : 'No file is selected';
					case cli_not_found_title        : 'Command Not Found Error';
					case cli_not_found_description  : "`drawlog` command is not found.";
					case cli_how_to_install         : "How to install Drawing Log CLI";
					case ok_button                  : "OK";
					
					case export_start               : "Exporting...";
					case export_succeeded           : "Export succeeded!";
					case export_failed              : "Export failed:";
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
					case menu_file_export_apng        : "アニメーション PNG を出力(&A)";
					case menu_file_export_png         : "連番 PNG を出力(&S)";
					case menu_file_export_gif         : "アニメーション &GIF を出力";
					case menu_file_export_avi         : "A&VI 動画を出力";
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
					case menu_help_github_cli         : "Drawing Log &CLI";
					case menu_help_github_gui         : "Drawing Log &GUI";
					case menu_help_doc                : "オンラインドキュメント(&O)";
					case menu_help_playground         : "プレイグラウンド(&P)";
					case menu_help_ver                : "バージョン(&V)";
					case menu_help_storage_dir        : "アプリケーションフォルダを開く(&S)";
					case menu_help_install_dir        : "インストールフォルダを開く(&I)";
					case menu_help_devtools           : "デベロッパー ツール(&T)";
					case menu_bulk                    : "一括操作(&P)";
					case menu_bulk_play               : "再生/停止(&P)";
					case menu_bulk_backward           : "巻き戻し";
					case menu_bulk_forward            : "早送り";
					case menu_bulk_back_step          : "1つ戻す";
					case menu_bulk_fore_step          : "1つ進む";
					case menu_bulk_back_fast_step     : "10戻す";
					case menu_bulk_fore_fast_step     : "10進む";
					
					case help_title                   : "Drawing Log GUI について";
					
					case file_filter_animation_gif  : 'アニメーション GIF 画像';
					case file_filter_animation_png  : 'アニメーション PNG 画像';
					case file_filter_sequencial_png : '連番 PNG 画像';
					case file_filter_avi_video      : 'AVI 動画';
					
					case no_file_title              : 'No file is selected';
					case no_file_description        : 'ファイルが選択されていません';
					
					case cli_not_found_title        : 'Command Not Found Error';
					case cli_not_found_description  : "`drawlog` コマンドが見つかりません";
					case cli_how_to_install         : "Drawing Log CLIのインストール方法";
					case ok_button                  : "OK";
					
					case export_start               : "出力中...";
					case export_succeeded           : "出力成功!";
					case export_failed              : "出力失敗:";
				}
			}
		];
		File.saveContent("bin/locale/ja.json", Json.stringify(ja, null, "\t"));
	}
}

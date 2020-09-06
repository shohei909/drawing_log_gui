package locale;

@:enum abstract StringKey(String) 
{
	var menu_file                    ;
	var menu_file_open               ;
	var menu_file_recent             ;
	var menu_file_export_apng        ;
	var menu_file_export_png         ;
	var menu_file_export_gif         ;
	var menu_file_export_avi         ;
	var menu_file_restart            ;
	var menu_view                    ;
	var menu_view_close_tab          ;
	var menu_view_close_other_tabs   ;
	var menu_view_close_all_tabs     ;
	var menu_view_next_tab           ;
	var menu_view_prev_tab           ;
	var menu_view_reload_tab         ;
	var menu_view_open_dir           ;
	var menu_view_zoom_in            ;
	var menu_view_zoom_out           ;
	var menu_view_zoom_reset         ;
	var menu_help                    ;
	var menu_help_github             ;
	var menu_help_github_cli         ;
	var menu_help_github_gui         ;
	var menu_help_doc                ;
	var menu_help_playground         ;
	var menu_help_ver                ;
	var menu_help_storage_dir        ;
	var menu_help_install_dir        ;
	var menu_help_devtools           ;
	var menu_bulk                    ;
	var menu_bulk_play               ;
	var menu_bulk_backward           ;
	var menu_bulk_forward            ;
	var menu_bulk_back_step          ;
	var menu_bulk_fore_step          ;
	var menu_bulk_back_fast_step     ;
	var menu_bulk_fore_fast_step     ;
	
	var help_title                   ;
	
	var file_filter_animation_png    ;
	var file_filter_animation_gif    ;
	var file_filter_sequencial_png   ;
	var file_filter_avi_video        ;
	
	var no_file_title                ;
	var no_file_description          ;
	var cli_not_found_title          ;
	var cli_not_found_description    ;
	var cli_how_to_install           ;
	var ok_button                    ;
	var export_start                 ;
	var export_succeeded             ;
	var export_failed                ;
	
}
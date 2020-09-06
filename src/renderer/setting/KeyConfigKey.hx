package setting;

@:enum abstract KeyConfigKey(String) 
{
	var file_open               ;
	var file_export_apng        ;
	var file_export_png         ;
	var file_export_gif         ;
	var file_export_avi         ;
	var file_restart            ;
	var view_close_tab          ;
	var view_close_other_tabs   ;
	var view_close_all_tabs     ;
	var view_next_tab           ;
	var view_prev_tab           ;
	var view_reload_tab         ;
	var view_open_dir           ;
	var view_zoom_in            ;
	var view_zoom_out           ;
	var view_zoom_reset         ;
	var bulk_play               ;
	var bulk_backward           ;
	var bulk_forward            ;
	var bulk_back_step          ;
	var bulk_fore_step          ;
	var bulk_back_fast_step     ;
	var bulk_fore_fast_step     ;
	var help_doc                ;
	var help_ver                ;
	var help_storage_dir        ;
	var help_install_dir        ;
	var help_devtools           ;
}

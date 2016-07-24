/**
 * Create by GeekCarnegie On 2015-08-13
 */


jQuery(document).ready(function() {
	"use strict";
	
	//Page Preloader
	jQuery("#preloader_simulation").delay(3000).fadeOut(function() {
		jQuery("#contentpanel_func_4").delay(1000).css({
			"overflow" : "visible"
		});
	});
	
	//Tooltip
	jQuery('.tooltips').tooltip({
		container : 'body'
	});
});
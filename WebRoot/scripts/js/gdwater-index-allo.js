/**
 * Create by GeekCarnegie On 2015-06-07
 */

/****************** Variable ******************/
/* 1.pollutiontype[] 污染类型数组 */
/* 2.indexname[] 指标名称数组 */
/* 3.selectedIndex[] 用户自定义分配污染类型指标数组 */
/**********************************************/

/****************** Function ******************/
/* 1.getAllPollutionType 获取污染类型库中所有的污染类型 */
/* 2.getAllIndexAllo 获取指标库中所有的指标 */
/* 3.getCheckedIndexAllo 获取用户自定义的污染类型指标 */
/** ******************************************* */
var pollutiontype = new Array();
var indexname = new Array();
var selectedIndex = new Array();

jQuery(document)
		.ready(
				function() {
					"use strict";

					// Page Preloader
					jQuery('#preloader_index_allo').delay(3000).fadeOut(
							function() {
								jQuery("#contentpanel_func_1_2").delay(1000)
										.css({
											"overflow" : "visible"
										});
							});					

					// Tooltip
					jQuery(".tooltips").tooltip({
						container : "body"
					});
					
					// Select2
					jQuery("#select_pollutiontype").select2({
						width : '100%',
						minimumResultsForSearch : -1
					});

					// Close Button in Panels
					jQuery('.panel .panel-close').click(function() {
						jQuery(this).closest('.panel').fadeOut(200);
						return false;
					});

					// Minimize Button in Panels
					jQuery('.minimize').click(
							function() {
								var t = jQuery(this);
								var p = t.closest('.panel');
								if (!jQuery(this).hasClass('maximize')) {
									p.find('.panel-body, .panel-footer')
											.slideUp(200);
									t.addClass('maximize');
									t.html('&plus;');
								} else {
									p.find('.panel-body, .panel-footer')
											.slideDown(200);
									t.removeClass('maximize');
									t.html('&minus;');
								}
								return false;
							});


					getAllPollutionType();

					getAllIndexAllo();

					jQuery("#select_pollutiontype").on("change", function(e) {
						if (!e) {
							return ;
						} else {
							var data = jQuery(this).select2("data").text;
							getCheckedIndexAllo(data);
						}
					});					
					

					// 确定index panel的高度
					var index_panel_height = jQuery("#index_panel > div:eq(0)")
							.height();
					jQuery("#index_panel").css("height",
							index_panel_height + 40);

					jQuery("#save_checked_index")
							.on("click", saveSelectedIndex);

				});

/**
 * 获取污染类型库中所有的污染类型
 * 
 * @returns {Void}
 */
function getAllPollutionType() {
	pollutiontype = new Array();
	jQuery("#select_pollutiontype").empty();

	jQuery.ajax({
		type : "POST",
		url : "GdWaterServlet",
		async : false,
		context : this,
		data : {
			servicename : "index-db-service",
			servicetype : "get-all-pollution-type"
		},
		success : function(data) {
			if (data.success_get_all_pollution_type) {
				var len = data.pollutiontypeall.length;
				pollutiontype = data.pollutiontypeall;
				
				jQuery("#select_pollutiontype").append("<option></option>");
				
				for (var i = 0; i < len; i++) {
					var option = "<option value='" + pollutiontype[i] + "'>"
							+ pollutiontype[i] + "</option>";
					
					jQuery("#select_pollutiontype").append(option);
				}
			}
		},
		error : function(e) {
			jQuery.gritter.add({
				title : "警告",
				text : "异常错误",
				class_name : "growl-danger",
				image : "images/screen.png",
				sticky : false,
				time : 5000
			});
		},
		dataType : "json"
	});
}

/**
 * 获取指标库中所有的指标
 * 
 * @returns {Void}
 */
function getAllIndexAllo() {
	jQuery.ajax({
		type : "POST",
		url : "GdWaterServlet",
		async : false,
		context : this,
		data : {
			servicename : "index-db-service",
			servicetype : "get-all-index"
		},
		success : function(data) {
			if (data.success_get_all_index) {
				// 指标库所有指标记录长度
				var len = data.index_list.length;
				
			    for (var i=0; i<len; i++) {
			    	indexname[i] = data.index_list[i].indexName;
			    	var check_primary = "<div class='ckbox ckbox-primary'>"
						+ "<input type='checkbox' id='checkbox_" + i
						+ "'><label for='checkbox_" + i + "'>" + indexname[i]
						+ "</label></div>";
			    	if (i % 4 === 0) {
			    		jQuery("#index_container").children("div:eq(0)").append(check_primary);
			    	} else if (i % 4 === 1) {
			    		jQuery("#index_container").children("div:eq(1)").append(check_primary);
			    	} else if (i % 4 === 2) {
			    		jQuery("#index_container").children("div:eq(2)").append(check_primary);
			    	} else {
			    		jQuery("#index_container").children("div:eq(3)").append(check_primary);
			    	}		    				    	
			    }
			    
			    var height = (parseInt(len/4)+1) * 30;
		    	jQuery("#index_container").css("height", height);
			}
		},
		error : function(e) {
			jQuery.gritter.add({
				title : "警告",
				text : "异常错误",
				class_name : "growl-danger",
				image : "images/screen.png",
				sticky : false,
				time : 5000
			});
		},
		dataType : "json"
	});
}

/**
 * 获取用户自定义的污染类型指标
 * 
 * 
 * @param {String}
 *             pollution_type 污染类型
 * 
 * @returns {Void}
 */
function getCheckedIndexAllo(pollution_type) {
	for (var i=0; i<indexname.length; i++) {
		jQuery("#checkbox_" + i).attr("checked",false);
	}
		
	jQuery.ajax({
		type : "POST",
		url : "GdWaterServlet",
		context : this,
		data : {
			servicename : "index-db-service",
			servicetype : "get-checked-index",
			pollutiontype : pollution_type
		},
		success : function(data) {
			if (data.success_get_checked_index) {
				// 用户自定义选择的指标记录长度
				var len = data.selectedindex.length;
				var dataset = data.selectedindex;
				var indexset = new Array();
				var count = 0;
				
				for (var i=0; i<len; i++) {
					var index_name_return = dataset[i][1];
					var pollution_type_return = dataset[i][2];
					
					if (pollution_type === pollution_type_return) {
						indexset[count] = index_name_return;
						count ++;
					}
				}
				
				for (var i=0; i<indexset.length; i++) {
					var tmp = indexname.indexOf(indexset[i]);
					jQuery("#checkbox_" + tmp).attr("checked", true);
				}
			}
		},
		error : function(e) {
			jQuery.gritter.add({
				title : "警告",
				text : "异常错误",
				class_name : "growl-danger",
				image : "images/screen.png",
				sticky : false,
				time : 5000
			});
		},
		dataType : "json"
	});
}

/**
 * 保存用户自定义的污染类型指标
 * 
 * 
 * @returns {Void}
 */
function saveSelectedIndex() {
	selectedIndex = [];
	var curpollutiontype = jQuery("#select_pollutiontype").select2("data").text;
	if (curpollutiontype === null) {
		jQuery.gritter.add({
			title : "系统消息",
			text : "请选定一个污染类型",
			class_name : "growl-warning",
			image : "images/screen.png",
			sticky : false,
			time : 2000
		});
		
		return ;
	}
	
	jQuery("#index_container input[type='checkbox']").each(function() {
		var c = jQuery(this);
		if (c.attr("checked")) {
			var row = parseInt(c.attr("id").toString().split("_")[1]) - 1;
			var index_name = indexname[row];
			selectedIndex.push(index_name);
		}
	});

	jQuery.ajax({
		type : "POST",
		url : "GdWaterServlet",
		context : this,
		data : {
			servicename : "index-db-service",
			servicetype : "save-selected-index",
			"selectedindex[]" : selectedIndex,
			pollutiontype: curpollutiontype
		},
		success : function(data) {
			if (data.success_save_selected_index) {
				jQuery.gritter.add({
					title : "系统消息",
					text : "保存成功",
					class_name : "growl-success",
					image : "images/screen.png",
					sticky : false,
					time : 5000
				});
			}
		},
		error : function(e) {
			jQuery.gritter.add({
				title : "警告",
				text : "异常错误",
				class_name : "growl-danger",
				image : "images/screen.png",
				sticky : false,
				time : 5000
			});
		},
		dataType : "json"
	});
}
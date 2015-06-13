/**
 * Create by GeekCarnegie On 2015-06-07
 */

/****************** Variable ******************/
/* 1.indexName[] 指标库指标名称数组 */
/* 2.indexType[] 指标库指标类型数组 */
/**********************************************/

/****************** Function ******************/
/* 1.getAllIndex 获取指标库中所有的指标 */
/* 2.getCheckedIndex 获取用户自定义选择的指标 */
/* 3.drawAllIndex 列出所有指标，供用户自定义选择 */
/** ******************************************* */

var indexName = new Array();
var indexType = new Array();

jQuery(document).ready(function() {
	"use strict";

	// Page Preloader
	jQuery('#preloader_index_allo').delay(1000).fadeOut(function() {
		jQuery("#contentpanel_func_1_2").delay(1000).css({
			"overflow" : "visible"
		});
	});

	getAllIndex();

	getCheckedIndex();

	// 确定index panel的高度
	var index_panel_height = jQuery("#index_panel > div:eq(0)").height();
	jQuery("#index_panel").css("height", index_panel_height + 40);

	jQuery("#save_checked_index").click(function() {
		// 用户选择的指标名称数组
		var index_name_select = new Array();
		// 用户选择的指标类型数组
		var index_type_select = new Array();
		// 用户选择指标记录长度算子
		var count = 0;

		jQuery("input[type='checkbox']:checked").each(function() {
			var c = jQuery(this);
			// 用户选择指标的标签内容
			var entry = c.next().text();
			// 用户选择的指标名称
			var c_index_name_select = entry.split('[')[0];
			// 用户选择的指标类型
			var c_index_type_select = entry.split('[')[1].split(']')[0];

			index_name_select[count] = c_index_name_select;
			index_type_select[count] = c_index_type_select;
			count++;
		});

		if (count == 0) {
			index_name_select = {};
			index_type_select = {};
		}

		if (count != 0) {
			jQuery.ajax({
				type : "POST",
				url : "GdWaterServlet",
				context : this,
				data : {
					servicename : "index-db-service",
					servicetype : "save-selected-index",
					"index_type_select[]" : index_type_select,
					"index_name_select[]" : index_name_select
				},
				success : function(data) {
					if (data.success_save_selected_index) {
						jQuery.gritter.add({
							title : "系统消息",
							text : data.message_save_selected_index,
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
		} else {
			jQuery.gritter.add({
				title : "警告",
				text : "尚未选择指标！",
				class_name : "growl-warning",
				image : "images/screen.png",
				sticky : false,
				time : 5000
			});
		}
	});
});

/**
 * 获取指标库中所有的指标
 * 
 * @returns {Void}
 */
function getAllIndex() {
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

				for (var i = 0; i < len; i++) {
					indexName[i] = data.index_list[i].indexName;
					indexType[i] = data.index_list[i].indexType;
				}

				drawAllIndex(len);
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
 * 获取用户自定义选择的指标
 * 
 * @returns {Void}
 */
function getCheckedIndex() {
	jQuery.ajax({
		type : "POST",
		url : "GdWaterServlet",
		context : this,
		data : {
			servicename : "index-db-service",
			servicetype : "get-checked-index"
		},
		success : function(data) {
			if (data.success_get_checked_index) {
				// 用户自定义选择的指标记录长度
				var len = data.dataset_checked_index.length;

				for (var i = 0; i < len; i++) {
					// 用户自定义选择的指标id
					var index_id = data.dataset_checked_index[i][0];
					// 用户自定义选择的指标名称
					var index_name = data.dataset_checked_index[i][1];
					// 用户自定义选择的指标类型
					var index_type = data.dataset_checked_index[i][2];

					var filter = index_name + "[" + index_type + "]";

					jQuery("input[type='checkbox']").each(function() {
						var c = jQuery(this);
						var entry = c.next().text();

						if (entry === filter) {
							c.attr("checked", true);
						}
					});
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
 * 列出所有指标，供用户自定义选择
 * 
 * @param {int}
 * 			  count 指标记录条数
 * 
 * @returns {Void}
 */
function drawAllIndex(count) {
	for (var i = 0; i < count; i++) {
		var check_primary = "<div class='ckbox ckbox-primary'>"
				+ "<input type='checkbox' id='checkbox_" + i
				+ "'><label for='checkbox_" + i + "'>" + indexName[i] + "["
				+ indexType[i] + "]</label></div>";

		if (i % 3 === 0) {
			jQuery("#index_panel > div:eq(0)").append(check_primary);
		} else if (i % 3 === 1) {
			jQuery("#index_panel > div:eq(1)").append(check_primary);
		} else if (i % 3 === 2) {
			jQuery("#index_panel > div:eq(2)").append(check_primary);
		}
	}
}
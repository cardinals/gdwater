/**
 * Create by GeekCarnegie On 2015-05-26
 */

/****************** Variable ******************/
/* 1.indexName[] 指标库指标名称数组 */
/* 2.indexType[] 指标库指标类型数组 */
/* 3.searchIndexName[] 搜索栏搜索的全部指标名称数组  */
/* 4.searchIndexType[] 搜索栏搜索的全部指标类型数组 */
/**********************************************/

/****************** Function ******************/
/* 1.getAllIndex 获取指标库中所有的指标 */
/* 2.deleteCheckedIndex 删除选中指标 */
/* 3.drawPaginationAllIndex 绘制分页(指标库中所有指标) */
/* 4.drawPaginationStyleAllIndex 绘制分页样式(指标库中所有指标) */
/* 5.drawDataTableAllIndex 根据分页信息，动态绘制数据表(指标库中所有指标) */
/* 6.drawAllIndexList 绘制指标列表 (指标库中所有指标) */
/** ******************************************* */

var indexName = new Array();
var indexType = new Array();
var searchIndexName = new Array();
var searchIndexType = new Array();

jQuery(document).ready(function() {
	"use strict";

	// Page Preloader
	jQuery("#preloader_index_mana").delay(1000).fadeOut(function() {
		jQuery("#contentpanel_func_1_1").delay(1000).css({
			"overflow" : "visible"
		});
	});

	// Tooltip
	jQuery(".tooltips").tooltip({
		container : "body"
	});

	// Index Remove Button 'Click' Event
	jQuery(".index_button_remove").click(function() {
		jQuery("input[type='checkbox']:checked").each(function() {
			var c = jQuery(this);
			var check_id = c.attr("id");
			var index_type = check_id.split("_")[1].toString();
			var index_name = check_id.split("_")[2].toString();

			deleteCheckedIndex(index_name, index_type);
		});
	});

	// Index Refresh Button 'Click' Event
	jQuery(".index_button_refresh").click(function() {
		getAllIndex();
	});

	// Index Type Selection
	jQuery("ul#type-index > li").click(function() {
		var c = jQuery(this);
		var v = c.text();

		jQuery(".text-muted").find("span").html(v);

		jQuery("ul#type-index > li").each(function() {
			var t = jQuery(this);
			t.removeClass("active");
		});
		c.addClass("active");

		getAllIndex();
	});

	getAllIndex();
});

/**
 * 获取指标库中所有的指标
 * 
 * @returns {Void}
 */
function getAllIndex() {
	jQuery("#table_all_index > tbody").empty();
	jQuery("#pagination").empty();
	jQuery("#table_all_index").next("div").children("span").html("共 0 条记录");

	// 当前激活的指标类型（Active）
	var index_type = jQuery("#type-index").children("li.active").children("a")
			.attr("id");

	if (index_type === "gn-index") {
		index_type = "常规指标";
	} else if (index_type === "ct-index") {
		index_type = "特征指标";
	} else if (index_type === "ot-index") {
		index_type = "其他指标";
	} else {
		index_type = null;
	}

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
				// 指标库指标记录长度
				var len = data.index_list.length;
				// 指标库指标记录长度算子
				var count = 0;

				for (var i = 0; i < len; i++) {
					// 判断当前指标类型是否与处于激活态的指标类型一致
					if (data.index_list[i].indexType === index_type) {
						indexName[count] = data.index_list[i].indexName;
						indexType[count] = data.index_list[i].indexType;
						count++;
					}
				}

				drawPaginationAllIndex(count, indexName, indexType);
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

	// Search Form 表单过滤
	jQuery(".searchform_index_mana").find("input").on(
			"input propertychange",
			function() {
				var c = jQuery(this);
				// 过滤器
				var filter = c.val();
				// 指标库指标长度算子
				var count = 0;

				if (filter) {
					// 指标库指标记录长度
					var len = indexName.length;

					for (var i = 0; i < len; i++) {
						// 判断如果指标列表中是否有包含过滤器片段
						if (indexName[i].indexOf(filter) >= 0) {
							searchIndexName[count] = indexName[i];
							searchIndexType[count] = indexType[i];
							count++;
						}
					}

					drawPaginationAllIndex(count, searchIndexName,
							searchIndexType);
				} else {
					count = indexName.length;
					drawPaginationAllIndex(count, indexName, indexType);
				}
			});
}

/**
 * 删除选中指标
 * 
 * @param {String}
 *            indexnamechecked 选中指标名称
 * 
 * @param {String}
 *            indextypechecked 选中指标类型
 * 
 * @returns {Void}
 */
function deleteCheckedIndex(indexnamechecked, indextypechecked) {
	jQuery.ajax({
		type : "POST",
		url : "GdWaterServlet",
		context : this,
		data : {
			servicename : "index-db-service",
			servicetype : "delete-checked-index",
			index_name : indexnamechecked,
			index_type : indextypechecked
		},
		success : function(data) {
			if (data.success_delete_checked_index) {
				jQuery.gritter.add({
					title : "系统消息",
					text : data.message_delete_checked_index,
					class_name : "growl-success",
					image : "images/screen.png",
					sticky : false,
					time : 5000
				});

				getAllIndex();
			} else {
				jQuery.gritter.add({
					title : "系统消息",
					text : "请检查数据库，亦或数据库未连接",
					class_name : "growl-warning",
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

/**
 * 绘制分页
 * 
 * 
 * @param {int}
 *            rowcount 数据记录行数
 * @param {String}
 *            indexname 指标名称
 * @param {String}
 *            indextype 指标类型
 * @param {int}
 *            curpage 当前页码
 * 
 * @returns {Void}
 */
function drawPaginationAllIndex(rowcount, indexname, indextype, curpage) {
	// 当前页数
	var curpage = 1;
	// 每页记录条数
	var perpageitem = 5;
	// 页码数
	var pagenum = 1;

	if (rowcount % perpageitem === 0) {
		pagenum = parseInt(rowcount / perpageitem);
	} else {
		pagenum = parseInt(rowcount / perpageitem) + 1;
	}

	drawPaginationStyleAllIndex(pagenum, curpage, rowcount, perpageitem,
			indexname, indextype);

	drawDataTableAllIndex(perpageitem, curpage, pagenum, rowcount, indexname,
			indextype);
}

/**
 * 绘制分页样式
 * 
 * @param {int}
 *            pagenum 页码数
 * @param {int}
 *            curpage 当前页码
 * @param {int}
 *            rowcount 数据记录行数
 * @param {int}
 *            parpageitem 每页记录条数
 * @param {String[]}
 *            indexname 指标名称数组
 * @param {String[]}
 *            indextype 指标类型数组
 * 
 * @returns {Void}
 */
function drawPaginationStyleAllIndex(pagenum, curpage, rowcount, perpageitem,
		indexname, indextype) {
	jQuery("#pagination").empty();
	var perpagegroupnum = 5; // 5页一组
	var pagegroup = parseInt(pagenum / perpagegroupnum) + 1;
	var curpagegroup = 1;
	if (curpage % perpagegroupnum === 0) {
		curpagegroup = parseInt(curpage / perpagegroupnum);
	} else if (curpage % perpagegroupnum !== 0) {
		curpagegroup = parseInt(curpage / perpagegroupnum) + 1;
	}

	if (parseInt(pagenum) <= parseInt(perpagegroupnum)) {
		var pages = "<li><a href='javascript:void(0)' id='page-prev'>«</a></li>";
		for (var i = 1; i < pagenum + 1; i++) {
			pages += "<li><a href='javascript:void(0)' id='page-" + i + "'>"
					+ i + "</a></li>";
		}
		pages += "<li><a href='javascript:void(0)' id='page-next'>»</a></li>";
		jQuery("#pagination").append(pages);

		if (curpage === 1) {
			jQuery("#page-prev").parent("li").addClass("am-disabled");
			jQuery("#page-1").parent("li").addClass("am-active");
		}
		if (curpage === pagenum) {
			jQuery("#page-next").parent("li").addClass("am-disabled");
		}

		for (var i = 1; i < pagenum + 1; i++) {
			jQuery("#page-" + i)
					.bind(
							"click",
							function() {
								var id = this.id;
								var cur_page = parseInt(id.toString()
										.substring(5));
								drawPaginationStyleAllIndex(pagenum,
										parseInt(cur_page), rowcount,
										perpageitem, indexname, indextype);
								drawDataTableAllIndex(perpageitem,
										parseInt(cur_page), pagenum, rowcount,
										indexname, indextype);
								jQuery("#page-1").parent("li").removeClass(
										"am-active");
								jQuery("#page-" + cur_page).parent("li")
										.addClass("am-active");
								curpage = parseInt(cur_page);
							});
		}

		jQuery("#page-next").bind(
				"click",
				function() {
					var cur_page = parseInt(curpage);
					curpage = parseInt(cur_page + 1);
					drawPaginationStyleAllIndex(pagenum, curpage, rowcount,
							perpageitem, indexname, indextype);
					drawDataTableAllIndex(perpageitem, curpage, pagenum,
							rowcount, indexname, indextype);
					jQuery("#page-" + cur_page).parent("li").removeClass(
							"am-active");
					jQuery("#page-" + curpage).parent("li").addClass(
							"am-active");
				});

		jQuery("#page-prev").bind(
				"click",
				function() {
					var cur_page = parseInt(curpage);
					curpage = parseInt(cur_page - 1);
					drawPaginationStyleAllIndex(pagenum, curpage, rowcount,
							perpageitem, indexname, indextype);
					drawDataTableAllIndex(perpageitem, curpage, pagenum,
							rowcount, indexname, indextype);
					jQuery("#page-" + cur_page).parent("li").removeClass(
							"am-active");
					jQuery("#page-" + curpage).parent("li").addClass(
							"am-active");
				});
	} else {
		var pages = "<li><a href='javascript:void(0)' id='page-prev'>«</a></li>";
		if (curpagegroup < pagegroup) {
			for (var i = ((curpagegroup - 1) * perpagegroupnum) + 1; i < (curpagegroup * perpagegroupnum) + 1; i++) {
				pages += "<li><a href='javascript:void(0)' id='page-" + i
						+ "'>" + i + "</a></li>";
			}
		} else if (curpagegroup === pagegroup) {
			for (var i = ((curpagegroup - 1) * perpagegroupnum) + 1; i < pagenum; i++) {
				pages += "<li><a href='javascript:void(0)' id='page-" + i
						+ "'>" + i + "</a></li>";
			}
		}
		pages += "<li><a href='javascript:void(0)' id='page-next'>»</a></li>";
		jQuery("#pagination").append(pages);

		if (curpage === 1) {
			jQuery("#page-prev").parent("li").addClass("am-disabled");
			jQuery("#page-1").parent("li").addClass("am-active");
		}
		if (curpage === pagenum) {
			jQuery("#page-next").parent("li").addClass("am-disabled");
		}

		if (curpagegroup < pagegroup) {
			for (var i = ((curpagegroup - 1) * perpagegroupnum) + 1; i < (curpagegroup * perpagegroupnum) + 1; i++) {
				jQuery("#page-" + i)
						.bind(
								"click",
								function() {
									var id = this.id;
									var cur_page = parseInt(id.toString()
											.substring(5));
									drawPaginationStyleAllIndex(pagenum,
											parseInt(cur_page), rowcount,
											perpageitem, indexname, indextype);
									drawDataTableAllIndex(perpageitem,
											parseInt(cur_page), pagenum,
											rowcount, indexname, indextype);
									jQuery("#page-" + curpage).parent("li")
											.removeClass("am-active");
									jQuery("#page-" + cur_page).parent("li")
											.addClass("am-active");
									curpage = parseInt(cur_page);
								});
			}
		} else if (curpagegroup === pagegroup) {
			for (var i = ((curpagegroup - 1) * perpagegroupnum) + 1; i < pagenum; i++) {
				jQuery("#page-" + i)
						.bind(
								"click",
								function() {
									var id = this.id;
									var cur_page = parseInt(id.toString()
											.substring(5));
									drawPaginationStyleAllIndex(pagenum,
											parseInt(cur_page), rowcount,
											perpageitem, indexname, indextype);
									drawDataTableAllIndex(perpageitem,
											parseInt(cur_page), pagenum,
											rowcount, indexname, indextype);
									jQuery("#page-" + curpage).parent("li")
											.removeClass("am-active");
									jQuery("#page-" + cur_page).parent("li")
											.addClass("am-active");
									curpage = parseInt(cur_page);
								});
			}
		}

		jQuery("#page-next").bind(
				"click",
				function() {
					if (curpage % perpagegroupnum !== 0) {
						var cur_page = parseInt(curpage);
						curpage = parseInt(cur_page + 1);
						drawPaginationStyleAllIndex(pagenum, curpage, rowcount,
								perpageitem, indexname, indextype);
						drawDataTableAllIndex(perpageitem, curage, pagenum,
								rowcount, indexname, indextype);
						jQuery("#page-" + cur_page).parent("li").removeClass(
								"am-active");
						jQuery("#page-" + curpage).parent("li").addClass(
								"am-active");
					} else if (curpage % perpagegroupnum === 0) {
						curpage = curpage + 1;
						drawPaginationStyleAllIndex(pagenum, curpage, rowcount,
								perpageitem, indexname, indextype);
						drawDataTableAllIndex(perpageitem, curage, pagenum,
								rowcount, indexname, indextype);
						if (curpage % perpagegroupnum === 1) {
							jQuery("#page-" + curpage).parent("li").addClass(
									"am-active");
						}
					}
				});

		jQuery("#page-prev").bind(
				"click",
				function() {
					if (curpage % perpagegroupnum !== 1) {
						var cur_page = parseInt(curpage);
						curpage = parseInt(cur_page - 1);
						drawPaginationStyleAllIndex(pagenum, curpage, rowcount,
								perpageitem, indexname, indextype);
						drawDataTableAllIndex(perpageitem, curage, pagenum,
								rowcount, indexname, indextype);
						jQuery("#page-" + cur_page).parent("li").removeClass(
								"am-active");
						jQuery("#page-" + curpage).parent("li").addClass(
								"am-active");
					} else if (curpage % perpagegroupnum === 1) {
						curpage = curpage - 1;
						drawPaginationStyleAllIndex(pagenum, curpage, rowcount,
								perpageitem, indexname, indextype);
						drawDataTableAllIndex(perpageitem, curage, pagenum,
								rowcount, indexname, indextype);
						if (curpage % perpagegroupnum === 0) {
							jQuery("#page-" + curpage).parent("li").addClass(
									"am-active");
						}
					}
				});
	}
}

/**
 * 根据分页信息，动态绘制数据表
 * 
 * @param {int}
 *            pagination 每页多少条数据
 * @param {int}
 *            curpage 当前第多少页
 * @param {int}
 *            pagenum 一共多少页
 * @param {int}
 *            rowcount 一共多少行数据
 * @param {String[]}
 *            indexname 指标名称数组
 * @param {String[]}
 *            indextype 指标类型数组
 * 
 * @returns {Void}
 */
function drawDataTableAllIndex(pagination, curpage, pagenum, rowcount,
		indexname, indextype) {
	jQuery('#table_all_index > tbody').empty();

	if (parseInt(curpage) < parseInt(pagenum)) {
		for (var i = parseInt(pagination) * (parseInt(curpage) - 1); i < parseInt(pagination)
				* parseInt(curpage); i++) {
			drawAllIndexList((i + 1), indexname[i], indextype[i],
					'#table_all_index > tbody');
		}
	} else {
		for (var i = parseInt(pagination) * (parseInt(curpage) - 1); i < rowcount; i++) {
			drawAllIndexList((i + 1), indexname[i], indextype[i],
					'#table_all_index > tbody');
		}
	}

	jQuery("#table_all_index").next("div").children("span").html(
			"共 " + parseInt(rowcount) + " 条记录");
}

/**
 * 绘制指标列表
 * 
 * @param {int}
 *            seq 序列
 * @param {String}
 *            indexname 指标名称
 * @param {String}
 *            indextype 指标类型
 * @param {String}
 *            tablefilter 表过滤器
 * 
 * @returns {Void}
 */
function drawAllIndexList(seq, indexname, indextype, tablefilter) {
	var tbody = "<tr>";
	var td_check_button = "<td><div class='ckbox ckbox-success'>"
			+ "<input type='checkbox' id='checkbox_" + indextype + "_"
			+ indexname + "'><label for='checkbox_" + indextype + "_"
			+ indexname + "'></label></div></td>";
	var td_index_info = "<td><div class='media'><div class='media-body'>"
			+ "<span>"
			+ seq
			+ "</span><span class='ml50'></span>"
			+ "<span>"
			+ indextype
			+ "</span><span class='ml50'></span>"
			+ "<input type='text' id='index_"
			+ seq
			+ "' class='form-control' "
			+ "disabled='true' style='width:700px; height:35px; display:inline' "
			+ "value='" + indexname + "'/>" + "</div></div></td>";

	tbody += td_check_button + td_index_info;

	jQuery(tablefilter).append(tbody);
}
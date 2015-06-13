/**
 * Create by GeekCarnegie On 2015-06-10
 */

/****************** Variable ******************/
/* 1.indexNameSelect[] 用户自定义选择指标名称数组 */
/* 2.indexTypeSelect[] 用户自定义选择指标类型数组 */
/* 3.searchIndexNameSelect[] 搜索栏搜索的用户自定义选择指标名称数组  */
/* 4.searchIndexTypeSelect[] 搜索栏搜索的用户自定义选择指标类型数组 */
/**********************************************/

/****************** Function ******************/
/* 1.getCheckedIndex 获取用户自定义选择的指标 */
/* 2.drawPaginationSelectedIndex 绘制分页(用户自定义选择的指标) */
/* 3.drawPaginationStyleSelectedIndex 绘制分页样式(用户自定义选择的指标) */
/* 4.drawDataTableSelectedIndex 根据分页信息，动态绘制数据表(用户自定义的指标) */
/* 5.drawSelectedIndexList 绘制指标列表 (用户自定义的指标) */
/** ******************************************* */

var indexNameSelect = new Array();
var indexTypeSelect = new Array();
var searchIndexNameSelect = new Array();
var searchIndexTypeSelect = new Array();

jQuery(document).ready(
		function() {
			"use strict";

			// Page Preloader
			jQuery("#preloader_index_thre").delay(3000).fadeOut(function() {
				getIndexThre();
				jQuery("#contentpanel_func_1_3").delay(1000).css({
					"overflow" : "visible"
				});				
			});

			getCheckedIndex();			

			// Save Thre Button 'Click' Event
			jQuery("#save_index_thre").click(
					function() {
						jQuery("#table_selected_index > tbody > tr").each(
								function() {
									var tr = jQuery(this);
									var seq = parseInt(tr.children("td")
											.children("div").children("div")
											.find("span:eq(0)").text()
											.toString());
									seq = seq - 1;
									var threshold_d = 0.0;									
									
									var indexnameselect = indexNameSelect[seq];
									var indextypeselect = indexTypeSelect[seq];
									var thresholdval = tr.children("td")
											.children("div").children("div")
											.find("input[id*='thre']").val();
									if (isNaN(thresholdval)) {
										jQuery.gritter.add({
											title : "警告",
											text : "阈值格式输入错误，请重新输入！",
											class_name : "growl-danger",
											image : "images/screen.png",
											sticky : false,
											time : 5000
										});
										return ;
									}
									
									if (thresholdval) {
										threshold_d = thresholdval.toString();
									} 
									
									jQuery.ajax({
										type: "POST",
										url: "GdWaterServlet",
										context: this,
										data: {
											servicename : "index-db-service",
											servicetype : "save-index-thre",
											"index_name_select" : indexnameselect,
											"index_type_select" : indextypeselect,
											"threshold" : threshold_d
										},
										success: function(data) {
											if (data.success_save_index_thre) {
												jQuery.gritter.add({
													title : "系统消息",
													text : "阈值保存成功！",
													class_name : "growl-success",
													image : "images/screen.png",
													sticky : false,
													time : 5000
												});
											}
										},
										error: function() {
											jQuery.gritter.add({
												title : "警告",
												text : "异常错误",
												class_name : "growl-danger",
												image : "images/screen.png",
												sticky : false,
												time : 5000
											});
										},
										dataType: "json"
									});
								});
					});
		});

/**
 * 获取用户自定义选择的指标
 * 
 * @returns {Void}
 */
function getCheckedIndex() {
	jQuery
			.ajax({
				type : "POST",
				url : "GdWaterServlet",
				context : this,
				data : {
					servicename : "index-db-service",
					servicetype : "get-checked-index"
				},
				success : function(data) {
					if (data.success_get_checked_index) {
						// 用户自定义选择指标记录长度
						var len = data.dataset_checked_index.length;
						// 用户自定义选择指标记录长度算子
						var count = 0;

						for (var i = 0; i < len; i++) {
							indexNameSelect[count] = data.dataset_checked_index[i][1];
							indexTypeSelect[count] = data.dataset_checked_index[i][2];
							count++;
						}

						drawPaginationSelectedIndex(count, indexNameSelect,
								indexTypeSelect);

						// Search Form 表单过滤
						jQuery(".searchform_index_thre")
								.find('input')
								.on(
										'input propertychange',
										function() {
											var c = jQuery(this);
											// 过滤器
											var filter = c.val();
											// 用户自定义选择指标记录长度算子
											var count = 0;

											if (filter) {
												// 用户自定义选择指标记录长度
												var len = indexNameSelect.length;
												// 判断如果已选指标列表中是否有包含过滤器片段
												for (var i = 0; i < len; i++) {
													if (indexNameSelect[i]
															.indexOf(filter) >= 0) {
														searchIndexNameSelect[count] = indexNameSelect[i];
														searchIndexTypeSelect[count] = indexTypeSelect[i];
														count++;
													}
												}

												drawPaginationSelectedIndex(
														count,
														searchIndexNameSelect,
														searchIndexTypeSelect);
											} else {
												count = indexNameSelect.length;
												drawPaginationSelectedIndex(
														count, indexNameSelect,
														indexTypeSelect);
											}
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
function drawPaginationSelectedIndex(rowcount, indexname, indextype, curpage) {
	var curpage = 1;
	var perpageitem = 5;
	var pagenum = 1;

	if (rowcount % perpageitem === 0) {
		pagenum = parseInt(rowcount / perpageitem);
	} else {
		pagenum = parseInt(rowcount / perpageitem) + 1;
	}

	drawPaginationStyleSelectedIndex(pagenum, curpage, rowcount, perpageitem,
			indexname, indextype);

	drawDataTableSelectedIndex(perpageitem, curpage, pagenum, rowcount,
			indexname, indextype);
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
function drawPaginationStyleSelectedIndex(pagenum, curpage, rowcount,
		perpageitem, indexname, indextype) {
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
								drawPaginationStyleSelectedIndex(pagenum,
										parseInt(cur_page), rowcount,
										perpageitem, indexname, indextype);
								drawDataTableSelectedIndex(perpageitem,
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
					drawPaginationStyleSelectedIndex(pagenum, curpage,
							rowcount, perpageitem, indexname, indextype);
					drawDataTableSelectedIndex(perpageitem, curpage, pagenum,
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
					drawPaginationStyleSelectedIndex(pagenum, curpage,
							rowcount, perpageitem, indexname, indextype);
					drawDataTableSelectedIndex(perpageitem, curpage, pagenum,
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
									drawPaginationStyleSelectedIndex(pagenum,
											parseInt(cur_page), rowcount,
											perpageitem, indexname, indextype);
									drawDataTableSelectedIndex(perpageitem,
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
									drawPaginationStyleSelectedIndex(pagenum,
											parseInt(cur_page), rowcount,
											perpageitem, indexname, indextype);
									drawDataTableSelectedIndex(perpageitem,
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
						drawPaginationStyleSelectedIndex(pagenum, curpage,
								rowcount, perpageitem, indexname, indextype);
						drawDataTableSelectedIndex(perpageitem, curage,
								pagenum, rowcount, indexname, indextype);
						jQuery("#page-" + cur_page).parent("li").removeClass(
								"am-active");
						jQuery("#page-" + curpage).parent("li").addClass(
								"am-active");
					} else if (curpage % perpagegroupnum === 0) {
						curpage = curpage + 1;
						drawPaginationStyleSelectedIndex(pagenum, curpage,
								rowcount, perpageitem, indexname, indextype);
						drawDataTableSelectedIndex(perpageitem, curage,
								pagenum, rowcount, indexname, indextype);
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
						drawPaginationStyleSelectedIndex(pagenum, curpage,
								rowcount, perpageitem, indexname, indextype);
						drawDataTableSelectedIndex(perpageitem, curage,
								pagenum, rowcount, indexname, indextype);
						jQuery("#page-" + cur_page).parent("li").removeClass(
								"am-active");
						jQuery("#page-" + curpage).parent("li").addClass(
								"am-active");
					} else if (curpage % perpagegroupnum === 1) {
						curpage = curpage - 1;
						drawPaginationStyleSelectedIndex(pagenum, curpage,
								rowcount, perpageitem, indexname, indextype);
						drawDataTableSelectedIndex(perpageitem, curage,
								pagenum, rowcount, indexname, indextype);
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
function drawDataTableSelectedIndex(pagination, curpage, pagenum, rowcount,
		indexname, indextype) {
	jQuery("#table_selected_index > tbody").empty();

	if (parseInt(curpage) < parseInt(pagenum)) {
		for (var i = parseInt(pagination) * (parseInt(curpage) - 1); i < parseInt(pagination)
				* parseInt(curpage); i++) {
			drawSelectedIndexList((i + 1), indexname[i], indextype[i],
					"#table_selected_indexx > tbody");
		}
	} else {
		for (var i = parseInt(pagination) * (parseInt(curpage) - 1); i < rowcount; i++) {
			drawSelectedIndexList((i + 1), indexname[i], indextype[i],
					"#table_selected_index > tbody");
		}
	}

	jQuery("#table_selected_index").next("div").children("span").html(
			"共 " + parseInt(rowcount) + " 条记录");
}

/**
 * 绘制已选指标列表
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
function drawSelectedIndexList(seq, index_name, index_type, tablefilter) {
	var tbody = "<tr>";
	var td_index_info = "<td><div class='media'><div class='media-body'>"
			+ "<div class='ml20' style='display:inline'></div><span>"
			+ seq
			+ "</span><span class='ml50'></span>"
			+ "<span>"
			+ index_type
			+ "</span><span class='ml50'></span>"
			+ "<input type='text' id='index_"
			+ seq
			+ "' class='form-control' "
			+ "disabled='true' style='width:700px; height:35px; display:inline' "
			+ "value='"
			+ index_name
			+ "'/>"
			+ "<div class='ml20' "
			+ "style='display:inline'></div><input type='text' id='thre_"
			+ seq
			+ "' class='form-control'  placeholder='请输入阈值大小...' style='width:200px;"
			+ "height:35px; display:inline;'/>" + "</div></div></td>";

	tbody += td_index_info;

	jQuery(tablefilter).append(tbody);
}

function getIndexThre() {
	jQuery.ajax({
		type: "POST",
		url: "GdWaterServlet",
		context: this,
		data: {
			servicename : "index-db-service",
			servicetype : "get-index-thre"
		},
		success: function(data) {
			if (data.success_get_index_thre) {
				var len = data.indexname.length;
				for (var i=0; i<len; i++) {
					var indexname = data.indexname[i];
					var indextype = data.indextype[i];
					var indexthreshold = data.indexthreshold[i];
					
					jQuery("#table_selected_index > tbody > tr").each(function() {
						var tr = jQuery(this);
						var name = tr.children("td").children("div").children("div").find("input[id*='index']").val().toString();
						var type = tr.children("td").children("div").children("div").find("span:eq(2)").text().toString();
						
						if (indexname === name && indextype === type) {
							tr.children("td").children("div").children("div").find("input[id*='thre']").val(indexthreshold);
						}
					});
				}
			}
		},
		error: function(e) {
			jQuery.gritter.add({
				title : "警告",
				text : "异常错误",
				class_name : "growl-danger",
				image : "images/screen.png",
				sticky : false,
				time : 5000
			});
		},
		dataType: "json"
	});
}
/**
 * Create by GeekCarnegie On 2015-06-10
 */

/****************** Variable ******************/
/* 1.pollutionTypeAll[] 全部污染类型数组 */
/* 2.indexNameAll[] 全部指标名称数组 */
/* 3.indexNameSelect[] 用户自定义选择指标名称数组 */
/* 4.pollutionTypeSelect[] 污染类型选择数组 */
/* 5.threshold[] 阈值数组 */
/* 6.searchIndexNameSelect[] 搜索栏搜索的用户自定义选择指标名称数组  */
/* 7.searchPollutionTypeSelect[] 搜索栏搜索的污染类型数组 */
/**********************************************/

/****************** Function ******************/
/* 1.getPollutionTypeThre 获取污染类型库中所有的污染类型 */
/* 2.getCheckedIndexThre(pollution_type) 获取用户自定义选择的指标 */
/* 2.drawPaginationSelectedIndex 绘制分页(用户自定义选择的指标) */
/* 3.drawPaginationStyleSelectedIndex 绘制分页样式(用户自定义选择的指标) */
/* 4.drawDataTableSelectedIndex 根据分页信息，动态绘制数据表(用户自定义的指标) */
/* 5.drawSelectedIndexList 绘制指标列表 (用户自定义的指标) */
/** ******************************************* */


var pollutionTypeAll = new Array();
var indexNameAll = new Array();
var indexNameSelect = new Array();
var pollutionTypeSelect = new Array();
var threshold = new Array();
var searchIndexNameSelect = new Array();
var searchPollutionTypeSelect = new Array();

jQuery(document)
		.ready(
				function() {
					"use strict";

					// Page Preloader
					jQuery("#preloader_index_thre").delay(3000).fadeOut(
							function() {								
								jQuery("#contentpanel_func_1_3").delay(1000)
										.css({
											"overflow" : "visible"
										});
							});
					
					// Select2
					jQuery("#thre_pollutiontype").select2({
						width : '100%',
						minimumResultsForSearch : -1
					});
					
					getPollutionTypeThre();
					
					getIndexThre();
					
					jQuery("#thre_pollutiontype").on("change", function(e) {
						if (!e) {
							return ;
						} else {
							var data = jQuery(this).select2("data").text;
							getCheckedIndexThre(data);
						}
					});	

					// Save Thre Button 'Click' Event
					jQuery("#save_index_thre")
							.click(
									function() {
										if (jQuery("#thre_pollutiontype").select2("data") === null) {
											jQuery.gritter.add({
												title : "系统消息",
												text : "请先选择一个污染类型",
												class_name : "growl-warning",
												image : "images/screen.png",
												sticky : false,
												time : 2000
											});
											return ;
										}
										var len = threshold.length;										
										
										for (var i=0; i<len; i++) {
											var indexnameselect = indexNameSelect[i];
											var pollutiontypeselect = pollutionTypeSelect[i];
											var thresholdval = threshold[i];
											var threshold_d = 0.0;
											
											if (isNaN(thresholdval)) {
												jQuery.gritter
														.add({
															title : "警告",
															text : "阈值格式输入错误，请重新输入！",
															class_name : "growl-danger",
															image : "images/screen.png",
															sticky : false,
															time : 5000
														});
												return;
											}
											
											if (thresholdval) {
												threshold_d = thresholdval
														.toString();
											}
											
											jQuery.ajax({
												type : "POST",
												url : "GdWaterServlet",
												context : this,
												data : {
													servicename : "index-db-service",
													servicetype : "save-index-thre",
													"index_name_select" : indexnameselect,
													"pollution_type_select" : pollutiontypeselect,
													"threshold" : threshold_d
												},
												success : function(
														data) {
													if (data.success_save_index_thre) {
														jQuery.gritter
																.add({
																	title : "系统消息",
																	text : "指标" + indexnameselect + "的阈值保存成功！",
																	class_name : "growl-success",
																	image : "images/screen.png",
																	sticky : false,
																	time : 5000
																});
													}
												},
												error : function() {
													jQuery.gritter
															.add({
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
										
									});
				});

/**
 * 获取污染类型库中所有的污染类型
 * 
 * @returns {Void}
 */
function getPollutionTypeThre() {
	pollutionTypeAll = [];
	jQuery("#thre_pollutiontype").empty();

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
				pollutionTypeAll = data.pollutiontypeall;
				
				jQuery("#thre_pollutiontype").append("<option></option>");
				
				for (var i = 0; i < len; i++) {
					var option = "<option value='" + pollutionTypeAll[i] + "'>"
							+ pollutionTypeAll[i] + "</option>";
					
					jQuery("#thre_pollutiontype").append(option);
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
 * 获取用户自定义选择的指标
 * 
 * @param {String}
 *             pollution_type 污染类型
 * 
 * @returns {Void}
 */
function getCheckedIndexThre(pollution_type) {
	indexNameSelect = [];
	pollutionTypeSelect = [];
	threshold = [];
	
	jQuery
			.ajax({
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
						// 用户自定义选择指标记录长度
						var len = data.selectedindex.length;
						// 用户自定义选择指标记录长度算子
						var count = 0;

						for (var i = 0; i < len; i++) {
							indexNameSelect[count] = data.selectedindex[i][1];
							pollutionTypeSelect[count] = data.selectedindex[i][2];
							threshold[count] = data.selectedindex[i][3];
							count++;							
						}
						
						drawPaginationSelectedIndex(count, indexNameSelect,
								pollutionTypeSelect);

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
														searchPollutionTypeSelect[count] = pollutionTypeSelect[i];
														count++;
													}
												}

												drawPaginationSelectedIndex(
														count,
														searchIndexNameSelect,
														searchPollutionTypeSelect);
											} else {
												count = indexNameSelect.length;
												drawPaginationSelectedIndex(
														count, indexNameSelect,
														pollutionTypeSelect);
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
 *            pollutiontype 污染类型
 * @param {int}
 *            curpage 当前页码
 * 
 * @returns {Void}
 */
function drawPaginationSelectedIndex(rowcount, indexname, pollutiontype, curpage) {	
	var curpage = 1;
	var perpageitem = 5;
	var pagenum = 1;

	if (rowcount % perpageitem === 0) {
		pagenum = parseInt(rowcount / perpageitem);
	} else {
		pagenum = parseInt(rowcount / perpageitem) + 1;
	}

	drawPaginationStyleSelectedIndex(pagenum, curpage, rowcount, perpageitem,
			indexname, pollutiontype);

	drawDataTableSelectedIndex(perpageitem, curpage, pagenum, rowcount,
			indexname, pollutiontype);
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
 *            pollutiontype 污染类型数组
 * 
 * @returns {Void}
 */
function drawPaginationStyleSelectedIndex(pagenum, curpage, rowcount,
		perpageitem, indexname, pollutiontype) {	
	jQuery("#pagination_thre").empty();
	var perpagegroupnum = 5; // 5页一组
	var pagegroup = parseInt(pagenum / perpagegroupnum) + 1;
	var curpagegroup = 1;
	if (curpage % perpagegroupnum === 0) {
		curpagegroup = parseInt(curpage / perpagegroupnum);
	} else if (curpage % perpagegroupnum !== 0) {
		curpagegroup = parseInt(curpage / perpagegroupnum) + 1;
	}

	if (parseInt(pagenum) <= parseInt(perpagegroupnum)) {
		var pages = "<li><a href='javascript:void(0)' id='page-prev-thre'>«</a></li>";
		for (var i = 1; i < pagenum + 1; i++) {
			pages += "<li><a href='javascript:void(0)' id='page-thre-" + i
					+ "'>" + i + "</a></li>";
		}
		pages += "<li><a href='javascript:void(0)' id='page-next-thre'>»</a></li>";
		jQuery("#pagination_thre").append(pages);

		if (curpage === 1) {
			jQuery("#page-prev-thre").parent("li").addClass("am-disabled");
			jQuery("#page-thre-1").parent("li").addClass("am-active");
		}
		if (curpage === pagenum) {
			jQuery("#page-next-thre").parent("li").addClass("am-disabled");
		}

		for (var i = 1; i < pagenum + 1; i++) {
			jQuery("#page-thre-" + i).bind(
					"click",
					function() {
						var id = this.id;
						var cur_page = parseInt(id.toString().substring(10));
						drawPaginationStyleSelectedIndex(pagenum,
								parseInt(cur_page), rowcount, perpageitem,
								indexname, pollutiontype);
						drawDataTableSelectedIndex(perpageitem,
								parseInt(cur_page), pagenum, rowcount,
								indexname, pollutiontype);
						jQuery("#page-thre-1").parent("li").removeClass(
								"am-active");
						jQuery("#page-thre-" + cur_page).parent("li").addClass(
								"am-active");
						curpage = parseInt(cur_page);
					});
		}

		jQuery("#page-next-thre").bind(
				"click",
				function() {
					var cur_page = parseInt(curpage);
					curpage = parseInt(cur_page + 1);
					drawPaginationStyleSelectedIndex(pagenum, curpage,
							rowcount, perpageitem, indexname, pollutiontype);
					drawDataTableSelectedIndex(perpageitem, curpage, pagenum,
							rowcount, indexname, pollutiontype);
					jQuery("#page-thre-" + cur_page).parent("li").removeClass(
							"am-active");
					jQuery("#page-thre-" + curpage).parent("li").addClass(
							"am-active");
				});

		jQuery("#page-prev-thre").bind(
				"click",
				function() {
					var cur_page = parseInt(curpage);
					curpage = parseInt(cur_page - 1);
					drawPaginationStyleSelectedIndex(pagenum, curpage,
							rowcount, perpageitem, indexname, pollutiontype);
					drawDataTableSelectedIndex(perpageitem, curpage, pagenum,
							rowcount, indexname, pollutiontype);
					jQuery("#page-thre-" + cur_page).parent("li").removeClass(
							"am-active");
					jQuery("#page-thre-" + curpage).parent("li").addClass(
							"am-active");
				});
	} else {
		var pages = "<li><a href='javascript:void(0)' id='page-prev-thre'>«</a></li>";
		if (curpagegroup < pagegroup) {
			for (var i = ((curpagegroup - 1) * perpagegroupnum) + 1; i < (curpagegroup * perpagegroupnum) + 1; i++) {
				pages += "<li><a href='javascript:void(0)' id='page-thre-" + i
						+ "'>" + i + "</a></li>";
			}
		} else if (curpagegroup === pagegroup) {
			for (var i = ((curpagegroup - 1) * perpagegroupnum) + 1; i < pagenum; i++) {
				pages += "<li><a href='javascript:void(0)' id='page-thre-" + i
						+ "'>" + i + "</a></li>";
			}
		}
		pages += "<li><a href='javascript:void(0)' id='page-next-thre'>»</a></li>";
		jQuery("#pagination_thre").append(pages);

		if (curpage === 1) {
			jQuery("#page-prev-thre").parent("li").addClass("am-disabled");
			jQuery("#page-thre-1").parent("li").addClass("am-active");
		}
		if (curpage === pagenum) {
			jQuery("#page-next-thre").parent("li").addClass("am-disabled");
		}

		if (curpagegroup < pagegroup) {
			for (var i = ((curpagegroup - 1) * perpagegroupnum) + 1; i < (curpagegroup * perpagegroupnum) + 1; i++) {
				jQuery("#page-thre-" + i)
						.bind(
								"click",
								function() {
									var id = this.id;
									var cur_page = parseInt(id.toString()
											.substring(10));
									drawPaginationStyleSelectedIndex(pagenum,
											parseInt(cur_page), rowcount,
											perpageitem, indexname, pollutiontype);
									drawDataTableSelectedIndex(perpageitem,
											parseInt(cur_page), pagenum,
											rowcount, indexname, pollutiontype);
									jQuery("#page-thre-" + curpage)
											.parent("li").removeClass(
													"am-active");
									jQuery("#page-thre-" + cur_page).parent(
											"li").addClass("am-active");
									curpage = parseInt(cur_page);
								});
			}
		} else if (curpagegroup === pagegroup) {
			for (var i = ((curpagegroup - 1) * perpagegroupnum) + 1; i < pagenum; i++) {
				jQuery("#page-thre-" + i)
						.bind(
								"click",
								function() {
									var id = this.id;
									var cur_page = parseInt(id.toString()
											.substring(10));
									drawPaginationStyleSelectedIndex(pagenum,
											parseInt(cur_page), rowcount,
											perpageitem, indexname, pollutiontype);
									drawDataTableSelectedIndex(perpageitem,
											parseInt(cur_page), pagenum,
											rowcount, indexname, pollutiontype);
									jQuery("#page-thre-" + curpage)
											.parent("li").removeClass(
													"am-active");
									jQuery("#page-thre-" + cur_page).parent(
											"li").addClass("am-active");
									curpage = parseInt(cur_page);
								});
			}
		}

		jQuery("#page-next-thre").bind(
				"click",
				function() {
					if (curpage % perpagegroupnum !== 0) {
						var cur_page = parseInt(curpage);
						curpage = parseInt(cur_page + 1);
						drawPaginationStyleSelectedIndex(pagenum, curpage,
								rowcount, perpageitem, indexname, pollutiontype);
						drawDataTableSelectedIndex(perpageitem, curage,
								pagenum, rowcount, indexname, pollutiontype);
						jQuery("#page-thre-" + cur_page).parent("li")
								.removeClass("am-active");
						jQuery("#page-thre-" + curpage).parent("li").addClass(
								"am-active");
					} else if (curpage % perpagegroupnum === 0) {
						curpage = curpage + 1;
						drawPaginationStyleSelectedIndex(pagenum, curpage,
								rowcount, perpageitem, indexname, pollutiontype);
						drawDataTableSelectedIndex(perpageitem, curage,
								pagenum, rowcount, indexname, pollutiontype);
						if (curpage % perpagegroupnum === 1) {
							jQuery("#page-thre-" + curpage).parent("li")
									.addClass("am-active");
						}
					}
				});

		jQuery("#page-prev-thre").bind(
				"click",
				function() {
					if (curpage % perpagegroupnum !== 1) {
						var cur_page = parseInt(curpage);
						curpage = parseInt(cur_page - 1);
						drawPaginationStyleSelectedIndex(pagenum, curpage,
								rowcount, perpageitem, indexname, pollutiontype);
						drawDataTableSelectedIndex(perpageitem, curage,
								pagenum, rowcount, indexname, pollutiontype);
						jQuery("#page-thre-" + cur_page).parent("li")
								.removeClass("am-active");
						jQuery("#page-thre-" + curpage).parent("li").addClass(
								"am-active");
					} else if (curpage % perpagegroupnum === 1) {
						curpage = curpage - 1;
						drawPaginationStyleSelectedIndex(pagenum, curpage,
								rowcount, perpageitem, indexname, pollutiontype);
						drawDataTableSelectedIndex(perpageitem, curage,
								pagenum, rowcount, indexname, pollutiontype);
						if (curpage % perpagegroupnum === 0) {
							jQuery("#page-thre-" + curpage).parent("li")
									.addClass("am-active");
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
 *            pollutiontype 污染类型数组
 * 
 * @returns {Void}
 */
function drawDataTableSelectedIndex(pagination, curpage, pagenum, rowcount,
		indexname, pollutiontype) {	
	jQuery("#table_selected_index > tbody").empty();

	if (parseInt(curpage) < parseInt(pagenum)) {
		for (var i = parseInt(pagination) * (parseInt(curpage) - 1); i < parseInt(pagination)
				* parseInt(curpage); i++) {
			drawSelectedIndexList((i + 1), indexname[i], pollutiontype[i],
					"#table_selected_index > tbody");
		}
	} else {
		for (var i = parseInt(pagination) * (parseInt(curpage) - 1); i < rowcount; i++) {
			drawSelectedIndexList((i + 1), indexname[i], pollutiontype[i],
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
 *            pollutiontype 污染类型
 * @param {String}
 *            tablefilter 表过滤器
 * 
 * @returns {Void}
 */
function drawSelectedIndexList(seq, index_name, pollution_type, tablefilter) {	
	var tbody = "<tr>";
	var td_index_info = "<td><div class='media'><div class='media-body'>"
			+ "<div class='ml20' style='display:inline;'></div><div style='display:inline-block;width:30px;'><span>"
			+ seq
			+ "</span></div><span class='ml50'></span><div style='display:inline-block;width:120px;'>"
			+ "<span>"
			+ pollution_type
			+ "</span></div><span class='ml50'></span>"
			+ "<input type='text' id='index_"
			+ seq
			+ "' class='form-control' "
			+ "disabled='true' style='width:400px; height:35px; display:inline' "
			+ "value='"
			+ index_name
			+ "'/>"
			+ "<div class='ml20' "
			+ "style='display:inline'></div><input type='text' id='thre_"
			+ seq
			+ "' class='form-control'  style='width:100px;" 
			+ "height:35px; display:inline;' value='" + threshold[seq-1] + "'/>" + "</div></div></td>";

	tbody += td_index_info;

	jQuery(tablefilter).append(tbody);
	
	jQuery("#thre_" + seq).on("input propertychange", function(){
		var c = jQuery(this);
		var thresholdval = c.val();
		threshold[seq-1] = thresholdval;
	});
}

function getIndexThre() {
	indexNameAll = [];
	jQuery.ajax({
		type : "POST",
		url : "GdWaterServlet",
		context : this,
		data : {
			servicename : "index-db-service",
			servicetype : "get-index-thre"
		},
		success : function(data) {
			if (data.success_get_index_thre) {
				var len = data.indexname.length;
				for (var i = 0; i < len; i++) {	
					indexNameAll[i] = data.indexname[i];
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
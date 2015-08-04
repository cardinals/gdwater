/**
 * Create by GeekCarnegie On 2015-06-27
 */

/****************** Variable ******************/
/* 1.ahppollutiontype[] 污染类型数组 */
/* 2.ahpindex[] 污染类型对应的指标数组 */
/* 3.layeroneMatrix[][] 第一层矩阵（二维） */
/* 4.layertwoMatrix[][][] 第二层矩阵（三维） */
/**********************************************/

/****************** Function ******************/
/* 1.buildAHPLayerOne 构建AHP第一层矩阵 */
/* 2.buildAHPLayerTwo 构建AHP第二层矩阵 */
/* 3.saveScores 保存第一、二层的专家打分，并将其存入数据库 */
/* 4.getAHPScores 获取上次专家打分 */
/** ******************************************* */

var ahppollutiontype = new Array();
var ahpindex = new Array();
var layeroneMatrix = new Array();
var layertwoMatrix = new Array();

jQuery(document).ready(
		function() {
			"use strict";

			// Page Preloader
			jQuery("#preloader_AHP").delay(3000).fadeOut(function() {
				jQuery("#contentpanel_func_2").delay(1000).css({
					"overflow" : "visible"
				});
			});

			// Wizard
			jQuery('#ahpWizard').bootstrapWizard(
					{
						'nextSelector' : '.next',
						'previousSelector' : '.previous',
						onNext : function(tab, navigation, index) {
							var $total = navigation.find('li').length;
							var $current = index + 1;
							if ($current === 3) {
								//saveScores();
								calculateResult();
							}
							var $percent = ($current / $total) * 100;
							jQuery('#ahpWizard').find('.progress-bar').css(
									'width', $percent + '%');
						},
						onPrevious : function(tab, navigation, index) {
							var $total = navigation.find('li').length;
							var $current = index + 1;
							var $percent = ($current / $total) * 100;
							jQuery('#ahpWizard').find('.progress-bar').css(
									'width', $percent + '%');
						},
						onTabShow : function(tab, navigation, index) {
							var $total = navigation.find('li').length;
							var $current = index + 1;
							var $percent = ($current / $total) * 100;
							jQuery('#ahpWizard').find('.progress-bar').css(
									'width', $percent + '%');
						}
					});

			// Close Button in Panels
			jQuery('.panel .panel-close').click(function() {
				jQuery(this).closest('.panel').fadeOut(200);
				return false;
			});

			// Minimize Button in Panels
			jQuery('.minimize').click(function() {
				var t = jQuery(this);
				var p = t.closest('.panel');
				if (!jQuery(this).hasClass('maximize')) {
					p.find('.panel-body, .panel-footer').slideUp(200);
					t.addClass('maximize');
					t.html('&plus;');
				} else {
					p.find('.panel-body, .panel-footer').slideDown(200);
					t.removeClass('maximize');
					t.html('&minus;');
				}
				return false;
			});

			buildAHPLayerOne();
			buildAHPLayerTwo();
			getAHPScores();
		});

/**
 * 构建AHP第一层矩阵
 * 
 * @returns {Void}
 */
function buildAHPLayerOne() {
	jQuery
			.ajax({
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
						ahppollutiontype = data.pollutiontypeall;

						var thead = "<tr><th style='text-align:center;width:" + 100/(ahppollutiontype.length+1) + "%;'>#</th>";
						var tbody = "";
						for (var i = 0; i < ahppollutiontype.length; i++) {
							thead += "<th style='text-align:center; width:" + 100/(ahppollutiontype.length+1) + "%;'>"
									+ ahppollutiontype[i] + "</th>";
							tbody += "<tr><th style='text-align:center'>"
									+ ahppollutiontype[i] + "</th>";
							for (var j = 0; j < ahppollutiontype.length; j++) {
								if (j > i) {
									tbody += "<th style='text-align:center;'>"
											+ "<input type='text' style='width:100px;' id='score1_"
											+ i + "_" + j + "'/></th>";
								} else if (j === i) {
									tbody += "<th style='text-align:center;'><input type='text' disabled='true' " +
											"style='width:100px;' id='score1_" + i + "_" + j + "' value='1'/></th>";
								} else {
									tbody += "<th style='text-align:center;'>" +
											"<input type='text' disabled='true' " +
											"style='width:100px;' id='score1_" + i + "_" + j + "'/></th>"
								}
							}
							tbody += "</tr>";
						}
						thead += "</tr>";
						
						jQuery("#ahp-1 > thead").append(thead);
						jQuery("#ahp-1 > tbody").append(tbody);
						
						for (var i = 0; i < ahppollutiontype.length; i++) {
							for (var j = 0; j < ahppollutiontype.length; j++) {
								if (j > i) {
									jQuery("#score1_" + i + "_" + j).on("input propertychange", function(){
										var c = jQuery(this);
										var id = c.attr("id");
										var row = id.toString().split("_")[1];
										var col = id.toString().split("_")[2];
										
										if (isNaN(c.val())) {
											jQuery.gritter.add({
												title : "系统消息",
												text : "请输入正确的格式",
												class_name : "growl-warning",
												image : "images/screen.png",
												sticky : false,
												time : 2000
											});
											
											return ;
										} else if (c.val().indexOf(".") === -1 && c.val() > 0 && c.val() < 10) {
											jQuery("#score1_" + col + "_" + row).attr("value",(1 / c.val()).toFixed(2));
										} else {
											jQuery.gritter.add({
												title : "系统消息",
												text : "请输入符合条件的整数",
												class_name : "growl-warning",
												image : "images/screen.png",
												sticky : false,
												time : 2000
											});
											
											return ;
										}										
									});
								}								
							}
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
 * 构建AHP第二层矩阵
 * 
 * @returns {Void}
 */
function buildAHPLayerTwo() {
	// 污染类型数组长度
	var len = ahppollutiontype.length;
	// 存放第二层动态矩阵的表数目及其行、列数
	var layertwo = new Array();
	
	for (var i=0; i<len; i++) {
		ahpindex[i] = new Array();
		var row = "<div class='row'><div class='table-responsive' " +
				"style='text-align:center;'><p>表" + (i+3) + "：第二层次矩阵(" + 
				ahppollutiontype[i] + ")</p>" +
				"<table class='table table-info table-bordered mb30' " +
				"id='ahp-2-" + (i+1) + "'><thead><tr>";
		
		jQuery.ajax({
			type: "POST",
			url: "GdWaterServlet",
			async: false,
			context: this,
			data: {
				servicename: "ahp-db-service",
				servicetype: "get-index-of-pollutiontype",
				pollutiontype: ahppollutiontype[i]
			},
			success: function(data) {
				if (data.success_get_index_of_pollutiontype) {					
					var index = data.index_set;
					var index_len = index.length;
					row += "<th style='text-align:center;width:" + 100/(index_len+1) + "%'>#</th>";
					for (var j=0; j<index_len; j++) {
						row += "<th style='text-align:center;width:" +
						100/(index_len+1) + "%'>" + index[j] + "</th>";
					}
					row += "</tr></thead><tbody>";									
					layertwo.push(index_len);
					
					for (var j=0; j<index_len; j++) {
						row += "<tr><th style='text-align:center;'>" + index[j] + "</th>";
						ahpindex[i][j] = index[j];
						for (var k=0; k<index_len; k++) {							
							if (k > j) {
								row += "<th style='text-align:center;'>" +
								"<input type='text' style='width:100px;' id='score2_" + i + "_" + j + "_" + k +
								"'/></th>";
							} else if (k === j) {
								row += "<th style='text-align:center;'><input type='text' disabled='true' " +
										"style='width:100px;' id='score2_" + i + "_" + j + "_" + k + "' value='1'/></th>";
							} else {
								row += "<th style='text-align:center;'>" +
								"<input type='text' disabled='true' style='width:100px;' id='score2_" +
								i + "_" + j + "_" + k + "'/></th>";
							}							
						}
						row += "</tr>";
					}
					
					row += "</tbody></table></div></div>";
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
		
		jQuery("#ahptab2").append(row);			
	}
	
	for (var i=0; i<layertwo.length; i++) {
		for (var j=0; j<layertwo[i]; j++) {
			for (var k=0; k<layertwo[i]; k++) {
				if (k > j) {
					jQuery("#score2_" + i + "_" + j + "_" + k).on("input propertychange", function(){
						var c = jQuery(this);
						var id = c.attr("id");
						var table_id = id.toString().split("_")[1];
						var row = id.toString().split("_")[2];
						var col = id.toString().split("_")[3];
						
						if (isNaN(c.val())) {
							jQuery.gritter.add({
								title : "系统消息",
								text : "请输入正确的格式",
								class_name : "growl-warning",
								image : "images/screen.png",
								sticky : false,
								time : 2000
							});
							
							return ;
						} else if (c.val().indexOf(".") === -1 && c.val() > 0 && c.val() < 10) {
							jQuery("#score2_" + table_id + "_" + col + "_" + row).attr("value",(1 / c.val()).toFixed(2));
						} else {
							jQuery.gritter.add({
								title : "系统消息",
								text : "请输入符合条件的整数",
								class_name : "growl-warning",
								image : "images/screen.png",
								sticky : false,
								time : 2000
							});
							
							return ;
						}		
					});
				}
			}				
		}			
	}	
}

/**
 * 保存AHP第一、二层的专家打分
 * 将用户打分存入数据库中
 * 
 * @returns {Void}
 */
function saveScores() {
	var i = 0; 
	jQuery("#ahp-1 > tbody > tr").each(function() {
		var tr = jQuery(this);
		layeroneMatrix[i] = new Array()
		var j = 0;
		tr.children("th:gt(0)").each(function() {
			var th = jQuery(this);
			if (!th.children("input").val()) {
				layeroneMatrix[i][j] = "1";				
			} else {
				layeroneMatrix[i][j] = th.children("input").val();	
			}
			
			j ++;				
		});
		i ++;
	});
	
	var ahp2len = 0;
	jQuery("table[id^='ahp-2-']").each(function() {
		ahp2len ++;
	});
	
	for (var m=0; m<ahp2len; m++) {
		layertwoMatrix[m] = [];
		
		jQuery("#ahp-2-" + (m+1) + " > tbody > tr").each(function() {
			var tr = jQuery(this);
			
			tr.children("th:gt(0)").each(function() {
				var th = jQuery(this);
				if (!th.children("input").val()) {
					layertwoMatrix[m] += "1,";					
				} else {
					layertwoMatrix[m] += th.children("input").val()+",";	
				}				
			});			
			
			layertwoMatrix[m] = layertwoMatrix[m].toString().substring(0, layertwoMatrix[m].length-1);
			layertwoMatrix[m] += ";"; 
		});
		
		layertwoMatrix[m] = layertwoMatrix[m].toString().substring(0, layertwoMatrix[m].length-1);
		
	}
	
	jQuery.ajax({
		type: "POST",
		url: "GdWaterServlet",
		context: this,
		data: {
			servicename: "ahp-db-service",
			servicetype: "sava-ahp-scores",
			"pollutiontype[]": ahppollutiontype,
			"indexname[]": ahpindex,
			"layeronematrix[]": layeroneMatrix,
			"layertwomatrix[]": layertwoMatrix
		},
		success: function(data) {
			if (data.success_save_ahp_scores) {
				
			} else {
				jQuery.gritter.add({
					title : "警告",
					text : "异常错误",
					class_name : "growl-danger",
					image : "images/screen.png",
					sticky : false,
					time : 5000
				});
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

/**
 * 获取上次专家打分
 * 
 * @returns {Void}
 */
function getAHPScores() {
	jQuery.ajax({
		type: "POST",
		url: "GdWaterServlet",
		context: this,
		data: {
			servicename: "ahp-db-service",
			servicetype: "get-ahp-scores"
		},
		success: function(data) {
			if (data.success_get_ahp_scores) {
				var ahplayerone = data.ahplayerone;
				var ahplayertwo = data.ahplayertwo;
				
				for (var i=0; i<ahplayerone.length; i++) {
					var row = ahplayerone[i][0];
					var col = ahplayerone[i][1];
					var score = ahplayerone[i][2];
					var colcount = 0;
					var rowcount = 0;
					
					var count = 0;									
					
					jQuery("#ahp-1 > thead > tr th").each(function () {
						var th = jQuery(this);
						var thval = th.text();
						if (thval === col) {
							colcount = count;
						}
						count ++;
					});
					
					count = 0;
					
					jQuery("#ahp-1 > tbody tr").each(function() {
						var tr = jQuery(this);
						var th = tr.find("th:eq(0)");
						var thval = th.text();
						if (thval === row) {
							rowcount = count;
						}
						count ++;
					});
					
					jQuery("#score1_" + rowcount + "_" + (colcount-1)).val(score);
				}
				
				for (var i=0; i<ahplayertwo.length; i++) {
					var pollutiontype = data.ahplayertwo[i][0];
					var row = data.ahplayertwo[i][1];
					var col = data.ahplayertwo[i][2];
					var score = data.ahplayertwo[i][3];
					
					for (var j=0; j<ahppollutiontype.length; j++) {
						if (pollutiontype.replace(/\s+/g,"") === ahppollutiontype[j]) {
							var rowcount = 0;
							var colcount = 0;
							
							var count = 0;
							
							jQuery("#ahp-2-" + (j+1) + " > thead > tr th").each(function() {
								var th = jQuery(this);
								var thval = th.text();
								if (thval === col) {
									colcount = count;
								}
								count ++;
							});
							
							count = 0;
							
							jQuery("#ahp-2-" + (j+1) + " > tbody tr").each(function() {
								var tr = jQuery(this);
								var th = tr.find("th:eq(0)");
								var thval = th.text();
								if (thval === row) {
									rowcount = count;
								}
								count ++;
							});
							
							jQuery("#score2_" + j + "_" + rowcount + "_" + (colcount-1)).val(score);
						}
					}										
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

/**
 * 计算层次分析法得到的结果
 * 
 * @returns {Void}
 */
function calculateResult() {
	jQuery("#ahptab3").empty();
	
	var A = "A=[";
	jQuery("#ahp-1 > tbody tr").each(function() {
		var tr = jQuery(this);
		tr.children("th:gt(0)").each(function() {
			var th = jQuery(this);
			var val = th.find("input").val();
			A += val + ",";
		});
		A = A.substring(0, A.length-1);
		A += ";";
	});
	A = A.substring(0, A.length-1);
	A += "]";

	var B = new Array();
	
	var B_len = ahppollutiontype.length;
	for (var i=0; i<B_len; i++) {
		var b = "B" + (i+1) + "=[";
		jQuery("#ahp-2-" + (i+1) + " > tbody tr").each(function() {
			var tr = jQuery(this);
			tr.children("th:gt(0)").each(function() {
				var th = jQuery(this);
				var val = th.find("input").val();
				b += val + ",";
			});
			b = b.substring(0, b.length-1);
			b += ";"
		});
		b = b.substring(0, b.length-1);
		b += "]";
		B[i] = b;
	}
	
	jQuery.ajax({
		type: "POST",
		url: "GdWaterServlet",
		context: this,
		data: {
			servicename : "ahp-db-service",
			servicetype : "calculate-result",
			"ahppollutiontype[]" : ahppollutiontype,
			"ahpindex[]" : ahpindex,
			"A" : A,
			"B[]" : B
		},
		success: function(data) {
			if (data.success_calculate_result) {
				//第一层
				var s = data.s;
				var weightvector1 = data.weightvector1;
				var lamuda = data.lamuda;
				var consistantindex = data.consistantindex;
				var consistantratiomsg = data.consistantratiomsg;
				
				//第二层
				var b = data.b;	
				var weightvector2 = data.weightvector2;
				var lamuda1 = data.lamuda1;
				var consistantindex1 = data.consistantindex1;
				var _consistantratiomsg = data._consistantratiomsg;
				
				var ahptab3 = "<div class='col-sm-9'>";
				ahptab3 += "<p>第一层污染类型（准则层）判断矩阵归一化后的矩阵</p>";
				ahptab3 += "<div class='table-responsive' " +
				"style='text-align:center;'><table " +
				"class='table table-bordered mb10'><tbody>";
				for (var i=0; i<ahppollutiontype.length; i++) {
					ahptab3 += "<tr>";
					for (var j=0; j<ahppollutiontype.length; j++) {
						ahptab3 += "<th style='text-align:center;'>" +
						s[i][j] + "</th>";
					}
					ahptab3 += "</tr>";
				}
				ahptab3 += "<tr><th colspan='" + (ahppollutiontype.length-1) +
				"' style='text-align:center;'>准则层判断矩阵归一化矩阵的特征值&lambda;</th>" +
				"<th style='text-align:center;'>" + lamuda + "</th></tr>";
				ahptab3 += "<tr><th colspan='" + (ahppollutiontype.length-1) + 
				"' style='text-align:center;'>一致性指数 CI</th><th " +
				"style='text-align:center;'>" + consistantindex + "</th></tr>";
				ahptab3 += "</tbody></table></div>";
				ahptab3 += "<p>第一层污染类型（准则层）权重矩阵</p>";
				ahptab3 += "<div class='table-responsive' " +
				"style='text-align:center;'><table " +
				"class='table table-info table-bordered mb10'><thead><tr>";
				for (var i=0; i<ahppollutiontype.length; i++) {
					ahptab3 += "<th style='text-align:center;'>" + 
					ahppollutiontype[i] + "</th>";
				}
				ahptab3 += "</tr></thead><tbody><tr>";
				for (var i=0; i<ahppollutiontype.length; i++) {
					ahptab3 += "<th style='text-align:center;'>" + 
					weightvector1[i] + "</th>";
				}
				ahptab3 += "</tr><tr><th colspan='" + ahppollutiontype.length + 
				"'>" + consistantratiomsg + "</th></tr>";
				ahptab3 += "</tbody></table></div>";
				ahptab3 += "<p>第二层污染指标（方案层）各项权重矩阵</p>";
				
				for (var i=0; i<ahppollutiontype.length; i++) {
					ahptab3 += "<p style='text-align:center'>" + ahppollutiontype[i] + "</p>";
					ahptab3 += "<div class='table-responsive' style='text-align:center;'>";
					ahptab3 += "<table class='table table-bordered mb10'><tbody>";
					
					for (var j=0; j<b[i].length; j++) {
						ahptab3 += "<tr>";
						for (var k=0; k<b[i].length; k++) {
							ahptab3 += "<th style='text-align:center;'>" +
							b[i][j][k] + "</th>";
						}						
					}
					ahptab3 += "</tr><tr><th style='text-align:center;'>判断矩阵归一化矩阵的特征值&lambda;" +  
						"</th><th style='text-align:center;' colspan='" + (b[i].length-1) + "'>" +
						lamuda1[i] + "</th></tr><tr><th style='text-align:center;'>一致性指数 CI</th>" +
						"<th style='text-align:center;' colspan='" + (b[i].length-1) + "'>" +
						consistantindex1[i] + "</th></tr>";
					ahptab3 += "</tbody></table></div>";
				}
				
				ahptab3 += "<p>第二层污染指标（方案层）各权重矩阵</p>";
				for (var i=0; i<ahppollutiontype.length; i++) {
					ahptab3 += "<p style='text-align:center'>" + ahppollutiontype[i] + "</p>";
					ahptab3 += "<div class='table-responsive' style='text-align:center;'>";
					ahptab3 += "<table class='table table-info table-bordered mb10'><thead><tr>";
					
					for (var j=0; j<ahpindex[i].length; j++) {
						ahptab3 += "<th style='text-align:center;'>" +
						ahpindex[i][j] + "</th>";
					}
					ahptab3 += "</tr></thead><tbody><tr>";
					for (var j=0; j<ahpindex[i].length; j++) {
						ahptab3 += "<th style='text-align:center;'>" +
						weightvector2[i][j] + "</th>";
					}
					ahptab3 += "</tr><tr><th colspan='" + ahpindex[i].length + "'>" +
							_consistantratiomsg[i] + "</th>";
					ahptab3 += "</tr></tbody></table></div>";
				}
				
				ahptab3 += "</div>";
				
				jQuery("#ahptab3").append(ahptab3);
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
/**
 * Create by GeekCarnegie On 2015-09-12
 */

// 污染类型
var alarmpollutiontype = new Array();
// 预警模型
var alarmmodel = "案例分析模型";
// 污染指标
var alarmindex = new Array();

jQuery(document).ready(function() {
	"use strict";

	// Page Preloader
	jQuery("#preloader_alarm").delay(3000).fadeOut(function() {
		jQuery("#contentpanel_func_3").delay(1000).css({
			"overflow" : "visible"
		});
	});
	
	// Wizard
	jQuery('#alarmWizard').bootstrapWizard(
			{
				'nextSelector' : '.next',
				'previousSelector' : '.previous',
				onNext : function(tab, navigation, index) {
					var $total = navigation.find('li').length;
					var $current = index + 1;
					
					if ($current === 2) {
						var pollutiontype = "";
						if (jQuery("#alarm_pollutiontype").select2("data")) {
							pollutiontype = jQuery("#alarm_pollutiontype").select2("data").text;
						} else {							
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
						
						jQuery.ajax({
							type: "POST",
							url: "GdWaterServlet",
							context: this,
							data: {
								servicename: "alarm-db-service",
								servicetype: "get-alarm-index",
								pollutiontype: pollutiontype
							},
							success: function(data) {
								if (data.success_get_alarm_index) {
									jQuery("#alarmtab2").empty();
									var len = data.alarmindex.length;
									alarmindex = data.alarmindex;
									var buildindex = "<div class='mt20'></div>"
										+ "<h3 class='panel-title' style='"
										+ "font-size:14px;font-weight:bold'"
										+ ">污染指标观测值：</h3><div class='mt20'>"
										+ "</div><div class='table-responsive'>"
										+ "<table class='table table_alarmindex' id='"
										+ "table_alarm_index'><tbody>";
									
									for (var i=0; i<len; i++) {
										buildindex += "<tr><td><div class='media'>"
											+ "<div class='media-body'><span class='ml50'>"
											+ "</span><div style='"
											+ "width:100px;text-align:center;display:inline;'>"
											+ data.alarmindex[i]
											+ "</div></td><td><input "
											+ "type='text' id='alarmindex-' " + i 
											+ "class='form-control' style='width:500px;"
											+ "height:35px;display:inline;' />"
											+ "</div></div></td></tr>";
									}
									
									buildindex += "</tbody></table></div>";
									
									jQuery("#alarmtab2").append(buildindex);
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
						
					} else if ($current === 3) {
						var result = "<h3 class='panel-title' style='font-size:14px;"
							+ "font-weight:bold'>计算结果</h3>"
							+ "<table width='100%' border='1' cellspacing='0'"
							+ "cellpadding='0' bordercolor='#a9a9a9' class='alarm_table' "
							+ "style='margin-top:20px;'><tbody>"
							+ "<tr class='alarm_table_title'><td align='center'>"
							+ "</td><td>水质污染指标是否超标</td></tr><tr "
							+ "class='alarm_table_cont'><td>结果</td><td>超标</td>"
							+ "</tr></tbody></table><table "
							+ "width='50%' border='1' cellspacing='0' cellpadding='0' "
							+ "bordercolor='#a9a9a9' class='alarm_table' style='float:left;"
							+ "margin-top:20px;'><tbody><tr><td "
							+ "colspan='3' class='alarm_table_title'>案例相似度</td></tr><tr "
							+ "class='alarm_table_cont' height='0'><td width='15%'>序号</td>"
							+ "<td width='60%'>污染记录</td><td width='25%'>相似度</td></tr>"
							+ "<tr><td>1</td><td>污染源1被污染</td><td>0.6</td></tr>"
							+ "<tr><td>2</td><td>污染源2被污染</td><td>0.9</td></tr>"
							+ "<tr><td>3</td><td>污染源3被污染</td><td>0.2</td></tr>"
							+ "<tr><td>4</td><td>污染源4被污染</td><td>0.8</td></tr>"
							+ "<tr><td>5</td><td>污染源5被污染</td><td>0.7</td></tr>"
							+ "</tbody></table><table width='70%' "
							+ "border='1' cellspacing='0' cellpadding='0' bordercolor='#a9a9a9' "
							+ "class='alarm_table' style='float:left;margin-top:20px;'><tbody><tr>"
							+ "<td colspan='" + (alarmindex.length + 2) + "' class='alarm_table_title'>" 
							+ "因素相似度</td></tr><tr class='alarm_table_cont'><td width='10%'>序号</td>"
							+ "<td width='25%'>案例名称</td>";
						
						for (var i=0; i<alarmindex.length; i++) {
							result += "<td width='" + 64/alarmindex.length + "%'>"
								+ alarmindex[i]	+ "</td>";
						}
						result += "</tr>";
						
						for (var i=1; i<6; i++) {
							result += "<tr><td>" + i + "</td><td>污染源" + i + "被污染</td>" ;
							
							for (var j=0; j<alarmindex.length; j++) {
								result += "<td>0.5</td>"; 
							}
							
							result += "</tr>";
						}
						
						
						result += "</tbody></table>";
						jQuery("#alarmtab3").append(result);
					}

					var $percent = ($current / $total) * 100;
					jQuery('#alarmWizard').find('.progress-bar').css(
								'width', $percent + '%');
					
				},
				onPrevious : function(tab, navigation, index) {
					var $total = navigation.find('li').length;
					var $current = index + 1;
					var $percent = ($current / $total) * 100;
					jQuery('#alarmWizard').find('.progress-bar').css(
							'width', $percent + '%');
				},
				onTabShow : function(tab, navigation, index) {
					var $total = navigation.find('li').length;
					var $current = index + 1;
					var $percent = ($current / $total) * 100;
					jQuery('#alarmWizard').find('.progress-bar').css(
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
	
	// Select2
	jQuery("#alarm_pollutiontype").select2({
		width : '100%',
		minimumResultsForSearch : -1
	});
	
	jQuery("#alarm-model button").on("click", function(){
		var button = jQuery(this);
		alarmmodel = button.text().replace(/\s+/g, "");
	});
	
	getAlarmPollutionType();	
});

function getAlarmPollutionType() {	
	alarmpollutiontype = new Array();
	jQuery.ajax({
		type: "POST",
		url: "GdWaterServlet",
		context: this,
		data: {
			servicename: "alarm-db-service",
			servicetype: "get-alarm-pollution-type"
		},
		success: function(data) {
			if (data.success_get_alarm_pollution_type) {
				var len = data.alarmpollutiontype.length;
				alarmpollutiontype = data.alarmpollutiontype;
				
				for (var i=0; i<len; i++) {
					var option = "<option value='" + alarmpollutiontype[i] + "'>"
						+ alarmpollutiontype[i] + "</option>";
					
					jQuery("#alarm_pollutiontype").append(option);
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
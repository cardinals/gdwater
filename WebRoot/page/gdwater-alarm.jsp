<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta name="pragma" content="no-cache">
	<meta name="cache-control" content="no-cache">
	<meta name="expires" content="0">

	<link rel="stylesheet" href="css/style.default.css" />
  </head>
  
  <body>
    <div class="contentpanel" id="contentpanel_func_3">
    	<div id="preloader_alarm" class="preloader_contentpanel">
			<div id="status">
				<i class="fa fa-spinner fa-spin"></i>
			</div>
		</div>
		
		<section>
			<div class="row">
				<div class="col-sm-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<div class="panel-btns">
				                <a href="" class="panel-close">&times;</a>
				                <a href="" class="minimize">&minus;</a>
			              	</div>
			              	
			              	<h4 class="panel-title">地下水污染类型报警预警系统</h4>
						</div>
						
						<div class="panel-body panel-body-nopadding">
		              		<!-- BASIC WIZARD -->
							<div id="alarmWizard" class="basic-wizard">
								<ul class="nav nav-pills nav-justified">
			                    	<li><a href="#alarmtab1" data-toggle="tab"><span>步骤一:</span> 选择预警模型</a></li>
				                    <li><a href="#alarmtab2" data-toggle="tab"><span>步骤二:</span> 输入计算参数</a></li>
				                    <li><a href="#alarmtab3" data-toggle="tab"><span>步骤三:</span> 计算结果</a></li>
				                </ul>
				                
				                <div class="tab-content">
				                	<div class="progress progress-striped active">
				                    	<div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
			                    	</div>
			                    	
			                    	<div class="tab-pane" id="alarmtab1">
		                    			<h3 class="panel-title" style="font-size:14px;font-weight:bold;">请选择污染源的污染类型</h3>
			                    		<div class="mt20"></div>
			                    		<div style="width:400px;">
			                    			<select class="select2" data-placeholder="请选择一个污染类型" 
											id="alarm_pollutiontype">
												<option></option>
											</select>
											<label class="error" for="alarm_pollutiontype"></label>
			                    		</div>
			                    		<div class="mt20"></div>
			                    		<h3 class="panel-title" style="font-size:14px;font-weight:bold;">请选择预警的模型</h3>
			                    		<div class="mt20"></div>
			                    		<div style="width:400px;">
			                    			<div class="btn-group mr10" id="alarm-model">
			                    				<button  class="btn btn-sm btn-default"  type="button" 
			                    				style="width:120px;height:40px;font-size:14px;
			                    				border-radius:4px;-webkit-border-radius:4px;
			                    				-moz-border-radius:4px;" id="model-cbr">
													案例分析模型
												</button>
												
												<button  class="btn btn-sm btn-default"  type="button" 
			                    				style="width:120px;height:40px;font-size:14px;
			                    				border-radius:4px;-webkit-border-radius:4px;
			                    				-moz-border-radius:4px;" id="model-fuzzy">
													模糊推理模型
												</button>
												
												<button  class="btn btn-sm btn-default"  type="button" 
			                    				style="width:120px;height:40px;font-size:14px;
			                    				border-radius:4px;-webkit-border-radius:4px;
			                    				-moz-border-radius:4px;" id="model-ann">
													神经网络模型
												</button>
			                    			</div>
			                    		</div>
			                    	</div>
			                    	
			                    	<div class="tab-pane" id="alarmtab2"></div>
			                    	<div class="tab-pane" id="alarmtab3"></div>
				                </div>
				                
				                <ul id="ahppager" class="pager wizard">
		                    		<li class="previous"><a href="javascript:void(0)">上一步</a></li>
			                    	<li class="next"><a href="javascript:void(0)">下一步</a></li>
		                  		</ul>
							</div>							
		              	</div>
						
					</div>
				</div>
			</div>
		</section>
    </div>
    
    <script type="text/javascript" charset="utf-8">
		jQuery.getScript("scripts/js/gdwater-alarm.js");
	</script>
  </body>
</html>

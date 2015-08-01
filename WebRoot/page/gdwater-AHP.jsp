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

</head>
  
<body>
	<div class="contentpanel" id="contentpanel_func_2">
		<div id="preloader_AHP" class="preloader_contentpanel">
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
			              	<h4 class="panel-title">地下水污染类型指标评价系统</h4>
			              	<div class="col-sm-6">
	              				<p>内容及操作方法：</p>
	              				<p>（1）分析系统中各因素之间的关系，对同一层次各元素关于上一层次中某一准则的重要性进行两两比较，
	              				构造两两比较的判断矩阵，具体判断标准见表1</p>
	              				<p>（2）由判断矩阵计算被比较元素对于该准则的相对权重，并进行判断矩阵的一致性检验</p>
	              				<p>（3）计算各层次对于系统的总排序权重，并进行排序</p>
	              				<p>（4）最后，得到各方案对于总目标的总排序</p>
              				</div>
              				<div>
              					<div class="table-responsive" style="text-align:center;">
              						<p>表1：比例标度表</p>
              						<table class="table table-bordered mb10" style="width:400px; margin-left:auto; margin-right:auto;'">
              							<thead>
              								<tr>
              									<th style="text-align:center;">比例标度表</th>
              									<th style="text-align:center;">量化值</th>
              								</tr>
              							</thead>
              							<tbody>
              								<tr>
              									<th style="text-align:center;">同等重要</th>
              									<th style="text-align:center;">1</th>
              								</tr>
              								<tr>
              									<th style="text-align:center;">稍微重要</th>
              									<th style="text-align:center;">3</th>
              								</tr>
              								<tr>
              									<th style="text-align:center;">较强重要</th>
              									<th style="text-align:center;">5</th>
              								</tr>
              								<tr>
              									<th style="text-align:center;">强烈重要</th>
              									<th style="text-align:center;">7</th>
              								</tr>
              								<tr>
              									<th style="text-align:center;">极强重要</th>
              									<th style="text-align:center;">9</th>
              								</tr>
              								<tr>
              									<th style="text-align:center;">两相邻判断的中间值</th>
              									<th style="text-align:center;">2,4,6,8</th>
              								</tr>
              							</tbody>
              						</table>
              					</div>
              				</div>
						</div>
						
						<div class="panel-body panel-body-nopadding">
						
							<!-- BASIC WIZARD -->
							<div id="ahpWizard" class="basic-wizard">
								<ul class="nav nav-pills nav-justified">
				                  <li><a href="#ahptab1" data-toggle="tab"><span>步骤一:</span> 构造第一层矩阵</a></li>
				                  <li><a href="#ahptab2" data-toggle="tab"><span>步骤二:</span> 构造第二层矩阵</a></li>
				                  <li><a href="#ahptab3" data-toggle="tab"><span>步骤三:</span> 计算结果</a></li>
				                </ul>
				                
				                <div class="tab-content">
				                	<div class="progress progress-striped active">
					                    <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
				                    </div>
				                    
				                    <div class="tab-pane" id="ahptab1">
				                    	<h4 class="panel-title">构造第一层矩阵</h4>
				                    	<p>请为第一层矩阵（污染类型）打分：</p>
				                    	<div class="row">
				                    		<div class="table-responsive" style="text-align:center;">
				                    			<p>表2：第一层次矩阵</p>
				                    			<table class="table table-info table-bordered mb30" id="ahp-1">
				                    				<thead></thead>
				                    				<tbody></tbody>
				                    			</table>
				                    		</div>
				                    	</div>
				                    </div>
				                    
				                    <div class="tab-pane" id="ahptab2">
				                    	<h4 class="panel-title">构造第二层矩阵</h4>
				                    	<p>请为第二层各个矩阵（各污染类型下的用户自定义指标）打分：</p>
				                    </div>
				                    
				                    <div class="tab-pane" id="ahptab3"></div>
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
		jQuery.getScript("scripts/js/gdwater-AHP.js");
	</script>
</body>
</html>
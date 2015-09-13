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

<script type="text/javascript" src="scripts/js/gdwater-index-allo.js"
	charset="utf-8"></script>
</head>

<body>
	<div class="contentpanel" id="contentpanel_func_1_2">
		<div id="preloader_index_allo" class="preloader_contentpanel">
			<div id="status">
				<i class="fa fa-spinner fa-spin"></i>
			</div>
		</div>

		<section>			
			<div class="col-sm-12">
				<div class="row">
					<div class="panel panel-default">
						<div class="panel-heading">
							<div class="panel-btns">
				                <a href="" class="panel-close">&times;</a>
				                <a href="" class="minimize">&minus;</a>
			              	</div><!-- panel-btns -->
			              	<h3 class="panel-title">为不同污染类型分配指标：</h3>
						</div>
						<div class="panel-body">
							<p>
								<span style="font-size:16px;">请选择污染类型：</span>
							</p>
							<div class="row">
								<div class="col-sm-3">
									<select class="select2" data-placeholder="请选择一个污染类型" 
									id="select_pollutiontype">
										<option></option>
									</select>
									<label class="error" for="select_pollutiontype"></label>
								</div>
								<div class="col-sm-3">
									<a href="ajax/add-pollutiontype.html"
										class="btn btn-primary tooltips" data-toggle="modal"
										data-target="#new_pollutiontype" title="增加污染类型" 
										data-placement="top">
										添加污染类型
									</a>
								</div>
							</div>
							<p>
								<span style="font-size:16px;">请为选定污染类型分配指标：</span>
							</p>
							<div class="row">
								<div class="index_panel" id="index_container">
									<div class="col-sm-3"></div>
									<div class="col-sm-3"></div>
									<div class="col-sm-3"></div>
									<div class="col-sm-3"></div>
								</div>
							</div>
							
							<p class="mb20"></p>
							
							<button type="button" class="btn btn-primary"
								id="save_checked_index" style="float:right; 
								margin-right:20px;">保存</button>
						</div>
					</div>
					
					
				</div>
			</div>
<!-- 			<div class="col-sm-12">
				<div class="row">
					<div class="col-sm-12">
						<p>
							<span style="font-size:16px;">请为不同污染类型指定自定义指标：</span>
						</p>
						<div class="table-responsive">
							<table class="table table-info mb30" id="user_index_allo" style="postion:absolute;">
								<thead>
									<tr>
										<th style="text-align:center;">#</th>                        
			                      	</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<button type="button" class="btn btn-primary"
							id="save_checked_index" style="float:right; margin-right:20px;">保存</button>
					</div> 
				</div>
			</div> -->
		</section>
	</div>
	
	<div id="new_pollutiontype" class="modal bs-modal-panel" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content"></div>
		</div>
	</div>
</body>
</html>
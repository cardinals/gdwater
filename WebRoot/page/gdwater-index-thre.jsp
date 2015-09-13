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
	<div class="contentpanel" id="contentpanel_func_1_3">
		<div id="preloader_index_thre" class="preloader_contentpanel">
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
			              	</div><!-- panel-btns -->
			              	<h3 class="panel-title">自定义指标分配阈值</h3>
						</div>
						<div class="panel-body">
							<p>
								<span style="font-size:16px;">请选择污染类型：</span>
							</p>
							<p>
								<span style="font-size:16px;">请为自定义指标输入阈值大小：</span>
							</p>
							<div class="row">
								<div class="col-sm-3">
									<select class="select2" data-placeholder="请选择一个污染类型" 
									id="thre_pollutiontype">
										<option></option>
									</select>
									<label class="error" for="thre_pollutiontype"></label>
								</div>
							</div>
							<form
								class="pull-right btn-group mr10 searchform searchform_index_thre">
								<input type="text" class="form-control" placeholder="搜索..." />
							</form>
							<div class="table-responsive">
								<table class="table table-index" id="table_selected_index">
									<tbody></tbody>
								</table>
								<div class="am-cf">
									<div class="mb20"></div>
									<span>共 条记录</span>
									<div class="am-fr">
										<ul class="am-pagination" id="pagination_thre"></ul>
									</div>
								</div>
							</div>
							<button type="button" class="btn btn-primary" id="save_index_thre"
								style="float:right; margin-right:20px;">保存</button>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>

	<script type="text/javascript" charset="utf-8">
		jQuery.getScript("scripts/js/gdwater-index-thre.js");
	</script>
</body>
</html>
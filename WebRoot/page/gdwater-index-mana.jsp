<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html lang="zh">
<head>
<base href="<%=basePath%>">

<meta name="pragma" content="no-cache">
<meta name="cache-control" content="no-cache">
<meta name="expires" content="0">

</head>
<body>
	<div class="contentpanel" id="contentpanel_func_1_1">
		<div id="preloader_index_mana" class="preloader_contentpanel">
			<div id="status">
				<i class="fa fa-spinner fa-spin"></i>
			</div>
		</div>

		<section>
			<div class="row">
				<div class="col-sm-3 col-lg-2">
					<div class="index-mana">污染类型</div>
					<ul id="type-index"
						class="nav nav-pills nav-stacked nav-index-mana">
						<li class="active"><a href="javascript:void(0)" id="gn-index">
								常规指标 </a></li>
						<li><a href="javascript:void(0)" id="ct-index"> 特征指标 </a></li>
						<li><a href="javascript:void(0)" id="ot-index"> 其他指标 </a></li>
					</ul>
				</div>

				<div class="col-sm-9 col-lg-10">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="pull-right">
								<form class="btn-group mr10 searchform searchform_index_mana">
									<input type="text" class="form-control" placeholder="搜索..." />
								</form>
								<div class="btn-group mr10" id="btn-mana">
									<a href="ajax/add-index.html"
										class="btn btn-sm btn-white tooltips" data-toggle="modal"
										data-target="#new_index" title="增加" data-placement="top">
										<i class="glyphicon glyphicon-plus"></i>
									</a>
									<button
										class="btn btn-sm btn-white index_button_refresh tooltips"
										type="button" data-toggle="tooltip" data-placement="top"
										title="刷新">
										<i class="glyphicon glyphicon-refresh"></i>
									</button>
									<button
										class="btn btn-sm btn-white tooltips index_button_remove"
										type="button" data-toggle="tooltip" data-placement="top"
										title="删除">
										<i class="glyphicon glyphicon-trash"></i>
									</button>
								</div>
							</div>
							<!-- pull-right -->

							<h5 class="subtitle mb5" style="font-size: 16px;">指标列表</h5>
							<p class="text-muted">
								<span>常规指标</span>
							</p>

							<div class="mb20"></div>

							<div class="table-responsive">
								<table class="table table-index" id="table_all_index">
									<tbody></tbody>
								</table>
								<div class="am-cf">
									<div class="mb20"></div>
									<span>共 条记录</span>
									<div class="am-fr">
										<ul class="am-pagination" id="pagination_mana"></ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>

	<div id="new_index" class="modal bs-modal-panel" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content"></div>
		</div>
	</div>

	<!-- <script type="text/javascript" charset="utf-8" src="scripts/js/gdwater-index-mana.js"></script> -->
	<script type="text/javascript" charset="utf-8">
		jQuery.getScript("scripts/js/gdwater-index-mana.js");
	</script>
</body>
</html>
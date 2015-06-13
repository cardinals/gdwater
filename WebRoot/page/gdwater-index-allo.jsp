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
			<div class="row">
				<div class="col-sm-12">
					<p>
						<span style="font-size:16px;">请选择自定义指标</span>
					</p>
					<div id="index_panel">
						<div class="col-md-4"></div>
						<div class="col-md-4"></div>
						<div class="col-md-4"></div>
					</div>
					<div class="mb20"></div>
					<button type="button" class="btn btn-primary"
						id="save_checked_index" style="float:right; margin-right:20px;">保存</button>
				</div>
			</div>
		</section>
	</div>
</body>
</html>
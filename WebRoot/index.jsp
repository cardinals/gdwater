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

<title>地下水污染应急监测及预警决策支持系统</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="pragma" content="no-cache">
<meta name="cache-control" content="no-cache,must-revalidate">
<meta name="expires" content="0">
<meta name="keywords" content="地下水,应急,监测,预警,决策支持,系统">
<meta name="description" content="地下水应急监测及预警决策支持系统首页">

<script type="text/javascript" src="scripts/jquery-1.11.1.min.js"
		charset="utf-8"></script>
		
<script type="text/javascript">
	var init = document.createElement('script');
	init.type = 'text/javascript';
	init.async = false;
	init.src = 'http://localhost/arcgis_js_v39_sdk/arcgis_js_api/library/3.9/3.9compact/init.js';
	var x = document.getElementsByTagName('script')[0];
	x.parentNode.insertBefore(init, x);
</script>

<link type="text/css" rel="stylesheet" href="css/jquery.gritter.css" />
<link type="text/css" rel="stylesheet" href="css/style.default.css" />

</head>

<body style="height:3100px;">
	<div id="preloader" class="preloader">
		<div id="status">
			<i class="fa fa-spinner fa-spin"></i>
		</div>
	</div>

	<section>
		<div class="leftpanel"><jsp:include page="leftpanel.jsp"
				flush="true" /></div>
		<div class="mainpanel" style="height:100%;">
			<div id="header"><jsp:include page="header.jsp" flush="true" /></div>
			<div class="contentpanel">
				<jsp:include page="content.jsp" flush="true" />
			</div>
		</div>
	</section>
	
	<script type="text/javascript" src="scripts/jquery-ui.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" src="scripts/bootstrap.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" charset="utf-8" 
		src="scripts/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="scripts/modernizr.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" src="scripts/retina.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" src="scripts/toggles.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" src="scripts/jquery.gritter.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" src="scripts/bootstrap-wizard.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" src="scripts/select2.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" src="scripts/jquery.sparkline.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" src="scripts/flot/jquery.flot.min.js"
		charset="utf-8"></script>
	<script type="text/javascript" charset="utf-8"
		src="scripts/flot/jquery.flot.resize.min.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="scripts/flot/jquery.flot.symbol.min.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="scripts/flot/jquery.flot.categories.min.js"></script>
	<script type="text/javascript" src="scripts/morris.min.js"
		charset="utf-8"></script>
	<!-- <script type="text/javascript" src="scripts/raphael-2.1.0.min.js"
		charset="utf-8"></script> -->

	<script type="text/javascript" src="scripts/custom.js" charset="utf-8"></script>
</body>
</html>

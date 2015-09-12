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
<meta name="cache-control" content="no-cache">
<meta name="expires" content="0">
<meta name="keywords" content="keyword1,keyword2,keyword3">
<meta name="description" content="This is index page">

<!-- <script type="text/javascript" charset="utf-8">
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "http://localhost/arcgis_js_api/library/3.9/3.9compact/init.js", true);
	xhr.send();
		
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "http://localhost/arcgis_js_api/library/3.9/3.9compact/js/dojo/dojo/dojo.js", true);
	xhr.send();
</script> -->

<script type="text/javascript"> 
	var init = document.createElement('script');
	init.type = 'text/javascript';
	init.async = false;
	init.src = 'http://localhost/arcgis_js_api/library/3.9/3.9compact/init.js'; 
	var x = document.getElementsByTagName('script')[0]; 
	x.parentNode.insertBefore(init, x); 
</script>

<script type="text/javascript" src="scripts/jquery-1.11.1.min.js"
	charset="utf-8"></script>
<script type="text/javascript" src="scripts/jquery-ui.min.js"
 	charset="utf-8"></script>
<script type="text/javascript" src="scripts/bootstrap.min.js"
	charset="utf-8"></script>
<script type="text/javascript" src="scripts/jquery-migrate-1.2.1.min.js"
	charset="utf-8"></script>
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
<script type="text/javascript" src="scripts/custom.js" charset="utf-8"></script>

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
</body>
</html>

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
	<div class="contentpanel" id="contentpanel_func_4">
		<div id="preloader_simulation" class="preloader_contentpanel">
			<div id="status">
				<i class="fa fa-spinner fa-spin"></i>
			</div>
		</div>
		
		<section>
			
		</section>
	</div>
	
	<script type="text/javascript" charset="utf-8">
		jQuery.getScript("scripts/js/gdwater-simulation.js");
	</script>
</body>
</html>

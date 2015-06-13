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
<meta name="keywords" content="keyword1,keyword2,keyword3">
<meta name="description" content="This is my page">

</head>

<body>
	<div class="headerbar" id="headerbar">
		<a class="menutoggle"><i class="fa fa-bars"></i></a> <img
			src="images/banner.jpg" width="400" height="44" alt="banner"
			style="float:left" />
		<div class="header-right">
			<ul class="headermenu">
				<li>
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown">
							John Doe <span class="caret"></span>
						</button>
						<ul class="dropdown-menu dropdown-menu-usermenu pull-right">
							<li><a href="#"><i class="glyphicon glyphicon-cog"></i>
									系统设置</a></li>
							<li><a href="#"><i
									class="glyphicon glyphicon-question-sign"></i> 帮助</a></li>
							<li><a href="#"><i class="glyphicon glyphicon-log-out"></i>
									登出</a></li>
						</ul>
					</div>
				</li>

				<li>
					<div class="btn-group">
						<button class="btn btn-default dropdown-toggle">管理员</button>
					</div>
				</li>
			</ul>
		</div>
		<!-- header-right -->
		<div class="cur-time"></div>
		<!-- Time -->
		<br style="clear:both;" />
	</div>
</body>
</html>

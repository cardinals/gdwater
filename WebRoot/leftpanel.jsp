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
	<div class="logopanel">
		<h1>
			<span>控制面板</span>
		</h1>
	</div>
	<!-- logopanel -->

	<div class="leftpanelinner">
		<h3 class="sidebartitle">导航</h3>
		<ul class="nav nav-pills nav-stacked nav-bracket"
			style="font-weight:bold">
			<li class="active"><a href="index.jsp" data-name="func-0"><i class="fa fa-home"></i>
					<span>首页</span></a></li>
			<li class="nav-parent"><a href="javascript:void(0)"
				data-name="func-1"><i class="fa fa-database"></i> <span>指标库</span></a>
				<ul class="children">
					<li><a href="javascript:void(0)" data-name="func-1-1"><i
							class="fa fa-caret-right"></i> 指标管理</a></li>
					<li><a href="javascript:void(0)" data-name="func-1-2"><i
							class="fa fa-caret-right"></i> 指标分配</a></li>
					<li><a href="javascript:void(0)" data-name="func-1-3"><i
							class="fa fa-caret-right"></i> 指标阈值</a></li>
				</ul></li>
			<li><a href="javascript:void(0)" data-name="func-2"><i
					class="fa fa-check"></i> <span>专家评分</span></a></li>
			<li><a href="javascript:void(0)" data-name="func-3"><i
					class="fa fa-eye"></i> <span>应急决策</span></a></li>
			<li><a href="javascript:void(0)" data-name="func-4"><i
					class="fa fa-map-marker"></i> <span>三维仿真</span></a></li>
			<li><a href="javascript:void(0)" data-name="func-5"><i
					class="fa fa-files-o"></i> <span>预案管理</span></a></li>
			<li><a href="javascript:void(0)" data-name="func-6"><i
					class="fa fa-history"></i> <span>历史库及事故报告</span></a></li>
			<li><a href="javascript:void(0)" data-name="func-7"><i
					class="fa fa-comments-o"></i> <span>后评估</span></a></li>
			<li><a href="javascript:void(0)" data-name="func-8"><i
					class="fa fa-tags"></i> <span>行业规范</span></a></li>
			<li><a href="javascript:void(0)" data-name="func-9"><i
					class="fa fa-user"></i> <span>用户管理</span></a></li>
		</ul>
	</div>
</body>
</html>

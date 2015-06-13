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
</head>

<body>
	<div class="row">
		<!-- Nav tabs -->
		<ul class="nav nav-tabs nav-dark" id="tabs-nav">
			<li class="active" id='func-0'><a href="#content-des" data-toggle="tab">
					<i class='fa fa-home'></i> <strong>首页</strong>
			</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content mb30" id="tabs-panel">
			<div class="tab-pane active" id="content-des">
				<div class="content-des">
					<div class="title">地下水污染应急监测及预警决策系统</div>
					<div class="mb20"></div>
					<p>
						<span class="para">①地下水污染事故应急管理技术框架编制</span>
					</p>
					<p>
						<span class="para">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;基于我国已有的环境管理政策、法律、法规体系，
							根据不同地下水利用方式、敏感受体情况等环境管理需求，主要参照我国相关地下水质量标准、
							灌溉用水标准等相关技术标准，以地下水质量评价为主要判别依据，提出地下水突发污染应急处理目标值；
							适度考虑地下水污染造成的长期人体健康风险监测需求，采用计算机模拟技术，模拟预测地下水污染物时空变化，
							归纳总结事故应急快速监测技术及地下水污染应急处置技术方案与程序的建立方法，
							设计地下水突发污染事故的应急管理技术框架，包括制度控制、工程控制与主动修复。
							针对不同的污染事故和水文地质条件，提出常用的应急管理技术及其适用条件和使用效果等。 技术管理体系架构如图1示例。</span>
					</p>
					<div class="mb10"></div>
					<br />
					<div class="img">
						<img src="images/des/des1.jpg" alt="" /><br /> <span>图1
							事故应急管理技术框架示例</span>
					</div>
					<div class="mb10"></div>
					<p>
						<span class="para">②地下水污染监控预警和事故应急决策支持系统框架设计</span>
					</p>
					<p>
						<span class="para">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;主要包括数据标准规范研究、数据库建设、系统研发及系统运行维护等内容。
							数据库包括空间数据库和属性数据库。空间数据库（预警支持库）包括基础地理数据库、遥感影像数据库、水文气象数据库、风险源数据库、
							敏感对象数据库、水文地质数据库、地下水监测数据库等；属性数据库（决策支持库）包括地下水污染预警指标库、
							地下水污染预警模型库、地下水标准规范库、专家库、应急处置数据库等。数据库结构体系初步设计见图2。</span>
					</p>
					<div class="mb10"></div>
					<p>
						<span class="para">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;地下水污染监控预警与事故应急决策支持系统拟利用计算机技术、
							网络技术、数据库技术、图形图像处理技术、数值模拟技术等进行开发。
							系统以PostgreSQL数据库辅以Postgis空间数据库引擎做后台支持，GIS平台软件拟采用ArcGIS Server，
							系统结构使用跨平台的B/S架构。架构设计拟采用目前先进的SOA架构， 基于ArcGIS
							Server提供数据管理及地图服务功能，基于PostgreSQL数据库实现空间数据及属性数据管理。
							系统逻辑上拟分为5个层次，即硬件层、数据层、应用层、功能层、用户层。</span>
					</p>
					<div class="mb10"></div>
					<br />
					<div class="img">
						<img src="images/des/des2.jpg" alt="" /><br /> <span>图2
							数据库体系结图</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

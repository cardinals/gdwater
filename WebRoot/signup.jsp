<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
<title>用户注册</title>

<meta name="pragma" content="no-cache">
<meta name="cache-control" content="no-cache">
<meta name="expires" content="0">
<meta name="description" content="This is SignUp page">

<link rel="stylesheet" type="text/css" href="css/style.default.css" />
</head>

<body class="signin">
	<section>
	<div class="signuppanel">
		<div class="row">
			<div class="col-md-6">
				<div class="signup-info">
					<div class="logopanel">
						<h1>
							<span>地下水应急监测及预警决策系统</span>
						</h1>
					</div>
					<!-- logopanel -->

					<div class="mb20"></div>

					<h5>
						<strong>欢迎注册成为我们的一员!</strong>
					</h5>

					<p>当您注册成为系统用户后，您会进入系统界面，对系统进行功能操作， 并可调用系统数据库，获取您所需要的数据</p>
					<p>系统可为专业的管理人员提供地下水污染的应急决策支持，并根据 实时监测数据进行预警和现场调度</p>

					<div class="mb20"></div>

					<div class="feat-list">
						<i class="fa fa-laptop"></i>
						<h4 class="text-success">较为完善的决策支持系统</h4>
						<p>系统包含指标库管理、指标评估、应急决策、应急调度、预案管理、事后评估等针对地下水污染做出的一整套应急处理机制，可为管理人员提供较为完善的地下水污染应急解决方案</p>
					</div>

					<div class="feat-list">
						<i class="fa fa-tint"></i>
						<h4 class="text-success">较为逼真的污染物渗流仿真模拟</h4>
						<p>系统实现了三维立体式的污染物沿地表、土壤介质和地下水的运移过程，并在此基础上进行决策和调度</p>
					</div>

					<div class="feat-list">
						<i class="fa fa-sitemap"></i>
						<h4 class="text-success">一体化较为直观的体系结构</h4>
						<p>系统地下水从突发污染前到突发污染过程的后评估整个阶段都做了严密的布控以及应急措施，为预防和尽快治理地下水提供了解决方案</p>
					</div>

					<h4 class="mb20">更多...</h4>

				</div>
				<!-- signup-info -->
			</div>
			<!-- col-md-6 -->

			<div class="col-md-6">
				<form method="post" action="index.jsp">
					<h3 class="nomargin">注册</h3>
					<p class="mt5 mb20">
						已注册? <a href="signin.jsp"><strong>登录</strong></a>
					</p>

					<div class="mb10">
						<label class="control-label">用户名</label> <input type="text"
							class="form-control" />
					</div>

					<div class="mb10">
						<label class="control-label">密&nbsp;&nbsp;码</label> <input
							type="password" class="form-control" />
					</div>

					<div class="mb10">
						<label class="control-label">确认密码</label> <input type="password"
							class="form-control" />
					</div>

					<div class="mb10">
						<label class="control-label">Email</label> <input type="text"
							class="form-control" />
					</div>

					<div class="mb10">
						<label class="control-label">手机号码</label> <input type="text"
							class="form-control" />
					</div>

					<div class="mb20"></div>

					<button class="btn btn-success btn-block">注&nbsp;&nbsp;册</button>
				</form>

			</div>
			<!-- col-sm-6 -->
		</div><!-- row -->

		<div class="signup-footer">
			<div class="pull-left">&copy; 2015. All Rights Reserved.
				中国科学院大学</div>
			<div class="pull-right">
				Created By: <a href="http://www.ucas.ac.cn/" target="_blank">中国科学院大学</a>
			</div>
		</div><!-- signup-footer -->
	</div>
	<!-- signuppanel --> </section>
</body>
</html>

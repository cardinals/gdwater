<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
<title>系统登录</title>

<meta name="pragma" content="no-cache">
<meta name="cache-control" content="no-cache">
<meta name="expires" content="0">
<meta name="description" content="This is sign-in page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link rel="stylesheet" type="text/css" href="css/style.default.css" />
</head>

<body class="signin">
	<section>
	<div class="signinpanel">
		<div class="row">
			<div class="col-md-7">
				<div class="signin-info">
					<div class="logopanel">
						<h1>
							<span>地下水应急监测及预警决策系统</span>
						</h1>

						<div class="mb20"></div>

						<h5>
							<strong>欢迎您访问本系统！</strong>
						</h5>

						<ul>
							<li><i class="fa fa-arrow-circle-o-right mr5"></i> 指标库管理</li>
							<li><i class="fa fa-arrow-circle-o-right mr5"></i> 指标AHP</li>
							<li><i class="fa fa-arrow-circle-o-right mr5"></i> GIS应急决策</li>
							<li><i class="fa fa-arrow-circle-o-right mr5"></i> 预案管理与应急调度</li>
							<li><i class="fa fa-arrow-circle-o-right mr5"></i> 历史库及事故报告</li>
							<li><i class="fa fa-arrow-circle-o-right mr5"></i> 事故后期对比与评估</li>
							<li><i class="fa fa-arrow-circle-o-right mr5"></i> 行业规范</li>
						</ul>

						<div class="mb20"></div>

						<strong>还未注册？<a href="signup.jsp">点击注册</a></strong>
					</div>
					<!-- logopanel -->
				</div>
			</div><!-- col-sm-7 -->

			<div class="col-md-5">
				<form method="post" action="index.jsp">
                    <h4 class="nomargin">用户登录</h4>
                    <p class="mt5 mb20">请输入登录的账号和密码...</p>
                
                    <input type="text" class="form-control uname" placeholder="用户名" />
                    <input type="password" class="form-control pword" placeholder="密码" />
                    
                    <button class="btn btn-success btn-block">登录</button>
                    
                </form>
			</div><!-- col-sm-5 -->
			
		</div><!-- row -->
		
		<div class="signup-footer">
            <div class="pull-left">
                &copy; 2015. All Rights Reserved. 中国科学院大学 
            </div>
            <div class="pull-right">
                Created By: <a href="http://www.ucas.ac.cn/" target="_blank">中国科学院大学</a>
            </div>
        </div>
        
	</div>
	</section>
</body>
</html>

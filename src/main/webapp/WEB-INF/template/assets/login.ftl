<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>login</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${request.contextPath}/static/css/framework.css">
<link rel="stylesheet" href="${request.contextPath}/static/css/index.css">
<script type="text/javascript" src="${request.contextPath}/static/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/common.js"></script>
<script type="text/javascript">
	    
	function login() {
		var name = $('#name').val();
		var password =$('#password').val();
		if (name == '' || name == undefined) {
			
			openAlertw("请输入用户名","warning");
			return; 
		}
		if (password == '' || password == undefined) {
			
			openAlertw("请输入密码","warning");
			return;
		}
		$.post("${request.contextPath}/userlogin/sysUserLogin.do",
			{
				name:name,
				password:password
			},
			function(data) {
				if (data.status == 1) {
					window.location.href = '${request.contextPath}/userinfo/user.do';
				} else {
					openAlertw(data.message,"error");
				}
			}); 
	}
</script>
</head>
<body>
	<div class="backgroud">
		<div class="cloud2">
			<div></div>
			<div></div>
		</div>
		<div class="cloud1">
			<div></div>
			<div></div>
		</div>
	</div>
	<div class="logoin-form">
		<div class="contain">
			<div>
				<p>工业自动化平台</p>
				<h2>IMCloud</h2>
				<form onsubmit="return false;">
					<span id="tishi"></span>
					<input type="text" placeholder="用户名" id="name" name="name">
					<input type="password" placeholder="密码" id="password"
						name="password">
					<button type="submit" onclick="login()">登陆系统</button>
				</form>
				<div class="cp">&copy;Copyright 2016-2018 ceway crop.</div>
			</div>
		</div>
	</div>
</body>
</html>

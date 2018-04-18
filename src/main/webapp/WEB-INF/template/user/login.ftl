<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>login</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript">
	    
	function login() {
		var loginName = $('#loginName').val();
		var loginPwd = $('#loginPwd').val();
		if (loginName == '' || loginName == undefined) {
			
			alert("请输入用户名");
			return; 
		}
		if (loginPwd == '' || loginPwd == undefined) {
			
			alert("请输入密码");
			return;
		}
		$.post("${request.contextPath}/loginController/login.do",
			{
				loginName:loginName,
				loginPwd:loginPwd
			},
			function(data) {
				if (data.code == 200) {
					window.location.href = '${request.contextPath}/assetsController/index.do';
				} else {
					alert(data.msg);
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
				<p>物料系统</p>
				<form onsubmit="return false;">
					<span id="tishi"></span>
					<input type="text" placeholder="用户名" id="loginName" name="loginName"><br/>
					<input type="password" placeholder="密码" id="loginPwd"
						name="loginPwd"><br/>
					<button type="submit" onclick="login()">登陆系统</button>
				</form>
				<div class="cp">&copy;Copyright 2016-2018 ceway crop.</div>
			</div>
		</div>
	</div>
</body>
</html>

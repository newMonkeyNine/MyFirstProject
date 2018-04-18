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

	$(function(){

		initData();
	});

	function initData(){
		$.post("${request.contextPath}/assetsController/select.do",
			{
			},
			function(data) {
				console.log(data);
			},'json'); 
	}


</script>
</head>
<body>
	<a href="${request.contextPath}/loginController/outLogin.do">退出登录</a>
	<p id="show"></p>	
</body>
</html>

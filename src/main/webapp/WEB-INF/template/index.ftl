<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="renderer" content="webkit"/>
        <title>物料系统登录</title>
        <link type="text/css" rel="stylesheet/less" href="${request.contextPath}/static/css/style.less">
        <script src="${request.contextPath}/static/js/less-2.7.1.min.js"></script>
    	<script src="${request.contextPath}/static/js/jquery-1.11.3.min.js"></script>
        <!--[if lt IE9]>
        <script type="text/javascript" src="${request.contextPath}/static/js/html5shiv.min.js"></script>
        <![endif]-->
         <script src="${request.contextPath}/static/js/vue.js"></script>
         <script type="text/javascript">	
		var dataVue;
		$(function(){
			dataVue = new Vue({
				el : "#loginFrom",
				methods : {
					show : function(ev){
						if(ev.keyCode == 13){  
                            login();
                        } 
					}
				}
			});
		});

		function login() {
			var loginName = $('#username').val();
			var loginPwd = $('#password').val();
			if (loginName == '' || loginName == undefined) {
				$(".error-msg").text('请输入用户名');
				return; 
			}
			if (loginPwd == '' || loginPwd == undefined) {
				$(".error-msg").text('请输入密码');
				return;
			}
			$("#loading").show();
			$("#loginFrom").hide();
			$.post("${request.contextPath}/loginController/login.do",
				{ 
					loginName:loginName,
					loginPwd:loginPwd
				},
				function(data) {
					
					if (data.code == 200) {
						window.location.href = '${request.contextPath}'+data.roleUrl;
					} else {
						$(".error-msg").text(data.msg);
						$("#loading").hide();
						$("#loginFrom").show();
					}
				}); 
	}
	</script>
         
    </head>
    <body>
        <article id="loginFrom">
            <!--登录页面-->
            <aside class="dialog-login">
                <header>
                    <h3>爱情管理系统</h3>
                    <span class="icon icon-logo"></span>
                </header>
                <section>
                    <div class="form-item">
                        <label class="icon icon-user" for="username"></label>
                        <input id="username" type="text" name="username" placeholder="帐号"/>
                    </div>
                    <div class="form-item">
                        <label class="icon icon-lock" for="password"></label>
                        <input id="password" @keyup.13="show($event)" type="password" name="password" placeholder="密码"/>
                    </div>
                    <p class="error-msg"></p>
                </section>
                <footer>
                    <a class="btn-login" href="javascript:login();">登录</a>
                </footer>
            </aside>
        </article>
    </body>
</html>
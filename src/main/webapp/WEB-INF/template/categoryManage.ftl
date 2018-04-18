<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="renderer" content="webkit"/>
        <title>分类管理</title>
        <link type="text/css" rel="stylesheet/less" href="${request.contextPath}/static/css/style.less">
        <script src="${request.contextPath}/static/js/less-2.7.1.min.js"></script>
        <script src="${request.contextPath}/static/js/jquery-1.11.3.min.js"></script>
        <script src="${request.contextPath}/static/js/vue.js"></script>
        <!--[if lt IE9]>
        <script type="text/javascript" src="js/html5shiv.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <article class="categoryManage">
            <header>
            <h1 class="brand"><span class="icon icon-logo"></span>物料系统</h1>
            <div class="tabs">
                <a href="${request.contextPath}/selectionProductController/toMaterial.do">料库</a>
                <a href="${request.contextPath}/selectionProductController/toProductListPage.do">产品结构清单</a>
                <a href="${request.contextPath}/selectionProductController/toPropertyManage.do">规格管理</a>
                <a class="active" href="${request.contextPath}/selectionProductController/toCategoryManage.do">分类管理</a>
            </div>
            <div class="user-info">
                <span class="name">${userInfo.userName}</span>
                <span class="position">${userInfo.roleName}</span>
                <a class="logout" href="javascript:outLogin();">退出</a>
            </div>
        </header>
            <section>
                <ul class="pro-category" id="pro-categorys">
	
                </ul>
            </section>
        </article>
        <script type="text/javascript">
        $(function(){
		
        	initData();
        	
        });
        
        function initData(){
            getProdCate(null);
           
           
            
        }
       
        
        
        function getProdCate(categoryId) {
            $.ajax({
                url : "${request.contextPath}/productCategoryController/selectCategoryTree.do",
                type : "post",
                cache : false,
                dataType : "json",
                data : {
                    categoryId : categoryId
                },
                success : function(data) {
                    alldata = "";
                    
                    $.each(data,function(i,item){
                    
                        alldata +="<li class='primary' id='"+data[i].gid+"'><input type='hidden' value='"+data[i].categoryId+"'><div><div class='item-name'>"+data[i].categoryName+"<span class='icon icon-edit' onclick='firstupd(this)'></span><span class='icon icon-close-circle' onclick='delthird(this)'></span><input type='hidden' value = '"+data[i].gid+"'></div><div class='item-editor'><input type='text' name=''  placeholder='请输入'><button type='button' class='btn-save' onclick='updcategroyname(this)'>保存</button><input type='hidden' value = '"+data[i].gid+"'><button type='button' class='btn-cancel' onclick='backhide()'>取消</button></div></div> <ul>";

                        $.each(data[i].categorys,function(j,item){
                        
	                        alldata +="<li class='secondary' id='"+data[i].categorys[j].gid+"'><div ><div class='item-name'>"+data[i].categorys[j].categoryName+"<span class='icon icon-edit' onclick='firstupd(this)'></span><span class='icon icon-close-circle' onclick='delthird(this)'></span><input type='hidden' value = '"+data[i].categorys[j].gid+"'></div><div class='item-editor'><input type='text' name='' placeholder='请输入'><button type='button' class='btn-save' onclick='updcategroyname(this)'>保存</button><input type='hidden' value = '"+data[i].categorys[j].gid+"'><button type='button' class='btn-cancel' onclick='backhide()'>取消</button></div></div><ul class='thirdary'>" ;
	
	                        $.each(data[i].categorys[j].categorys,function(k,item){
	                                
	                        	alldata += "<li class='tertiary'>"+data[i].categorys[j].categorys[k].categoryName+"<span class='icon icon-close-circle' onclick='delthird(this)'></span><input type='hidden' value = '"+data[i].categorys[j].categorys[k].gid+"'></li></li>";
	                        
	                        });
	                        
                            alldata += "<li class='btn-add-item' onclick='addfenlei(this)' ><span class='icon icon-add'></span>添加三类</li><li class='item-editor'><input type='text' name=''  placeholder='请输入'><button type='button' class='btn-save' onclick='addthird(this)'>保存</button><button type='button' class='btn-cancel' onclick='canceladd()'>取消</button></li></ul></li>";
                        
                        });
                        
                        alldata += "<li class='secondary'><div><div class='btn-add-item' onclick='addfenlei(this)'><span class='icon icon-add'></span>添加二类</div><div class='item-editor'><input type='text' name=''  placeholder=''><button type='button' class='btn-save' onclick='addsecond(this)'>保存</button><button type='button' class='btn-cancel'  onclick='canceladd()'>取消</button></div></div></li></ul></li>";
                    }); 
                    
                    	alldata += "<li class='primary'><div><div class='btn-add-item' onclick='addfenlei(this)'><span class='icon icon-add'></span>添加一类</div><div class='item-editor'><select id='topIdChoose'></select><input type='text' name=''  placeholder='请输入'><button type='button' class='btn-save' onclick='addfirst(this)'>保存</button><button type='button' class='btn-cancel' onclick='canceladd()'>取消</button></div></div></li>"
                    	$("#pro-categorys").append(alldata); 
                    	 getTopKind(null);
                },
                error : function() {}
            });
        }
        
        
        /* 查询顶级分类ID  */
        function getTopKind(){
        	debugger
        	$.ajax({
                url : "${request.contextPath}/productCategoryController/selectTopKindId.do",
                type : "post",
                cache : false,
                dataType : "json",
                success : function(data) {
                   var alldata1 = "";
                    $.each(data,function(a,item){
                   		 alldata1 +="<option id='"+item.gid+"' value='"+item.categoryId+"'>"+item.categoryName+"</option>";
                    }); 	
                    
                    $("#topIdChoose").append(alldata1); 
                   
                },
                error : function() {}
            });
        	
        }
        
        
        
        /* 删除（修改del_flag）为1  */
        function delthird(obj){
       	    if (confirm("若该分类具有下级分类，则无法直接删除，请先删除子分类。是否删除该规格？ ")!=true){
                return;
            }
        	var $obj=$(obj);
        	$.ajax({
        		url : "${request.contextPath}/productCategoryController/delProductCategory.do",
        		type : "post",
        		cache : false,
        		dataType : "json",
        		data : {
        			"id":$obj.next().val()
        		},
        		success : function(data){
        			if (data.status > 0) {
        				toast('toast-success', "删除成功！");
        			} else {
        				toast('toast-warning', "删除失败！");
        			}
        			window.location.reload();
        		}
        	});
        }
        
        /* 三级分类添加   */
        function addthird(obj){
        	var $obj=$(obj);
        	var catygoryName = $obj.prev().val();
        	if(typeof(catygoryName)=="undefined" || catygoryName==null || catygoryName.length == 0 ) {
        		toast('toast-warning', "三级类别名不能为空！");
        		return;
        	}
        	$.ajax({
        		url : "${request.contextPath}/productCategoryController/addProductCategory.do",
        		type : "post",
        		cache : false,
        		dataType : "json",
        		data : {
        			"categoryName":catygoryName,
        			"parentId":$obj.parent().parent().parent().attr("id"),
        			"sortNo":0,
        			"categoryId":$obj.parent().parent().parent().parent().prev().prev().val()
        		},
        		success : function(data){
        			if (data.status > 0) {
        				toast('toast-success', "添加成功！");
        			} else {
        				toast('toast-warning', "添加失败！");
        			}
        			window.location.reload();
        		}
        	});
        }
        /* 二级分类添加    */
        function addsecond(obj){
        	var $obj=$(obj);
        	var catygoryName = $obj.prev().val();
        	if(typeof(catygoryName)=="undefined" || catygoryName==null || catygoryName.length == 0 ) {
        		toast('toast-warning', "二级类别名不能为空！");
        		return;
        	}
        	$.ajax({
        		url : "${request.contextPath}/productCategoryController/addProductCategory.do",
        		type : "post",
        		cache : false,
        		dataType : "json",
        		data : {
        			"categoryName":catygoryName,
        			"parentId":$obj.parent().parent().parent().parent().parent().attr("id"),
        			"sortNo":"",
        			"categoryId":$obj.parent().parent().parent().parent().prev().prev().val()
        		},
        		success : function(data){
        			if (data.status > 0) {
        				toast('toast-success', "添加成功！");
        			} else {
        				toast('toast-warning', "添加失败！");
        			}
        			window.location.reload();
        		}
        	});
        }
        
       
        /* 一级分类添加    */
        function addfirst(obj){
        	var $obj=$(obj);
        	var catygoryName = $obj.prev().val();
        	if(typeof(catygoryName)=="undefined" || catygoryName==null || catygoryName.length == 0 ) {
        		toast('toast-warning', "一级类别名不能为空！");
        		return;
        	}
        	$.ajax({
        		url : "${request.contextPath}/productCategoryController/addProductCategory.do",
        		type : "post",
        		cache : false,
        		dataType : "json",
        		data : {
        			"categoryName":catygoryName,
        			"parentId":$("select option:checked").attr("id"),
        			"sortNo":"",
        			"categoryId":$("#topIdChoose").val()
        		},
        		success : function(data){
        			if (data.status > 0) {
        				toast('toast-success', "添加成功！");
        			} else {
        				toast('toast-warning', "添加失败！");
        			}
        			window.location.reload();
        		}
        	});
        }
        
        
        /* 修改 */
        function updcategroyname(obj){
        	var $obj=$(obj);
        	var catygoryName = $obj.prev().val();
        	if(typeof(catygoryName)=="undefined" || catygoryName==null || catygoryName.length == 0 ) {
        		toast('toast-warning', "类别名不能为空！");
        		return;
        	}
        	$.ajax({
        		url : "${request.contextPath}/productCategoryController/updateProductCate.do",
        		type : "post",
        		cache : false,
        		dataType : "json",
        		data : {
        			"gid":$obj.next().val(),
        			"categoryName":$obj.prev().val(),
        			//"parentId":$obj.next().val(),
        			"sortNo":0
        		},
        		success : function(data){
        			toast('toast-success', "修改成功！");
        			window.location.reload();
        		}
        	});
        }
        
        
        /* 修改显隐  */

        function firstupd(obj){
        	$(".btn-cancel").parent().hide();
    		$(".btn-cancel").parent().prev().show();
       	    $(obj).parent().hide();
       	    $(obj).parent().next().show();
        }
        
        function backhide(){
      		$(".btn-cancel").parent().hide();
      		$(".btn-cancel").parent().prev().show();	
        }
        
        /* 分类添加显隐   */

        function addfenlei(obj){
        	$(".btn-cancel").parent().hide();
    		$(".btn-cancel").parent().prev().show();
       		$(obj).hide();
       		$(obj).next().show();
        }
        function canceladd(){
       		$(".btn-cancel").parent().hide();
       		$(".btn-cancel").parent().prev().show();
        }

		//提示信息的展示
		function toast(className,text){
            var html = '<div class="toast ' + className + '">' + '<p>' + text + '</p>' + '</div>';
            var $toast = $(html).appendTo($("body")).show();
            window.setTimeout(function(){
                $toast.fadeOut(2000);
            },2000);
        }
		
       
        </script>
    </body>
</html>
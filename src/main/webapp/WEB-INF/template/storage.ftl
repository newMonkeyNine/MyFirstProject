<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="renderer" content="webkit"/>
    <title>仓库</title>
    <script src="${request.contextPath}/static/js/jquery-1.11.3.min.js"></script>
    <link type="text/css" rel="stylesheet/less" href="${request.contextPath}/static/css/style.less">
    <script src="${request.contextPath}/static/js/less-2.7.1.min.js"></script>
    <script src="${request.contextPath}/static/js/vue.js"></script>
    <script type="text/javascript"
	src="${request.contextPath}/static/js/sweetalert.min.js"></script>
	<link rel="stylesheet"
	href="${request.contextPath}/static/css/sweetalert.css">
    <!--[if lt IE9]>
    <script type="text/javascript" src="js/html5shiv.min.js"></script>
    <![endif]-->
</head>
<body>
    <article class="storage" class="toast toast-success">
        <header>
            <h1 class="brand"><span class="icon icon-logo"></span>物料系统</h1>
            <div class="tabs">
                <a href="${request.contextPath}/selectionProductController/toMaterial.do">料库</a>
                <a href="${request.contextPath}/selectionProductController/toProductListPage.do">产品结构清单</a>
                <a href="${request.contextPath}/selectionProductController/toPropertyManage.do">规格管理</a>
            </div>
            <div class="user-info">
                <span class="name">${userInfo.userName}</span>
                <span class="position">${userInfo.roleName}</span>
                <a class="logout" href="javascript:outLogin();">退出</a>
            </div>
        </header>
        <section>
            <!--仓库列表-->
            <div class="panel panel-storage-list">
                <div class="panel-header">
                    <div class="search-bar">
                        <span class="icon icon-search"></span>
                        <input type="text" onkeydown="selectKey()" placeholder="输入搜索内容"/>
                        <button id="sousuo">搜索</button>
                    </div>
                    
                    <div class="btn-group">
						<form id="fileform" class="btn btn-import"><label> 导入K3库存<input type="file" onchange="importExcel()" name="fileName"/></label></form>
                        <button class="main btn btn-edit" type="button">批量编辑</button>
                        <button class="main btn btn-save" onclick="getNum()" type="button">保存</button>
                        <button class="main btn btn-cancel" type="button">取消</button>
                    </div>
                </div>
                <div class="panel-body">
                    <table class="table">
                        <thead>
                            	<tr>
                            		<th>图片</th>
                            		<th>类别</th>
                            		<th>物料名称</th>
                            		<th>物料规格</th>
                            		<th>物料编号</th>
                            		<th>型号</th>
                            		<th>品牌</th>
                            		<th>数量</th>
                            		<th>单位</th>
                                </tr>
                        </thead>
                        <tbody id="stockTab">
                            <template v-for="item in stocks">
                            	<template v-if="item.product.isUser == 0">
		                            <tr class="is-recom" class="unavailable"  v-if="item && item.product">
		                                <template v-if="item.product.isRecommend != 0">
	                               		 	<td class="recommend img" v-if="item.product.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+item.product.productFile.fileUrl+')'}"></td>
			                            <td v-else></td>
		                               	</template>
		                                <template v-else>
		                               		 <td v-if="item.product.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+item.product.productFile.fileUrl+')'}"></td>
			                            <td v-else></td>
		                               	</template>
		                                <td>{{item.product.prodCate.categoryName}}</td>
		                                <td class="name">{{item.product.productName}}</td>
		                                <td class="property">{{item.product.propertys}}</td>
		                                <td>{{item.product.productCode}}</td>
		                                <td>{{item.product.modelType}}</td>
		                                <td>{{item.product.ventor.ventorName}}</td>
		                                <td class="storages">{{item.stockNum}}</td>
		                                <input type = "hidden" value="" class="hiddValue" />
		                                <td>{{item.product.basicUnit}}</td>
		                                <td  style="display: none;"><span>{{item.gid}}</span></td>
		                            </tr>
	                            </template>
	                            <template v-else>
		                            <tr class="is-recom" v-if="item && item.product">
		                                <template v-if="item.product.isRecommend != 0">
	                               		 	<td class="recommend img" v-if="item.product.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+item.product.productFile.fileUrl+')'}"></td>
			                            <td v-else></td>
		                               	</template>
		                                <template v-else>
		                               		 <td v-if="item.product.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+item.product.productFile.fileUrl+')'}"></td>
			                            <td v-else></td>
		                               	</template>
		                                <td>{{item.product.prodCate.categoryName}}</td>
		                                <td class="name">{{item.product.productName}}</td>
		                                <td class="property">{{item.product.propertys}}</td>
		                                <td>{{item.product.productCode}}</td>
		                                <td>{{item.product.modelType}}</td>
		                                <td>{{item.product.ventor.ventorName}}</td>
		                                <td class="storages">{{item.stockNum}}</td>
		                                <input type = "hidden" value=""  />
		                                <td>{{item.product.basicUnit}}</td>
		                                <td  style="display: none;"><span>{{item.gid}}</span></td>
		                            </tr>
	                            </template>
                            </template>
                         </tbody>
                     </table>
                    <div id="page" class="table-footer">
                         <template v-if="page && page.pageList">
                            <div class="table-info">
                                <template v-if="page">
                                    共 {{page.totalPage}} 页 {{page.totalRecord}} 条记录
                                </template>
                            </div>
                             <div class="pager">
                                 <template v-if="page.nowPage !=1">
                                     <a href="javascript:void(0)" :data-index="page.nowPage-1">上一页</a>
                                 </template>
                                 <template v-else>
                                     <a href="javascript:void(0)">上一页</a>
                                 </template>

                                 <template v-if="page.startPage != 1">
                                     <a href="javascript:void(0)" :data-index="page.nowPage-5" :totalPage='page.totalPage' direction="Previous">...</a>
                                 </template>

                                 <template v-for="item in page.pageList">
                                     <a v-if="item==page.nowPage" href="javascript:void(0)" class="active" :data-index="item">{{item}}</a>
                                     <a v-if="item!==page.nowPage" href="javascript:void(0)" :data-index="item">{{item}}</a>
                                 </template>

                                 <a v-if="page.endPage != page.totalPage" href="javascript:void(0)" :data-index="page.nowPage+5" :totalPage='page.totalPage' direction="Next">...</a>
                                 <template v-if="page.nowPage != page.totalPage">
                                     <a href="javascript:void(0)" :data-index="page.nowPage+1">下一页</a>
                                 </template>
                                 <template v-else>
                                     <a href="javascript:void(0)">下一页</a>
                                 </template>
                                 <span class="skip">
                                    到第<input type="number" min="1" :max="page.totalPage" class="jumpPage" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>页
                                    <button class="jump" :data-index="page.totalPage">确定</button>
                                </span>
                             </div>
                         </template>
                     </div>
                </div>
            </div>

            <!--仓库详情-->
            <div class="panel panel-detail" id="stockInfo">
                <div class="panel-header">
                    <a class="return" href="javaScript:;">返回</a>
                    <div class="btn-group">
                        <button class="btn btn-edit" id="bianji" type="button">编辑</button>
                    </div>
                </div>
                <template v-if="stock && stock.product">
                <div class="panel-body">
                    <table class="table table01">
                        <thead>
                            <tr>
                                <th>图片</th>
                                <th>大类别</th>
                                <th>类别</th>
                                <th>物料规格</th>
                                <th>物料名称</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<template v-if="stock.product.isUser == 0">
	                            <tr class="unavailable">
	                                <td v-if="stock.product.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+stock.product.productFile.fileUrl+')'}"></td>
		                            <td v-else></td>
		                            <td></td>
		                            <td>{{stock.product.prodCate.categoryName}}</td>
		                            <td class="property">{{stock.product.propertys}}</td>     
	                                <td class="name">{{stock.product.productName}}</td>
	                                <td class="gid" style="display: none;">{{stock.gid}}</td>
	                            </tr>
                            </template>
                            <template v-else>
	                            <tr>
	                                <td v-if="stock.product.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+stock.product.productFile.fileUrl+')'}"></td>
		                            <td v-else></td>
		                            <td></td>
		                            <td>{{stock.product.prodCate.categoryName}}</td>
		                            <td class="property">{{stock.product.propertys}}</td>     
	                                <td class="name">{{stock.product.productName}}</td>
	                                <td class="gid" style="display: none;">{{stock.gid}}</td>
	                            </tr>
                            </template>
                        </tbody>
                    </table>
                    <table class="table table02">
                        <thead>
                            <tr>
                                <th>品牌</th>
                                <th>型号</th>
                                <th>系列</th>
                                <th>单价</th>
                                <th>备注</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>{{stock.product.ventor.ventorName}}</td>
                                <td>{{stock.product.modelType}}</td>
                                <td>{{stock.product.modelName}}</td>
                                <td></td>
                                <td>{{stock.product.description}}</td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="table table03">
                        <thead>
                            <tr>
                                <th>物料编号</th>
                                <th>基本单位</th>
                                <th>单位精度</th>
                                <th>最高库存</th>
                                <th>安全库存</th>
                                <th>最低库存</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>{{stock.product.productCode}}</td>
                                <td>{{stock.product.basicUnit}}</td>
                                <td>{{stock.product.amountPrecision}}</td>
                                <td>{{stock.product.highStock}}</td>
                                <td>{{stock.product.safeStock}}</td>
                                <td>{{stock.product.lowStock}}</td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="table table04">
                        <thead>
                            <tr>
                                <th>3D模型</th>
                                <th>2D模型</th>
                                <th>助记码</th>
                                <th>搜索关键字</th>
                                <th>该料是否可用</th>
                                <th>是否推荐</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="model-3d has-model"></td>
                                <td class="model-2d"></td>
                                <td>{{stock.product.easyCode}}</td>
                                <td>{{stock.product.keyWord}}</td>
                                <template v-if="stock.product.isUser == 1">
                                	<td class="is-available">可用</td>
                                </template>
                                <template v-else-if="stock.product.isUser == 0">
                                	<td class="is-available">不可用</td>
                                </template>
                                <template v-if="stock.product.isRecommend != 1">
                                	<td class="is-recommend">否</td>
                                </template>
                                <template v-else>
                                	<td class="is-recommend">是</td>
                                </template>
                            </tr>
                        </tbody>
                    </table>
                    <table class="table table05">
                        <thead>
                            <tr>
                                <th>库存</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td id="storage" class="storage">{{stock.stockNum}}</td>
                                <input type = "hidden" id="detailNum" value="" />
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                </template>
                <div class="panel-footer">
                    <div class="btn-group" id="group-btn" style="display: none;">
                        <button class="btn btn-save" type="button">保存</button>
                        <button class="btn btn-cancel" type="button" >取消</button>
                    </div>
                </div>
            </div>
        </section>
    </article>
       
    <style media="print">
    @page {
      size: auto;  /* auto is the initial value */
      margin: 0mm; /* this affects the margin in the printer settings */
    }
	</style>
    <script type="text/javascript">
        $(function(){

        	initData();
        	$(".panel-detail").css("display","none");
            $(".tabs a").click(function(){
                var $siblings = $(this).siblings();
                $siblings.each(function(i, value){
                    if($(this).hasClass("active")){
                        $(this).removeClass("active");
                    }
                });
                $(this).addClass("active");
            });
            $(".main.btn.btn-edit").click(function(){
            	isright = true;
            	$(this).hide();
            	$(".main.btn-save").show();
            	$(".main.btn-cancel").show();
            	$(".storages").each(function(index, item){
            		isright = false;
            		var inputTxt = $(item).text();
            		$(this).next().val(inputTxt);
            		$(item).html("<input type='text' maxlength='8' class='numText' value='"+inputTxt+"'>");
            	});
            	if (isright){
            		toast('toast-warning',"当前没有库存资料");
        			clear();
            	}
            });
            
            var detailNum = "";
            
            $(".panel-detail").click(function(e){
            	var target = e.srcElement || e.target;
            	if (target.className === "return"  ) {
            		/* if (detailNum != "") {
            			$("#storage").html(detailNum);
            		}
            		clear();
            		updateNum();
            		$(this).hide();
            		$(".panel-storage-list").show(); */
            		location.reload(true);
            	} else if (target.className === "btn btn-cancel") {
					if ($("#num").val() != "" ){
						$("#storage").html(detailNum);
					}
					clear();
					getStockInfo(null,null);
				} else if (target.className === "btn btn-edit") {
					$("#group-btn").show();
					$("#bianji").hide();
					detailNum = $("#storage").text();
					if(detailNum != "" ){
						$("#storage").html("<input maxlength='9' type='text' id='num' value='"+detailNum+"'>");
					}
				} else if (target.className === "btn btn-save") {
					gid = $(".gid").text();
					num = $("#num").val();
					if(isNaN(num) || (num.substring(0,1) == 0 && num.length > 1) || num < 0){
	        			toast('toast-warning',"请输入正整数！");
	        			return;
	        		}
					editNum(gid,num);
					clear();
				}
            });
            
            
            $(".main.btn-cancel").click(function(){
            	clear();
            	getStockInfo(null,null);
            });
            
            
            $("#page").on("click", ".pager a", function() {
            	var nowPage = $(this).attr("data-index");
            	console.info(nowPage);
            	var totalPage = $(this).attr("totalPage");
            	var direction = $(this).attr("direction");
            	if (direction == undefined) {
                	if (nowPage != undefined) {
                		getStockInfo(nowPage,$("#sousuo").prev().val());
                	}
            	} else {
                	if (direction == "Previous") { //向前
                    	if (parseInt(nowPage) <= 1) {
                        	nowPage = 1;
                    	}
                	} else if (direction == "Next") { //向后
                    	if (parseInt(nowPage) >= totalPage) {
                        	nowPage = totalPage;
                    	}
                	}
                	if (nowPage != undefined) {
                		getStockInfo(nowPage,$("#sousuo").prev().val());
                	}
                }
            });

            //页面跳转
            $("#page").on("click", ".jump", function() {
                var nowPage = $(".jumpPage").val();
                if(nowPage==""){
                    alert("请输入页码");
                }else{
                    maxPage = $(this).attr("data-index");
                    var maxPage = $(this).data("index");
                        if (nowPage > maxPage) {
                            nowPage = maxPage;
                        } else if (nowPage < 1) {
                            nowPage = 1;
                        }
                    getStockInfo(nowPage,$("#sousuo").prev().val());
                }
            });
         
            
            $("#sousuo").click(function(){
            	clear();
            	selValue = $(this).prev().val();
            	getStockInfo(null,selValue);  
            });
            
        	
        });
	  
        
        function convertCanvasToImage(aaa) {
            var image = new Image();
            image.src = aaa.toDataURL("image/png");
            return image;
        }
        
        var numText = "";
        var gid = "";
        
        function getNum(){
        	isNumber = true;
        	$(".numText").each(function(index, item){
        		var num = $(item).val();
        		if(isNaN(num) || (num.substring(0,1) == 0 && num.length > 1) || num < 0){
        			toast('toast-warning',"请输入正整数！");
        			isNumber = false;
        		} else {
        			numText += num+",";
            		gid += $(item).parent().next().next().next().text()+",";
            		return;
        		}
        	});
        	if (isNumber){	
        		editNums();
        	}
        }
        
        
        function editNum(gid,num){
  		   $.ajax({
  			   	url : "${request.contextPath}/stockController/udpateNumById.do",
  			   	type : "post",
  			    cache : false,
  			   	data : {
  			   		gid : gid,
  			   		num : num
  			   	},
  			   	dataType : "json",
  			   	success : function(data) {
 	 			   	if (data.status > 0) {
 	 			   		toast('toast-success', data.message);
						num = $("#num").val();
						$("#storage").html(num);
 					} else  {
 						toast('toast-warning',data.message);
 					}
  			   	}
  		   });
  	   }
        
        
        
        function editNums(){
 		   $.ajax({
 			   	url : "${request.contextPath}/stockController/udpateNumByList.do",
 			   	type : "post",
 			    cache : false,
 			   	data : {
 			   		"numText" : numText,
 			   		"gid" : gid
 			   	},
 			   	dataType : "json",
 			   	success : function(data) {
	 			   	if (data.stauts > 0) {
	 			   		toast('toast-success', data.message);
						$(".main.btn.btn-edit").show();
			        	$(".main.btn.btn-save").hide();
			        	$(".main.btn.btn-cancel").hide();
			        	$(".numText").each(function(index, item){
			        		$(this).parent().text($(this).val());
			        	});
			        	setTimeout(function(){
			        		location.reload(true);
			        	},1000);
					} else  {
						toast('toast-warning', data.message);
						clear();
					}
 			   	}
 		   });
 	   }
        
        
	   function importExcel(){
		   var formData = new FormData($("#fileform")[0]);
		   $.ajax({
			   	url : "${request.contextPath}/uploadImageController/uploadImage.do?type=excel",
			   	type : "post",
			   	dataType : "json",
			   	data : formData,
			   	processData : false, // 不处理数据
			   	contentType : false, // 不设置内容类型
			   	success : function(data) {
			   		if (data.status > 0) {
			   			toast('toast-success', data.message);
			   			getStockInfo(null,null);
			   			setTimeout(function(){
			   				location.reload(true);
			   			},1000)
					} else  {
						toast('toast-warning', data.message);
					}
			   	}
		   });
		  
	   }
	   //退出登录
	  	
	   
    	
    	function toast(className,text){
            var html = '<div class="toast ' + className + '">' + '<p>' + text + '</p>' + '</div>';
            var $toast = $(html).appendTo($("body")).show();
            window.setTimeout(function(){
                $toast.fadeOut(2000);
            },2000);
        }
	   
        function outLogin(){
            window.location.href = '${request.contextPath}/loginController/outLogin.do';
        }        

        function initData(){
        	getStockInfo(null,null);
        }
        
        function getStockInfo(nowPage,selValue){
        	$.ajax({
				url : "${request.contextPath}/stockController/findStockInfoByPage.do",
				type : "post",
				cache : false,
				data : {
					page : nowPage,
					selValue : selValue
				},
				dataType : "json",
				success : function(data) {
					stockVue.stocks = data.stocks;
					pageVue.page = data.page;
					$(this).prev().val(selValue);
				},
				error : function() {}
			});
        }
           
           stockVue = new Vue({
               el : "#stockTab",
               data : {
            	   stocks : [],
            	   baseUrl :'${request.contextPath}/static/img/'
               },
               methods:{
            	   
               },updated:function(){
            	   $("#stockTab td[class != storages]").click(function(){
            		   showQAQ(this);
            	   });
               }
         	});
         
          pageVue = new Vue({
               el : "#page",
               data : {
                   page : new Object()
               }
          });
          
          stockInfoVue = new Vue({
        	  el : "#stockInfo",
        	  data : {
        		  stock : new Object(),
           	  	  baseUrl :'${request.contextPath}/static/img/'
        	  }
          }); 
          
          function getStockInfoById(gid){
        	  $.ajax({
  				url : "${request.contextPath}/stockController/findStockInfoById.do",
  				type : "post",
  				cache : false,
  				data : {
  					gid : gid
  				},
  				dataType : "json",
  				success : function(data) {
  					gid = data.gid;
  					stockInfoVue.stock = data;
  				},
  				error : function() {}
  			});
          }
  
          function selectKey(){
  			if (event.keyCode == 13){  //回车键的键值为13
  				clear();
  				getStockInfo(null,$("#sousuo").prev().val());
  			}
  			
  		}
          
          function updateNum(){
        	 var num =  $("#storage").text();
        	 $(".storages").each(function(index, item){
        		 gids = $(this).next().next().next().text();
         		if (gid == gids){
         			if (num != ""){
         				$(this).text(num);
         			}
         		}
         	});
        	 
          }
          
          function showQAQ(obj){
  			  gid = $(obj).parent().children("td").last().find("span").text();
  			  getStockInfoById(gid);
  			  clear();
  			  $(".panel-storage-list").hide();
  			  $(".panel-detail").show();  
  		  }
          
		  function clear(){
			$("#bianji").show();
			$("#group-btn").hide();
			$(".main.btn.btn-edit").show();
        	$(".main.btn.btn-save").hide();
        	$(".main.btn.btn-cancel").hide();
        	detailNum = "";
			$(".numText").each(function(index, item){
        		$(this).parent().text($(this).parent().next().val());
        	});
		}
		
    </script>
</body>
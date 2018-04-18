<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="renderer" content="webkit" />
        <title>行业资料库</title>
        <script src="${request.contextPath}/static/js/jquery-1.11.3.min.js"></script>
        <link rel="stylesheet"
            href="${request.contextPath}/static/css/sweetalert.css">
        <link type="text/css" rel="stylesheet/less"
            href="${request.contextPath}/static/css/style.less">
        <script src="${request.contextPath}/static/js/ajaxfileupload.js"></script>
        <script src="${request.contextPath}/static/js/less-2.7.1.min.js"></script>
         <script src="${request.contextPath}/static/js/vue.js"></script>
        <script type="text/javascript"
            src="${request.contextPath}/static/js/sweetalert.min.js"></script>
        <!--[if lt IE9]>
            <script type="text/javascript" src="js/html5shiv.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <article class="industry" class="toast toast-success">
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
                <!--行业资料库列表-->
                <div class="panel panel-industry-list"  >
                    <div class="panel-header">
                        <div class="search-bar"  onkeydown="selectKey()">
                            <span class="icon icon-search"></span>
                            <input type="text" id="modelType" placeholder="输入搜索内容 多个条件用空格隔开 如不锈钢 M4*60"/>
                            <button id="sousuo">搜索</button>
                        </div>
                        <div class="btn-group">
                            <button class="btn btn-add" type="button">新增</button>
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
                                    <th>品牌</th>
                                    <th>供应商型号</th>
                                    <th>系列</th>
                                </tr>
                            </thead>
                            <tbody id="ventorProdTab">
                                <template v-for="item in ventorProds">
                                    <template v-if="item.product.isUser != null">
                                        <template v-if="item.product.isUser == 0">
                                            <tr class="is-material  unavailable" onclick="showQAQ(this);" v-if="item && item.productCate && item.ventor">
                                                <td v-if="item.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
                                                <td v-else></td>
                                                <td>{{item.productCate.categoryName}}</td>
                                                <td class="name">{{item.productCname}}</td>
                                                <td>{{item.propertys}}</td>
                                                <td class="supplier">{{item.ventor.ventorName}}</td>
                                                <td v-if="item.modelType != null">{{item.modelType}}</td>
                                                <td v-else></td>
                                                <td>{{item.modelName}}</td>
                                                <td style="display: none;"><span>{{item.gid}}</span></td>
                                            </tr>
                                        </template>
                                        <template v-else>
                                            <tr class="is-material" onclick="showQAQ(this);" v-if="item && item.productCate && item.ventor">
                                                <td v-if="item.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
                                                <td v-else></td>
                                                <td>{{item.productCate.categoryName}}</td>
                                                <td class="name">{{item.productCname}}</td>
                                                <td>{{item.propertys}}</td>
                                                <td class="supplier">{{item.ventor.ventorName}}</td>
                                                <td v-if="item.modelType != null">{{item.modelType}}</td>
                                                <td v-else></td>
                                                <td>{{item.modelName}}</td>
                                                <td style="display: none;"><span>{{item.gid}}</span></td>
                                            </tr>
                                        </template>
                                    </template>
                                    <template v-else>
                                        <tr onclick="showQAQ(this);" v-if="item && item.productCate && item.ventor">
                                            <td v-if="item.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
                                            <td v-else></td>
                                            <td>{{item.productCate.categoryName}}</td>
                                            <td class="name">{{item.productCname}}</td>
                                            <td>{{item.propertys}}</td>
                                            <td class="supplier">{{item.ventor.ventorName}}</td>
                                            <td v-if="item.modelType != null">{{item.modelType}}</td>
                                            <td v-else></td>
                                            <td>{{item.modelName}}</td>
                                            <td style="display: none;"><span>{{item.gid}}</span></td>
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
                <!--新增至行业资料库-->
                <div class="panel panel-append">
                    <div class="panel-header">
                        <a class="return" href="javaScript:;">返回</a>
                    </div>
                    <div class="panel-body">
                        <table class="table table01">
                            <thead>
                                <tr>
                                    <th class="required">图片</th>
                                    <th class="required">大类别</th>
                                    <th class="required">类别</th>
                                    <th class="required">物料规格</th>
                                    <th class="required">物料名称</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="image" class="img no-img" >
                                    <span id="preview"></span>
                                         <form id="fileform" method= "post" enctype ="multipart/form-data">
                                        <input type="file" name="fileName" id="fileImage" onchange="preview(this);" /></form>
                                    </td>
                                    <td>
                                        <select name="">
                                            <option value="0">请选择</option>
                                            <option value="1">标准件</option>
                                            <option value="2">产品</option>
                                            <option value="3">半成品</option>
                                            <option value="4">耗材</option>
                                        </select>
                                    </td>
                                    <td class="type">
                                        <div class="input-select">
                                            <input type="text" readonly="readonly" name="prodCateName"   placeholder="请选择"/>
                                            <input type="hidden" id="prodCateId"  value="" />
                                            <span class="icon icon-list" onclick="clickType(this);"></span>
                                            <aside class="dialog" id="prodCate">
                                                <header>
                                                    <div class="btn-group">
                                                        <button class="btn btn-save" id="saveCate" type="button">确认</button>
                                                        <button class="btn btn-cancel" id="exitCate" type="button">取消</button>
                                                    </div>
                                                </header>
                                                <section>
                                                    <ul  id="prod-cate">

                                                    </ul>
                                                </section>
                                            </aside>
                                        </div>
                                    </td>
                                    <td class="property">
                                        <div class="input-select">
                                            <input type="text" name="prodProperty" id="property" readonly="readonly" placeholder="请选择" />
                                            <span  class="icon icon-list" onclick="clickProperty(this);"></span>
                                            <aside class="dialog" id="dialogProperty">
                                                <header>
                                                    <h3>选择属性，构成物料名称</h3>
                                                    <div class="btn-group">
                                                        <button class="btn btn-save" id="propertyname" type="button">确认</button>
                                                        <button class="btn btn-cancel" id="exitProperty" type="button">取消</button>
                                                    </div>
                                                </header>
                                                <section>
                                                    <ul id="propertyList">

                                                    </ul>
                                                </section>
                                            </aside>
                                        </div>
                                    </td>
                                    <td class="name"><input type="text" maxlength="20" name="productName" placeholder="请输入" /></td>
                                </tr>
                        </table>
                        <table class="table table02">
                            <thead>
                                <th class="required">品牌</th>
                                <th class="required">供应商型号</th>
                                <th>系列</th>
                                <th>单价</th>
                                <th>备注</th>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="supplier">
                                        <div class="input-select">
                                            <input type="text" readonly="readonly" name="ventorName" placeholder="请选择"/>
                                            <input type="hidden" id="ventorId" value="" />
                                            <span class="icon icon-list" onclick="clickVentor(this);"></span>
                                            <aside class="dialog" id="dialogventor">
                                                <header>
                                                    <div class="btn-group">
                                                        <button class="btn btn-save" id="saveVentor" type="button">确认</button>
                                                        <button class="btn btn-cancel" type="button" id="exitVentor">取消</button>
                                                    </div>
                                                </header>
                                                <section>
                                                    <ul class="letters">
                                                        <li class="active">所有</li>
                                                        <li>品牌</li>
                                                        <li>小型</li>
                                                        <li>A</li>
                                                        <li>B</li>
                                                        <li>C</li>
                                                        <li>D</li>
                                                        <li>E</li>
                                                        <li>F</li>
                                                        <li>G</li>
                                                        <li>H</li>
                                                        <li>I</li>
                                                        <li>J</li>
                                                        <li>K</li>
                                                        <li>L</li>
                                                        <li>M</li>
                                                        <li>N</li>
                                                        <li>O</li>
                                                        <li>P</li>
                                                        <li>Q</li>
                                                        <li>R</li>
                                                        <li>S</li>
                                                        <li>T</li>
                                                        <li>U</li>
                                                        <li>V</li>
                                                        <li>W</li>
                                                        <li>X</li>
                                                        <li>Y</li>
                                                        <li>Z</li>
                                                    </ul>
                                                    <ul class="items">

                                                    </ul>
                                                </section>
                                            </aside>
                                        </div>
                                    </td>
                                    <td><input type="text" name="modelType" maxlength="15" placeholder="请输入" /></td>
                                    <td><input type="text" name="modelName" maxlength="15" placeholder="请输入" /></td>
                                    <td><input type="number" name="" min="0" placeholder="请输入"/></td>
                                    <td><input type="text" name="description" maxlength="30" placeholder="请输入" /></td>
                                    <input type="hidden" value="" id="gid" />
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="panel-footer">
                        <div class="btn-group">
                            <button class="btn btn-save" id="saveBtn" type="button">保存</button>
                            <button class="btn btn-cancel" type="button">取消</button>
                        </div>
                    </div>
                </div>
                <!--行业详情-->
                <div  id="ventorProduct" class="panel panel-detail">
                    <div class="panel-header">
                        <a class="return" href="javaScript:;">返回</a>
                        <div class="btn-group">
                           <!--  <button class="btn btn-to-material" type="button">转至料库</button> -->
                            <button class="btn btn-edit" type="button">编辑</button>
                            <!-- <button class="btn btn-delete" type="button">删除</button> -->
                        </div>
                    </div>
                    <template v-if="ventorProd && ventorProd.productCate ">
                    <div class="panel-body">
                        <table class="table table01">
                            <thead>
                                <tr>
                                    <th>图片</th>
                                    <th>类别</th>
                                    <th>物料规格</th>
                                    <th>物料名称</th>
                                    <th>品牌</th>
                                    <th>供应商型号</th>
                                    <th>系列</th>
                                    <th>备注</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-if="ventorProd.product.isUser == 0">
                                    <tr class="unavailable">
                                        <td class="img" v-if="ventorProd.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+ventorProd.productFile.fileUrl+')'}"></td>
                                        <td v-else></td>
                                        <td class="type">{{ventorProd.productCate.categoryName}}</td>
                                        <td class="property">{{ventorProd.propertys}}</td>
                                        <td class="name">{{ventorProd.productCname}}</td>
                                        <td>{{ventorProd.ventor.ventorName}}</td>
                                        <td>{{ventorProd.modelType}}</td>
                                        <td>{{ventorProd.modelName}}</td>
                                        <td class="remark">{{ventorProd.description}}</td>
                                    </tr>
                                </template>
                                <template v-else>
                                    <tr>
                                        <td class="img" v-if="ventorProd.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+ventorProd.productFile.fileUrl+')'}"></td>
                                        <td v-else></td>
                                        <td class="type">{{ventorProd.productCate.categoryName}}</td>
                                        <td class="property">{{ventorProd.propertys}}</td>
                                        <td class="name">{{ventorProd.productCname}}</td>
                                        <td>{{ventorProd.ventor.ventorName}}</td>
                                        <td>{{ventorProd.modelType}}</td>
                                        <td>{{ventorProd.modelName}}</td>
                                        <td class="remark">{{ventorProd.description}}</td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                        <template v-if="ventorProd.product.isUser != null">
                        <div class="table-info top">*在料库中的信息</div>
                        <table class="table table02">
                            <thead>
                                <tr>
                                    <th>物料编号</th>
                                    <th>基本单位</th>
                                    <th>单位精度</th>
                                    <th>最高库存</th>
                                    <th>安全库存</th>
                                    <th>最低库存</th>
                                    <th>助记码</th>
                                    <th>搜索关键字</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>{{ventorProd.product.productCode}}</td>
                                    <td>{{ventorProd.product.basicUnit}}</td>
                                    <td>{{ventorProd.product.amountPrecision}}</td>
                                    <td>{{ventorProd.product.highStock}}</td>
                                    <td>{{ventorProd.product.safeStock}}</td>
                                    <td>{{ventorProd.product.lowStock}}</td>
                                    <td>{{ventorProd.product.easyCode}}</td>
                                    <td class="keyword">{{ventorProd.product.keyWord}}</td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table03">
                            <thead>
                                <tr>
                                    <th>3D模型</th>
                                    <th>2D模型</th>
                                    <th>该料是否可用</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>

                                   <template v-if="ventorProd.product.imgUrl3 != null">
                                        <td class="model-3d has-model"></td>
                                    </template>
                                    <template v-else>
                                        <td class="model-3d"></td>
                                    </template>

                                    <template v-if="ventorProd.product.imgUrl2 != null">
                                        <td class="model-2d has-model"></td>
                                    </template>
                                    <template v-else>
                                        <td class="model-2d"></td>
                                    </template>

                                    <template v-if="ventorProd.product.isUser == 1">
                                        <td class="is-available">可用</td>
                                    </template>
                                    <template v-else-if="ventorProd.product.isUser == 0">
                                        <td class="is-available">不可用</td>
                                    </template>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        <template v-if="ventorProd.product.stockNumber">
                        <div class="table-info top">*在仓库中的信息</div>
                        <table class="table table04">
                            <thead>
                                <tr>
                                    <th>库存</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="storage">{{ventorProd.product.stockNumber}}</td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        </template>
                        </template>
                    </div>
                    </template>
                </div>
            </section>
	    </article>
	    <script type="text/javascript">
		$(function() {
			initData();
			$(".tabs a").click(function() {
				var $siblings = $(this).siblings();
				$siblings.each(function(i, value) {
					if ($(this).hasClass("active")) {
						$(this).removeClass("active");
					}
				});
				$(this).addClass("active");
			});

			//新增、编辑、列表页面显示隐藏
			$(".panel-industry-list").click(function(e) {
				var target = e.srcElement || e.target;
				if (target.className === "btn btn-add") {
					$(this).hide();
					$("#image").addClass("no-img");
					$(".panel-append").show();
				} else if (target.className === "icon icon-edit") {
					var gid = target.parentNode.nextElementSibling.innerText;
					getVentorProdById(gid);
					$(this).hide();
					$(".panel-append").show();
				}
				
			});
			$(".panel-append").click(function(e) {
				var target = e.srcElement || e.target;
				if (target.className === "return") {
					if ($("#gid").val() != "") {
						cacelImport();
						clear();
						$(this).hide();
						$(".panel-detail").show();
					} else {
						cacelImport();
						clear();
						$(this).hide();
						$(".panel-industry-list").show();
					}
				}else if (target.className === "btn btn-cancel") {
					if (target.id == "exitProperty") {
						$("#dialogProperty").hide();
					} else if(target.id == "exitCate"){
						$("#prodCate").hide();
					} else if(target.id == "exitVentor"){
						$("#dialogventor").hide();
					} else if ($("#gid").val() != "") {
						cacelImport();
						clear();
						$(this).hide();
						$(".panel-detail").show();
					} else {
						cacelImport();
						clear();
						$(this).hide();
						$(".panel-industry-list").show();
					}
				} else if (target.className === "btn btn-save") {
					if(target.id == "propertyname"){
						getProductName();
						$("#dialogProperty").hide();
					} else if(target.id == "saveCate"){
						$("#prodCate").hide();
					} else if(target.id == "saveVentor"){
						$("#dialogventor").hide();
					} else {
						if (checkInput()) {
							addAndEditVentorProduct();
							$(this).hide();
						}
					}
				}
			});
			$(".panel-detail").click(function(e) {
				var target = e.srcElement || e.target;
				if (target.className === "return" || target.className === "btn btn-cancel") {
					$(this).hide();
					$(".panel-industry-list").show();
				} else if (target.className === "btn btn-edit") {
					gid = $("#gid").val();
					getVentorProdInfoById(gid);
					$(this).hide();
					$(".panel-append").show();
				}
			});
	
			$("#page").on("click", ".pager a", function() {
	        	var nowPage = $(this).attr("data-index");
	        	console.info(nowPage);
	        	var totalPage = $(this).attr("totalPage");
	        	var direction = $(this).attr("direction");
	        	if (direction == undefined) {
	            	if (nowPage != undefined) {
	               	 	getProductInfoByPage(nowPage,$("#sousuo").prev().val());
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
	            		getProductInfoByPage(nowPage,$("#sousuo").prev().val());
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
                    getProductInfoByPage(nowPage,$("#sousuo").prev().val());
                }
            });
			
			
			$("#sousuo").click(function(){
				selValue = $(this).prev().val();
				getProductInfoByPage(null,selValue);
			});
			
		});
		
	 ventorProdVue = new Vue({
            el : "#ventorProdTab",
            data : {
                ventorProds : [],
                baseUrl :'${request.contextPath}/static/img/'
            }
       });

       pageVue = new Vue({
            el : "#page",
            data : {
                page : new Object()
            }
       });

     	ventorProdOneVue = new Vue({
     		el : "#ventorProduct",
     		data : {
     		 	ventorProd : new Object(),
           	baseUrl :'${request.contextPath}/static/img/'
     		}
     	});


        var path = "";
        var type = "";
		var propertyId = "";
		var id = "";
		function propertyValue(obj) {
			$(obj).siblings().css("color", "black");
			$(obj).css("color", "red");
			var proId = $(obj).next().next().val();
			var proName = $(obj).text();
			var idAndName = propertyId.split(",");
			i = 0;
			isRight = false;
			do {
				var map = idAndName[i].split("-");
				if (idAndName == "") {
					propertyId += proId + "-" + proName;
				} else if (map[0] == proId) {
					if (map[1] != proName) {
						propertyId = propertyId.replace(map[1], proName);
					}
					isRight = false;
					break;
				} else {
					isRight = true;
				}
				i++;
			} while (i < idAndName.length);
			if (isRight) {
				propertyId += "," + proId + "-" + proName;
			}
			id = propertyId.split(",");
		}

		function getProductName(){
			var name = "";
			for (var i = 0; i < id.length; i++) {
				var map = id[i].split("-");
				name += map[1];
			}
			if(name != "" && name != "undefined"){
				$("[name=prodProperty]").val(name);
			}

		}



		 function addImage(){
	 		   var formData = new FormData($("#fileform")[0]);
	 		   $.ajax({
	 			   	url : "${request.contextPath}/uploadImageController/uploadImage.do?type=img",
	 			   	type : "post",
	 			   	dataType : "json",
	 			   	data : formData,
	 			   	processData : false, // 不处理数据
	 			   	contentType : false, // 不设置内容类型
	 			   	success : function(data) {
	 			   		if (data.status < 0){
	 			   			toast('toast-warning',data.message);
	 			   			$("#image").addClass("no-img");
	 			   			$("#preview").html("");

	 			   		} else {
	 			   			toast('toast-success', data.message);
	 			   			$("#image").removeClass("no-img");
		 			   		path = data.fileName;
		 			   		type = data.type;
	 			   		}
	 			   	}
	 		   });
	 	   }
		function getProdCateInfo(obj){
            propertyId = "";
            id = "";
            sortNum = "";
            $("[name=prodProperty]").val("");
            $("[name=productName]").val("");


			$("#prod-cate li").removeClass("active");
			$(obj).addClass("active");
			$("[name=prodCateName]").val($(obj).text());
			$("#prodCateId").val($(obj).next().val());
		}

		function ventorValue(obj) {
			$(obj).siblings().css("color", "black");
			$("#ventorId").val($(obj).next().val());
			$(obj).css("color", "red");
			$("[name=ventorName]").val($(obj).text());
		}

		function addAndEditVentorProduct() {
			$.ajax({
				url : "${request.contextPath}/ventorProdController/addVentorProdInfo.do",
				type : "post",
				cache : false,
				data : {
					gid : $("#gid").val(),
					prodCategoryId : $("#prodCateId").val(),
					productCname : $("[name=productName]").val(),
					modelType : $("[name=modelType]").val(),
					modelName : $("[name=modelName]").val(),
					ventorId : $("#ventorId").val(),
					description : $("[name=description]").val(),
					id : propertyId,
					path : path,
					type : type
				},
				dataType : "json",
				success : function(data) {
					alert(data.message);
					if (data.status == 1) {
						toast('toast-success', data.message);
						clear();
						getProductInfoByPage(null,null);
						$(".panel-industry-list").show();
					} else if (data.status == -1) {
						toast('toast-warning',data.message);
						cacelImport();
						$("#preview").html("");
						$(".panel-append").show();
					} else if (data.status == 2) {
						toast('toast-success', data.message);
						clear();
						getProductInfoByPage(null,null);
						$(".panel-industry-list").show();
					} else if (data.status == -2) {
						toast('toast-warning',data.message);
						cacelImport();
						$(this).hide();
						$(".panel-detail").show();
					}
				},
				error : function() {}
			});
		}

		//展示图片
		function preview(file) {
			var prevDiv = document.getElementById('preview');
			if (file.files && file.files[0]) {
				var reader = new FileReader();
				reader.onload = function(evt) {
					prevDiv.innerHTML = '<img width="120" height="70" src="' + evt.target.result + '" />';
				}
				reader.readAsDataURL(file.files[0]);
			} else {
				prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
			}
			addImage();
		}

		  function checkTime(){
        	var timename=setTimeout(function(){
        		$(".toast").fadeOut(1000);
	        },2000);
	      }



		//验证
		function checkInput() {
			if ($("#preview").html() == ""){
				$(".toast").text("请上传图片！");
         		$(".toast").show();
         		checkTime();
 				return false;
			} else if ($("#prodCateId").val() == "") {
				$(".toast").text("请选择类别！");
         		$(".toast").show();
         		checkTime();
 				return false;
			} else if($("#gid").val() == "" && id == ""){
				$(".toast").text("请选择物料规格！");
         		$(".toast").show();
         		checkTime();
 				return false;
			} else if ($("[name=productName]").val() == "") {
				$(".toast").text("请输入物料名称！");
         		$(".toast").show();
         		checkTime();
 				return false;
			}  else if ($("#ventorId").val() == ""){
				$(".toast").text("请选择品牌！");
         		$(".toast").show();
         		checkTime();
 				return false;
			} else if ( $("[name=modelType]").val() == "") {
				$(".toast").text("请输入供应商型号！");
         		$(".toast").show();
         		checkTime();
 				return false;
			}
			return true;
		}

		//初始化
		function initData() {
			getProdCate();
			getVentor();
			getProductInfoByPage(null,null);
		}

		function getProperty(prodCateId) {
			$.ajax({
				url : "${request.contextPath}/propertyController/findPropertyInfo.do",
				type : "post",
				cache : false,
				data : {
					prodCateId : prodCateId
				},
				dataType : "json",
				success : function(data) {
					property = "";
					$.each(data, function(index, item) {
						property += "<li> <h4>" + data[index].propertyName + "</h4><ul> ";
						$.each(data[index].details, function(i, items) {
							property += " <li class='property' onclick='propertyValue(this)'>" + data[index].details[i].propertyValue + "</li><input type='hidden' value='" + data[index].details[i].gid + "' /><input type='hidden' value='" + data[index].gid + "' />";
						});
						property += "</ul>";
					});
					$("#propertyList").html(property);
				},
				error : function() {}
			});
		}

	 	function getVentorProdById(gid){
			$.ajax({
				url : "${request.contextPath}/ventorProdController/findVertorProdInfoById.do",
				type : "post",
				cache : false,
				data : {
					gid : gid
				},
				dataType : "json",
				success : function(data) {
					ventorProdOneVue.ventorProd = data;
				},
				error : function() {}
			});
		}

	 	function getVentorProdInfoById(gid){
			$.ajax({
				url : "${request.contextPath}/ventorProdController/findVertorProdInfoById.do",
				type : "post",
				cache : false,
				data : {
					gid : gid
				},
				dataType : "json",
				success : function(data) {
					$("#image").removeClass("no-img");
					$("#gid").val(data.gid);
					$("#prodCateId").val(data.productCate.gid);
					$("[name=prodCateName]").val(data.productCate.categoryName);
					$("[name=productName]").val(data.productCname);
					$("[name=prodProperty]").val(data.propertys);
					$("[name=modelType]").val(data.modelType);
					$("[name=modelName]").val(data.modelName);
					$("#ventorId").val(data.ventor.gid);
					$("[name=ventorName]").val(data.ventor.ventorName);
					$("[name=description]").val(data.description);
					$("#preview").html('<img width="120" height="70" src="${request.contextPath}/static/img/' + data.productFile.fileUrl + '" />');
				},
				error : function() {}
			});
		}




		function getProdCate() {
			$.ajax({
				url : "${request.contextPath}/productCategoryController/selectCategoryTree.do",
				type : "post",
				cache : false,
				dataType : "json",
				success : function(data) {
					alldata = "";
					$.each(data,function(i,item){

						alldata +="<li><h4>"+data[i].categoryName+"</h4><ul>";

						$.each(data[i].categorys,function(j,item){

							alldata +="<li><h5>"+data[i].categorys[j].categoryName+"</h5><ul>" ;

							 $.each(data[i].categorys[j].categorys,function(k,item){
								alldata += "<li onclick='getProdCateInfo(this)'>"+data[i].categorys[j].categorys[k].categoryName+"</li><input type='hidden' value='"+data[i].categorys[j].categorys[k].gid+"'>";
							 });
							 alldata += "</ul></li>";
						});

						alldata += "</ul></li>";
					});
					$("#prod-cate").html(alldata);
				},
				error : function() {}
			});
		}


		function getProductInfoByPage(nowPage,selValue){
			$.ajax({
				url : "${request.contextPath}/ventorProdController/findVentorProdInfoByPage.do",
				type : "post",
				cache : false,
				data : {
					page : nowPage,
					selValue : selValue
				},
				dataType : "json",
				success : function(data) {
					ventorProdVue.ventorProds = data.ventorProds;
					pageVue.page = data.page;
					$("#sousuo").prev().val(selValue);
				},
				error : function() {}
			});
		}


		function getVentor() {
			$.ajax({
				url : "${request.contextPath}/ventorController/findVentorInfo.do",
				type : "post",
				cache : false,
				dataType : "json",
				success : function(data) {
					$(".items").html("");
					ventor = " ";
					$.each(data, function(index, item) {
						ventor += "<li class='ventors' onclick='ventorValue(this)' >" + data[index].ventorName + "</li><input type='hidden' value='" + data[index].gid + "' />";
					});
					$(".items").append(ventor);
				},
				error : function() {}
			});
		}

		function clear(){
			$("#gid").val("");
			$("[name=prodCateName]").val("");
			$("[name=productName]").val("");
			$("[name=modelType]").val("");
			$("[name=modelName]").val("");
			$("[name=ventorName]").val("");
			$("[name=description]").val("");
			$("#preview").html("");
			$("#dialogventor li").removeClass("active");
			$("#prod-cate li").removeClass("active");
			$("[name=prodProperty]").val("");
		}

		function cacelImport(){
			$.ajax({
				url : "${request.contextPath}/uploadImageController/cacelImport.do",
				type : "post",
				cache : false,
				data : {
					path : path
				},
				dataType : "json",
				success : function(data) {
					path = "";
			        type = "";
					propertyId = "";
					id = "";
				},
				error : function() {}
			});

		}

		function showQAQ(obj){
			$(".panel-industry-list").hide();
			gid = $(obj).children("td").last().find("span").text();
			$("#gid").val(gid);
			getVentorProdById(gid);
			$(".panel-detail").show();
		}
		var i = 0;
		function clickType(obj){
			var yuans = $(obj).next();
			$(".dialog").hide();
			if (i == 0) {
				yuans.css("display","block");
				i = 1;
			} else {
				yuans.css("display","none");
				i = 0;
			}

		}

		var j = 0;
		function clickProperty(obj){
			var yuans = $(obj).next();
			$(".dialog").hide();
			if (j == 0) {
				if ($("#prodCateId").val() == ""){
					toast('toast-success', data.message);
					toast('toast-warning',"清先选择类别！");
					return;
				} else {
					getProperty($("#prodCateId").val());
				}
				yuans.css("display","block");
				j = 1;
			} else {
				yuans.css("display","none");
				j = 0;
			}

		}

		function selectKey(){
			if (event.keyCode == 13){  //回车键的键值为13
				getProductInfoByPage(null,$("#sousuo").prev().val());
			}
		}

		var k = 0;
		function clickVentor(obj){
			var yuans = $(obj).next();
			$(".dialog").hide();
			if (k == 0) {
				yuans.css("display","block");
				k = 1;
			} else {
				yuans.css("display","none");
				k = 0;
			}
		}

		function toast(className,text){
            var html = '<div class="toast ' + className + '">' + '<p>' + text + '</p>' + '</div>';
            var $toast = $(html).appendTo($("body")).show();
            window.setTimeout(function(){
                $toast.fadeOut(2000);
            },2000);
        }

		//退出登录
        function outLogin(){
            window.location.href = '${request.contextPath}/loginController/outLogin.do';
        }
	</script>
    </body>
</html>
 <!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="renderer" content="webkit"/>
    <title>料库</title>
    <link type="text/css" rel="stylesheet/less" href="${request.contextPath}/static/css/style.less">
    <script src="${request.contextPath}/static/js/less-2.7.1.min.js"></script>
    <script src="${request.contextPath}/static/js/jquery-1.11.3.min.js"></script>
    <script src="${request.contextPath}/static/js/ajaxfileupload.js"></script>
    <link rel="stylesheet" href="${request.contextPath}/static/css/sweetalert.css">
    <script type="text/javascript"
	src="${request.contextPath}/static/js/sweetalert.min.js"></script>
	<script src="${request.contextPath}/static/js/vue.js"></script>
    <!--[if lt IE9]>
    <script type="text/javascript" src="js/html5shiv.min.js"></script>
    <![endif]-->
</head>
<body>
    <article class="material" class="toast toast-success">
        <header>
            <h1 class="brand"><span class="icon icon-logo"></span>物料系统</h1>
            <div class="tabs">
                <a class="active" href="${request.contextPath}/selectionProductController/toMaterial.do">料库</a>
                <a href="${request.contextPath}/selectionProductController/toProductListPage.do">产品结构清单</a>
                <a href="${request.contextPath}/selectionProductController/toPropertyManage.do">规格管理</a>
                <a href="${request.contextPath}/selectionProductController/toCategoryManage.do">分类管理</a>
            </div>
            <div class="user-info">
                <span class="name">${userInfo.userName}</span>
                <span class="position">${userInfo.roleName}</span>
                <a class="logout" href="javascript:outLogin();">退出</a>
            </div>
        </header>
        <section id="productInfo">
            <!--料库列表-->
            <div class="panel panel-material-list">
                <div class="panel-header">                    
                    <div class="category-container">
                    	<span class="icon icon-list" id="fenlei" onclick="clickforfenlei(this);"></span>
                    	<!--分类选择界面  -->
                        <aside class="dialog dialog-pro-category" id="prodCate-fenlei" >
								 <header >
									<div class="btn-group" >
                                        <button class="btn btn-save" id="saveCate-fenlei" type="button" >确认</button>
                                        <button class="btn btn-cancel" id="exitCate-fenlei" type="button" >取消</button>
                                        
                                    </div>	
								</header>
                                
                                <section >
                                    <ul id="prod-cate-fenlei"  >
                                    
                                    </ul>
                                </section>               
                        </aside>
                    </div>
                 	<div class="search-bar">
                        <span class="icon  icon-search"></span>
                        <input type="text" id="sousuoInput" onkeydown="selectKey()" placeholder="输入搜索内容"/>
                        <button id="sousuo">搜索</button>
                    </div>
                    <div class="btn-group">
                        <button class="btn btn-add" type="button">新增</button>
                    </div>
                     <div class="btn-group">
                        <button class="btn btn-import" type="button" id="downLoadModel">下载模版</button>
                    </div>
                     <div class="btn-group">
                        <form class="fileformExcel" method= "post" enctype ="multipart/form-data">
                        <input type="button" value="导入物料" onclick="importExcelId.click()" class="btn btn-import">  
					 	<input type="file" id="importExcelId" style="display:none" onchange="importExcel(this)"  name="fileName">
				   		</form>
                     </div>
                     <div class="btn-group">
                        <button class="btn btn-import" type="button" onclick="exportProducts()" id="exportProductsId">导出物料</button>
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
                                <th onclick="sortTable()">物料编号<span>↑↓</span>
                                <th>供应商型号</th>
                            </tr>
                        </thead>
                        <tbody id="productTab">
                            <template v-for="item in products">
                             <template v-if="item.isUser == 0">
	                             <tr  class="unavailable" id="info" onclick="showQAQ(this)" v-if="item && item.prodCate && item.ventor">
	                               	<template v-if="item.isRecommend == 1">
                                         <td class="recommend img" v-if="item.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
                                    <td v-else></td>
                                    </template>
                                    <template v-if="item.isRecommend == 2">
                                         <td class="old img" v-if="item.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
                                    <td v-else></td>
                                    </template>
                                    <template v-if="item.isRecommend == 0">
                                         <td v-if="item.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
                                    <td v-else></td>
                                    </template>
	                                <td>{{item.prodCate.categoryName}}</td>
	                                <td class="name">{{item.productName}}</td>
	                                <td>{{item.propertys}}</td>
	                                <td>{{item.ventor.ventorName}}</td>
	                                <td>{{item.productCode}}</td>
	                                <td>{{item.modelType}}</td>
	                                <td style="display: none;"><span>{{item.gid}}</span></td>
	                             </tr>
                             </template>
                             <template v-else>
                             	<tr id="info" onclick="showQAQ(this)" v-if="item && item.prodCate && item.ventor">
	                                <template v-if="item.isRecommend == 1">
	                               		 <td class="recommend img" v-if="item.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
		                            <td v-else></td>
	                               	</template>
                                    <template v-if="item.isRecommend == 2">
                                         <td class="old img" v-if="item.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
                                    <td v-else></td>
                                    </template>
	                                <template v-if="item.isRecommend == 0">
	                               		 <td v-if="item.productFile != null" class="img" v-bind:style="{'background-image':'url('+baseUrl+item.productFile.fileUrl+')'}"></td>
		                            <td v-else></td>
	                               	</template>
	                                <td>{{item.prodCate.categoryName}}</td>
	                                <td class="name">{{item.productName}}</td>
	                                <td class="name">{{item.propertys}}</td>
	                                <td class="type">{{item.ventor.ventorName}}</td>
	                                <td class="id-number">{{item.productCode}}</td>
	                                <td>{{item.modelType}}</td>
	                                <td style="display: none;"><span>{{item.gid}}</span></td>
	                             </tr>
                             </template>
                         </template>
                        </tbody>
                    </table>
                    <div id="page" class="table-footer">
                        <div class="table-info">
                            <template v-if="page">
                                共 {{page.totalPage}} 页 {{page.totalRecord}} 条记录
                            </template>
                        </div>
                        <template v-if="page && page.pageList">
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
            <!--新增到料库-->
            <div class="panel panel-append">
                <div class="panel-header">
                    <a id="reutrn-edit" class="return" href="javascript:;">返回</a>
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
                                <form class="fileform" method= "post" enctype ="multipart/form-data">
	                                <input type="file" name="fileName" onchange="preview(this)" id = "updaloadFile" />
                                </form></td>
                                <td>
                                    <select  onchange="categoryChange(this);" id="categorySel" name="">
                                        <option value="0">请选择</option>
                                        <template v-for="item in category">
                                            <option :value="item.gid"  selected='selected'>{{item.categoryName}}</option>
                                        </template>
                                    </select>
                                </td>
                                <td class="type">
                                    <div class="input-select">
                                        <input type="text" readonly="readonly" name="prodCateName"   placeholder="请选择"/>
                                        <input type="hidden" id="prodCateId"  value="" />
                                        <span class="icon icon-list" onclick="clickType(this);"></span>
                                        <aside class="dialog dialog-pro-category" id="prodCate">
                                            <header>
                                                <div class="btn-group">
                                                    <button class="btn btn-save" id="saveCate" type="button">确认</button>
                                                    <button class="btn btn-cancel" id="exitCate" type="button">取消</button>
                                                </div>
                                            </header>
                                            <section>
                                                <ul id="prod-cate">

                                                </ul>
                                            </section>
                                        </aside>
                                    </div>
                                </td>
                                <td class="property">
                                    <div class="input-select">
                                        <input type="text" name="prodProperty" readonly="readonly" id="property" placeholder="请选择"/>
                                        <span class="icon icon-list" onclick="clickProperty(this);"></span>
                                        <aside class="dialog-property" id="dialogProperty">
                                            <header>
                                                <h3>选择属性，构成物料名称</h3>
                                                <div class="btn-group">
                                                    <button class="btn btn-save" id="saveProperty" type="button">确认</button>
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
                                <td class="name"><input type="text" maxlength="20" name="productName"  placeholder="请输入"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="table table02">
                        <thead>
                            <tr>
                                <th class="required">品牌</th>
                                <th class="required">供应商型号</th>
                                <th>参考单价</th>
                                <th>系列</th>
                                <th>备注</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="supplier">
                                    <div class="input-select">
                                        <input type="text" readonly="readonly" name="ventorName" placeholder="请选择"/>
                                        <input type="hidden" id="ventorId" value="" />
                                        <span class="icon icon-list" onclick="clickVentor(this);"></span>
                                        <aside class="dialog dialog-supplier" id="dialogventor">
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
                                <td><input type="text" maxlength="30"  name="modelType" placeholder="请输入"/></td>
                                <td><input type="number" maxlength="15"  name="unitPrice" placeholder="请输入"/></td>
                                <td><input type="text" name="modelName"  placeholder="请输入"/></td>
                                <td><input type="text" maxlength="20" name="description" placeholder="请输入"/></td>
                                <input type="hidden" id="gid" value="" />
                            </tr>
                        </tbody>
                    </table>
                    <table class="table table03">
                        <thead>
                            <tr>
                                <th class="required">物料编号</th>
                                <th class="required">基本单位</th>
                                <th class="required">单位精度</th>
                                <th class="required">最高库存</th>
                                <th class="required">安全库存</th>
                                <th class="required">最低库存</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="id-number"><input type="text" name="prodCode" placeholder="请输入"/></td>
                                <td>
                                    <select id="basicUnit">
                                        <option value="0" selected="selected">请选择</option>
                                        <option value="个">个</option>
                                        <option value="件">件</option>
                                        <option value="批">批</option>
                                        <option value="斤">斤</option>
                                        <option value="克">克</option>
										<option value="KG">KG</option>
                                        <option value="片">片</option>
                                        <option value="张">张</option>
                                        <option value="L">L</option>
                                        <option value="ML">ML</option>
										<option value="粒">粒</option>
										<option value="PCS">PCS</option>
                                    </select>
                                </td>
                                <td>
                                    <select id="amount">
                                        <option value="0" selected="selected">请选择</option>
                                        <option value="1">1</option>
                                        <option value="0.1">0.1</option>
                                        <option value="0.01">0.01</option>
                                        <option value="0.001">0.001</option>
                                        <option value="0.0001">0.0001</option>
                                        <option value="0.00001">0.00001</option>
                                        <option value="0.000001">0.000001</option>
                                        <option value="0.0000001">0.0000001</option>
                                    </select>
                                </td>
                                <td><input type="number" min="0" max="999999999" name="maxStock"  placeholder="请输入"/></td>
                                <td><input type="number" min="0" max="999999999" name="safeStock" placeholder="请输入"/></td>
                                <td><input type="number" min="0" max="999999999" name="minStock"  placeholder="请输入"/></td>
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
                               <th class="required">是否推荐</th>
                            </tr>
                        </thead>
                        <tbody>
                            <td id="3D" class="model-3d"><form class="fileform3" method= "post" enctype ="multipart/form-
                            "><input type="file" onchange="addThreeD()" value="" name="fileName"/></form></td>
                            <td id="2D" class="model-2d"><form class="fileform2" method= "post" enctype ="multipart/form-data"><input type="file" onchange="addTwoD()" name="fileName"/></form></td>
                            <td><input type="text" maxlength="15" name="easyCode" placeholder="请输入"/></td>
                            <td><input type="text" maxlength="15" name="keyWord" placeholder="请输入"/></td>
                            <td class="is-available">
                            	<input type="hidden" name="isUser" value=""/>
                                <input id="is-available" name = "isShow" type="checkbox"/>
                                <label for="is-available"></label>
                            </td>
                            <td class="is-recommend">
                                <select id="isRecommend">
                                    <option value="-1"  selected="selected">请选择</option>
                                    <option value="1">推荐</option>
                                    <option value="0">正常</option>
                                    <option value="2">滞留</option>
                                </select>
                            </td>
                        </tbody>
                    </table>
                    <div id="ziyan" class="table-info bottom">*在此新增的信息会同步至行业资料库</div>
                </div>
                <div class="panel-footer">
                    <div class="btn-group">
                        <button class="btn btn-save" type="button">保存</button>
                        <button class="btn btn-cancel" type="button">取消</button>
                    </div>
                </div>
            </div>
            <!--料库详情-->
            <div class="panel panel-detail">
                <div class="panel-header">
                    <a id="return-list" class="return" href="javaScript:;">返回</a>
                    <div class="btn-group">
                        <button class="btn btn-edit" type="button">编辑</button>
                        <button class="btn btn-delete" style="display: none;" type="button">删除</button>
                    </div>
                </div>
                <div id="ProductOne" class="panel-body">
                <templete v-if="product && product.prodCate && product.ventor">
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
	                            <tr v-bind:class="{unavailable : product.isUser == 1}">
	                                <td class="img" v-if="product.productFile != null" v-bind:style="{'background-image':'url('+baseUrl+product.productFile.fileUrl+')'}"></td>
	                               	<td v-else></td>
	                               	<td>{{product.category.categoryName}}</td>
	                                <td class="type" v-if="product.prodCate.categoryName != null">{{product.prodCate.categoryName}}</td>
	                                <td class="property">{{product.propertys}}</td>
	                                <td>{{product.productName}}</td>
	                            </tr>
                        </tbody>
                    </table>
                    <table class="table table02">
                        <thead>
                            <tr>
                                <th>品牌</th>
                                <th>供应商型号</th>
                                <th>参考单价</th>
                                <th>系列</th>
                                <th>备注</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<template v-if="product.isUser == 1">
	                            <tr class="unavailable">
	                                <td>{{product.ventor.ventorName}}</td>
	                                <td>{{product.modelType}}</td>
	                                 <td>{{product.unitPrice}}</td>
	                                <template v-if="product.modelName != null">
	                                	<td>{{product.modelName}}</td>
	                                </template>
	                                <template v-else>
	                                	<td class="no-data">{{product.modelName}}</td>
	                                </template>
	                                <td>{{product.description}}</td>
	                            </tr>
	                        </template>
	                        <template v-else>
	                            <tr>
	                                <td>{{product.ventor.ventorName}}</td>
	                                <td>{{product.modelType}}</td>
                                    <td>{{product.unitPrice}}</td>
	                                <td>{{product.modelName}}</td>
	                                <td>{{product.description}}</td>
	                            </tr>
	                        </template>
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
                                <td >{{product.productCode}}</td>
                                <td>{{product.basicUnit}}</td>
                                <td>{{product.amountPrecision}}</td>
                                <td>{{product.highStock}}</td>
                                <td>{{product.safeStock}}</td>
                                <td>{{product.lowStock}}</td>
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
                            	<template v-if="product.imgUrl3 != null">
                            		<td class="model-3d has-model"></td>
                            	</template>
                            	<template v-else>
                            		<td class="model-3d"></td>
                            	</template>
                                
                                <template v-if="product.imgUrl2 != null">
                            		<td class="model-2d has-model"></td>
                            	</template>
                            	<template v-else>
                            		<td class="model-2d"></td>
                            	</template>
                                <td>{{product.easyCode}}</td>
                                <td class="keyword" v-if="product.keyWord != null">{{product.keyWord}}</td>
                                <template v-if="product.isUser == 1">
                                	<td class="is-available">可用</td>
                                </template>
                                <template v-else-if="product.isUser == 0">
                                	<td class="is-available">不可用</td>
                                </template>
                                <template v-else>
                                	<td class="is-available"></td>
                                </template>
                                <template v-if="product.isRecommend != 1">
                                	<td class="is-recommend">否</td>
                                </template>
                                <template v-else>
                                	<td class="is-recommend">是</td>
                                </template>
                            </tr>
                        </tbody>
                    </table>
                    <template v-if="product.stockNumber != 0">
                    <div class="table-info top">*在仓库中的信息</div>
                    <table class="table table05">
                        <thead>
                            <tr>
                                <th>库存</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="storage">{{product.stockNumber}}</td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    </template>
                </templete>
                </div>
            </div>
        </section>
    </article>
 
    <script type="text/javascript">
    	var pageFlag = 1;
    	var searchFlag = "";
    
        $(function(){
        	initData();
        	$("[name='isUser']").val("1");
        	$("input[value='no']").attr("checked", "checked");
            $(".tabs a").click(function(){
                var $siblings = $(this).siblings();
                $siblings.each(function(i, value){
                    if($(this).hasClass("active")){
                        $(this).removeClass("active");
                    }
                });
                $(this).addClass("active");
            });
            
            
          
    		
    		
            
            //新增、编辑、列表页面显示隐藏
            $(".panel-material-list").click(function(e){
                var target = e.srcElement || e.target;
                if(target.className === "btn btn-add"){
                   $(this).hide();
                   $("#ziyan").show();
                   $("#basicUnit").val(0);
                   $("#amount").val(0);
                   $("#image").addClass("no-img");
                   $(".panel-append").show();
                }
            });
            $(".panel-append").click(function(e){
                var target = e.srcElement || e.target;
                if(target.className === "return"){
                	if ($("#gid").val() != ""){
                		cacelImport();
               		    $(this).hide();
                        $(".panel-detail").show();
                        clearNotGid();
                	} else {
                		cacelImport();
                		clearNotGid();
               		    $(this).hide();
                        $(".panel-material-list").show();
                	}
                } else if(target.className === "btn btn-cancel"){
                	if (target.id == "exitProperty"){
                		$("#dialogProperty").hide();
                	} else if (target.id == "exitCate"){
                		$("#prodCate").hide();
                	} else if (target.id == "exitVentor"){
                		$("#dialogventor").hide();
                	} else if ($("#gid").val() != ""){
                		cacelImport();
                		clearNotGid();
               		    $(this).hide();
                        $(".panel-detail").show();
                	} else {
                		cacelImport();
                		clear();
               		    $(this).hide();
                        $(".panel-material-list").show();
                	}
                   
                }else if(target.className === "btn btn-save"){
                	if(target.id == "saveProperty"){
						getProductName();
						$("#dialogProperty").hide();
					} else if (target.id == "saveCate"){
						
                		$("#prodCate").hide();
                	} else if (target.id == "saveVentor"){
                		$("#dialogventor").hide();
                	} else {
						if (check()) {
	                		addProduct(this);
	                    }
					}
                }
            });
            $(".panel-detail").click(function(e){
                var target = e.srcElement || e.target;
                if(target.className === "return"){
                    gid = "";
                    $(this).hide();
                     $(".panel-material-list").show();
                } else if (target.className === "btn btn-edit"){
                    $(this).hide();
                    getEditInfo();
                    $("#ziyan").hide();
                    $(".panel-append").show();
                } else if (target.className === "btn btn-cancel") {
           		  
                }
            });
            
            //radio选择
            $(".check-group").change(function(){
             	var val=$("input:radio[name=is-device]:checked").val();
            	if (val == "yes") {
            		$("[name=deviceCode]").removeAttr("disabled");
            	} else {
            		$("[name=deviceCode]").attr("disabled","disabled");
            	}
            });
            
            $("#is-available").click(function(){
            	if($(this).is(':checked')){
            		$("[name='isUser']").val("0");
            	} else {
            		$("[name='isUser']").val("1");
            	}
            });
            

            $(".letters").children("li").click(function(){
            	$(this).siblings().css("color", "black");
    			$(this).css("color", "red");
    			if ($(this).text() == "所有") {
    				getVentor(null);
    			} else {
    				getVentor($(this).text());
    			}
            	
            });
            
            
        $("#page").on("click", ".pager a", function() {
        	var nowPage = $(this).attr("data-index");
        	pageFlag = nowPage;						//修改查询的时候不能停留当前页bug
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
        
         
        //物料excel模版下载
        $("#downLoadModel").click(function(){
			var url = "http://"+location.host+"/materials/static/img/excel/产品列表模版.xlsx";
			window.open(url)  
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
			modelType = $(this).prev().val();
			searchFlag = modelType;
			getProductInfoByPage(pageFlag,searchFlag);
		});    
    });
        
		productVue = new Vue({
            el : "#productTab",
            data : {
                products : [],
                baseUrl :'${request.contextPath}/static/img/'
            }
        });

        categoryVue = new Vue({
            el : "#categorySel",
            data : {
                category : []
            }
        });
		  
        
        pageVue = new Vue({
            el : "#page",
            data : {
                page : new Object()
            }
        });
         
        ProductOneVue = new Vue({
    	    el : "#ProductOne",
    	    data : {
    		    product : new Object(),
    		    baseUrl :'${request.contextPath}/static/img/'
    	    }
        });
        
           function check(){
         	if ($("#preview").html() == ""){
         		toast('toast-warning', "请上传图片！");
 				return false;
 			} else if ($("[name=prodCateName]").val() == "") {
         		toast('toast-warning', "请选择产品类别！");
         		return false;
         	} else if ($("[name=prodProperty]").val() == "") {
         		toast('toast-warning', "请选择物料规格！");
           		return false;
         	} else if ($("[name=productName]").val() == "") {
         		toast('toast-warning', "请输入物料名称！");
         		return false;
         	}  else if ($("[name=ventorName]").val() == "") {
         		toast('toast-warning', "请选择品牌！");
         		return false;
         	} else if ($("[name=modelType]").val() == "") {
         		toast('toast-warning', "请输入型号！");
         		return false;
         	} else if ($("[name=prodCode]").val() == "") {
         		toast('toast-warning', "请输入物料号！");
         		return false;
         	} else if ($("#basicUnit").val() == 0) {
         		toast('toast-warning', "请选择基本单位！");
         		return false;
         	} else if ($("#amount").val() == 0) {
         		toast('toast-warning', "请选择单位精度！");
         		return false;
         	} else if ($("[name=maxStock]").val() == "") {
         		toast('toast-warning', "请输入最高库存！");
         		return false;
         	} else if ($("[name=maxStock]").val().length > 10) {
         		toast('toast-warning', "最高库存数目不能大于十位数！");
         		return false;
         	} else if ($("[name=maxStock]").val() < 0) {
         		toast('toast-warning', "请输入大于0的数字！");
         		return false;
         	} else if ($("[name=safeStock]").val() == "") {
         		toast('toast-warning', "请输入安全库存！");
         		return false;
         	} else if ($("[name=safeStock]").val().length > 10) {
         		toast('toast-warning', "安全库存数目不能大于十位数！");
         		return false;
         	} else if ($("[name=safeStock]").val() < 0) {
         		toast('toast-warning', "请输入大于0的数字！");
         		return false;
         	} else if ($("[name=minStock]").val() == "") {
         		toast('toast-warning', "请输入最低库存！");
         		return false; 
         	} else if ($("[name=minStock]").val().length > 10) {
         		toast('toast-warning', "最小库存数目不能大于十位数！");
         		return false;
         	}  else if ($("[name=minStock]").val() < 0) {
         		toast('toast-warning', "请输入大于0的数字！");
         		return false;
         	} else if ($("#isRecommend").val() == -1) {
         		toast('toast-warning', "请选择是否推荐！");
         		return false;
         	}   
         	
         	return true;
         } 
         
        var path = "";
        var type = ""
        
        function addProduct(event) {
			$.ajax({
				url : "${request.contextPath}/productController/addProductInfo.do",
				type : "post",
				cache : false,
				data : {
					gid : $("#gid").val(),
					ventorId : $("#ventorId").val(),
					prodCategoryId : $("#prodCateId").val(),
					productCode : $("[name=prodCode]").val(),
					keyWord : $("[name=keyWord]").val(),
					modelType : $("[name=modelType]").val(),
					modelName : $("[name=modelName]").val(),
					description : $("[name=description]").val(),
					productName : $("[name=productName]").val(),
					easyCode : $("[name=easyCode]").val(),
					basicUnit : $("#basicUnit").val(),
					amountPrecision : $("#amount").val(),
					highStock : $("[name=maxStock]").val(),	
					lowStock : $("[name=minStock]").val(),
					safeStock : $("[name=safeStock]").val(),
					isUser : $("[name='isUser']").val(),		
					isRecommend : $("#isRecommend").val(),
                    unitPrice : $("[name='unitPrice']").val(),
					id : id,
					path : path,
					type : type
				},
				dataType : "json",
				success : function(data) {
					if (data.status == 1) {
						toast('toast-success', data.message);
						clear();
						getProductInfoByPage(pageFlag,searchFlag);
                        $(event).hide();
						$(".panel-material-list").show();
					} else if(data.status == -1){
						toast('toast-warning', data.message);
						$(".panel-append").show();
					} else if (data.status == 2) {
						toast('toast-success', data.message);
						clear();
                        $(event).hide();
						getProductInfoByPage(pageFlag,searchFlag);
						$(".panel-material-list").show();
					} else if(data.status == -2) {
						toast('toast-warning', data.message);
						cacelImport();
						$("#preview").html("");
						$(this).hide();
						$(".panel-detail").show();
					}
				},
				error : function() {}
			});
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
				},
				error : function() {}
			});
			
		}
        
        function addImage(){
 		   var formData = new FormData($(".fileform")[0]);
 		   $.ajax({
 			   	url : "${request.contextPath}/uploadImageController/uploadImage.do?type=img",
 			   	type : "post",
 			   	dataType : "json",
 			   	data : formData,
 			   	processData : false, // 不处理数据
 			   	contentType : false, // 不设置内容类型
 			   	success : function(data) {
 			   		//$('input[type=file]').wrap('<form>').closest('form').get(0).reset();
 			   		$("#updaloadFile").val("");
	 			   	if (data.status < 0) {
	 			   		$("#image").addClass("no-img");
	 			   		$("#preview").html("");
	 			   		toast('toast-success', data.message);
			   		} else{
			   			$("#image").removeClass("no-img");
			   			toast('toast-warning', data.message);
						path += data.fileName+",";
				   		type += data.type+",";
			   		}
 			   	}
 		   }); 
 		 
 	   }
        
        function addTwoD(){
  		   var formData = new FormData($(".fileform2")[0]);
  		   $.ajax({
  			   	url : "${request.contextPath}/uploadImageController/uploadImage.do?type=2D",
  			   	type : "post",
  			   	dataType : "json",
  			   	data : formData,
  			   	processData : false, // 不处理数据
  			   	contentType : false, // 不设置内容类型
  			   	success : function(data) {
	 			   	if (data.status < 0) {
	 			   		toast('toast-success', data.message);
			   		} else {
			   		 	$("#2D").addClass("has-model");
			   		 	toast('toast-warning', data.message);
			   			path += data.fileName+",";
				   		type += data.type+",";
			   			
			   		}
  			   	}
  		   }); 
  	   }
        
        function addThreeD(){
  		   var formData = new FormData($(".fileform3")[0]);
  		   $.ajax({
  			   	url : "${request.contextPath}/uploadImageController/uploadImage.do?type=3D",
  			   	type : "post",
  			   	dataType : "json",
  			   	data : formData,
  			   	processData : false, // 不处理数据
  			   	contentType : false, // 不设置内容类型
  			   	success : function(data) {
	 			   	if (data.status < 0) {
	 			   		toast('toast-success', data.message);
			   		} else {
			   			$("#3D").addClass("has-model");
			   			toast('toast-warning', data.message);
			   			path += data.fileName+",";
				   		type += data.type+",";
			   		}
  			   	}
  		   }); 
  	   }
        
         
		function getProdById(gid){	
			$("#is-available").attr("checked","");
			$.ajax({
				url : "${request.contextPath}/productController/findProdInfoById.do",
				type : "post",
				cache : false,
				data : {
					productId : gid
				},
				dataType : "json",
				success : function(data) {
					ProductOneVue.product = data;
				},
				error : function() {}
			});
		}
		
		function getProdInfoById(gid){
			$.ajax({
				url : "${request.contextPath}/productController/findProdInfoById.do",
				type : "post",
				cache : false,
				data : {
					productId : gid
				},
				dataType : "json",
				success : function(data) {
					
					$("#image").removeClass("no-img");
					$("#gid").val(data.gid);
					$("#ventorId").val(data.ventor.gid);
					$("#categorySel").val(data.category.gid);
					categoryChange(data.category.gid);
					$("[name=ventorName]").val(data.ventor.ventorName);
					$("#prodCateId").val(data.prodCategoryId);
					$("[name=prodCateName]").val(data.prodCate.categoryName);
					$("[name=prodCode]").val(data.productCode);
					$("[name=keyWord]").val(data.keyWord);
					$("[name=modelType]").val(data.modelType);
					$("[name=modelName]").val(data.modelName);
                    $("[name=unitPrice]").val(data.unitPrice);
					$("[name=description]").val(data.description);
					$("[name=prodProperty]").val(data.propertys);
					$("[name=productName]").val(data.productName);
					$("[name=easyCode]").val(data.easyCode);
					$("#basicUnit").val(data.basicUnit);
					$("#amount").val(data.amountPrecision);
					$("[name=maxStock]").val(data.highStock);
					$("[name=minStock]").val(data.lowStock);
					$("[name=safeStock]").val(data.safeStock);
					$("[name='isUser']").val(data.isUser);
					$("#isRecommend").val(data.isRecommend);
					if(data.imgUrl3 != null && data.imgUr13 != ""){
						$("#3D").addClass("has-model");
					}
					if(data.imgUrl2 != null && data.imgUrl2 != ""){
						$("#2D").addClass("has-model");
					}
					if (data.isUser == 0) {
						document.getElementsByName("isShow")[0].checked = true;
					} else {
						document.getElementsByName("isShow")[0].checked = false;
					} 
					$("#preview").html('<img width="120" height="70" src="${request.contextPath}/static/img/' + data.productFile.fileUrl + '" />');
				},
				error : function() {}
			});
		}
		
		
         
	
		function getProdCateInfo(obj){
            propertyId = "";
            id = "";
            sortNum = "";
            $("[name=prodProperty]").val("");
            //$("[name=productName]").val("");

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
        
        //展示图片
		function preview(file){
			var prevDiv = document.getElementById('preview');
            if (file.files && file.files[0]){    
                var reader = new FileReader();    
                reader.onload = function(evt){    
                    prevDiv.innerHTML = '<img width="120" height="70" src="' + evt.target.result + '" />';    
                }      
                reader.readAsDataURL(file.files[0]);    
            }else{    
                prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';    
            }
            addImage();
            
		}
        
        //导入bom的xcel文件
		function importExcel(file){
			var importExcel = document.getElementById('importExcelId');
			if (importExcelId == null || "" == importExcelId ){  
				alert("请您先选择要上传的文件");
			} 
			var formData = new FormData($(".fileformExcel")[0]);
			  $.ajax({
	 			   	url : "${request.contextPath}/importController/importProdExcel.do?type=excel",
	 			   	type : "post",
	 			   	dataType : "json",
	 			   	data : formData,
	 			   	processData : false, // 不处理数据
	 			   	contentType : false, // 不设置内容类型
	 			   	success : function(data) {
	 			   		$("#importExcelId").val("");				//解决反复上传同一文件引起的不能上传
		 			   	if (data.status == 1) {
		 			   		toast('toast-success',"上传成功");
		 			   		return;
				   		}else if(data.isError != null && "" != data.isError){
				   			toast('toast-warning', data.isError);
				   			return;
				   		}else if(data.isNull != null && "" != data.isNull ){
				   			toast('toast-warning', data.isNull);
				   			return;
				   		}else if(data.isRepeat != null && "" != data.isRepeat){
				   			toast('toast-warning', data.isRepeat);
				   			return;
				   		}else if(data.status == -1){
				   			toast('toast-warning', data.message);
				   			return;
				   		}
	 			   	}
	 		   }); 
		}
        
        //导出物料
        function exportProducts(){
        	window.location.href = "${request.contextPath}/exportController/exportProductList.do";
        }
		
		
        var propertyId = "";
		var id = "";
		var sortNum = "";
		function propertyValue(obj) {
			$(obj).siblings().css("color", "black");
			$(obj).css("color", "red");
			
			var proId = $(obj).next().next().val();
			var proName = $(obj).text();
			var sortNo = $(obj).prev().val();
			var idAndName = propertyId.split(",");
			var sortNums = sortNum.split(",");
			i = 0;
			isRight = false;
			do {
				var map = idAndName[i].split("&");
				if (idAndName == "") {
					propertyId += proId + "&" + proName;
					sortNum += sortNo +",";
				} else if (map[0] == proId) {
					sortNum = sortNum.replace(sortNums[i],sortNo);
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
				propertyId += "," + proId + "&" + proName;
				sortNum +=sortNo+",";
			}
			id = propertyId;
		}

		function getProductName(){
			var ids = id.split(",");
			var sortNums = sortNum.split(",");
			var properName = "";
			var prodName = "";
		    for (var i = 0; i < sortNums.length; i++){
		       for (var j = i + 1; j < sortNums.length; j++){  
		    	  if (sortNums[i] != ""){
		    		  if (sortNums[i] > sortNums[j]) {  
						 var temp = "";
						 temp = sortNums[i];  
						 sortNums[i] = sortNums[j];  
						 sortNums[j] =  temp;  
						 
						 var temp1 = "";
						 temp1 = ids[i];
						 ids[i] = ids[j];
						 ids[j] = temp1;
				     }  
		    	  } 
		       }  
		    }  
			
			for (var k = 0; k < ids.length; k++) {
				if (typeof(ids[k]) != "undefined"){
					var map = ids[k].split("&");
					properName += map[1]+"*";
				}
			}
			properName = properName.substring(0,properName.length-1);
			$("[name=prodProperty]").val(properName);
			//$("[name=productName]").val(prodName);
		}
		
        
        
        //初始化
		function initData() {
        	pageFlag = 1;			//分页数据全局变量重置成原来的值
        	searchFlag = "";		//搜索后的全局变量重置为原来的值
			getVentor(null);
            getCategory();
			getProductInfoByPage(null,null);
			getProdCateFenlei(null);
		}
        
        //比较函数对真正的页面数据根据不同的字段名进行排序
		function SortByProps(item1, item2) {
		    var props = [];
		    for (var _i = 2; _i < arguments.length; _i++) {
		        props[_i - 2] = arguments[_i];
		    }
		        
		    var cps = []; // 存储排序属性比较结果。
		    // 如果未指定排序属性，则按照全属性升序排序。    
		    var asc = true;
		    if (props.length < 1) {
		        for (var p in item1) {
		            if (item1[p] > item2[p]) {
		                cps.push(1);
		                break; // 大于时跳出循环。
		            } else if (item1[p] === item2[p]) {
		                cps.push(0);
		            } else {
		                cps.push(-1);
		                break; // 小于时跳出循环。
		            }
		        }
		    } else {
		        for (var i = 0; i < props.length; i++) {
		            var prop = props[i];
		            for (var o in prop) {
		                asc = prop[o] === "asc";
		                if (item1[o] > item2[o]) {
		                    cps.push(asc ? 1 : -1);
		                    break; // 大于时跳出循环。
		                } else if (item1[o] === item2[o]) {
		                    cps.push(0);
		                } else {
		                    cps.push(asc ? -1 : 1);
		                    break; // 小于时跳出循环。
		                }
		            }
		        }
		    }        
		         
		    for (var j = 0; j < cps.length; j++) {
		        if (cps[j] === 1 || cps[j] === -1) {
		            return cps[j];
		        }
		    }
		    return 0;          
		}
        
       
        	
         //真正的函数执行者调用比较函数进行真正的根据字段值进行比较
		  function test(propOrders,items) {
		        items.sort(function (a, b) {
		            return SortByProps(a, b, propOrders);
		        });
		        return items;
		    }
         
         //其实就是那么简单一个排序而已扩展性很强的一个排序哦
		  var propOrders = "0";
		  function sortTable(){
			 /*  if(flag == "0"){
				var propOrders = {"productCode":"asc"};
				flag = "1";
			  }else if(flag == "1"){
				var propOrders = {"productCode":"desc"};
				flag = "0";
			  } */
			  if(propOrders == "0"){
				  propOrders = "1"
			  }else{
				  propOrders = "0"
			  }
			  $("#sousuo").click();
			  
			  //根据当前某个字段
			 /*  var productList = test(propOrders,productVue.products);
			  productVue.products = productList; */
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
							property += " <input type='hidden' value = "+data[index].sortNo+" /><li class='property' onclick='propertyValue(this)'>" + data[index].details[i].propertyValue + "</li><input type='hidden' value='" + data[index].details[i].gid + "' /><input type='hidden' value='" + data[index].gid + "' />";
						});
						property += "</ul>";
					});
					$("#propertyList").html(property);
				},
				error : function() {}
			});
		}
	
		
		function getVentor(letter) {
			$.ajax({
				url : "${request.contextPath}/ventorController/findVentorInfo.do",
				type : "post",
				cache : false,
				data : {
					letter : letter
				},
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

        function getCategory(){
            $.ajax({
                url : "${request.contextPath}/categoryController/findCategoryInfo.do",
                type : "post",
                cache : false,
                data : {
                },
                dataType : "json",
                success : function(data) {
                    categoryVue.category = data.data;
                }
            });
        }

        function categoryChange(event){
            var categoryId = $(event).val();
            getProdCate(categoryId);
            $("[name=prodCateName]").val("");
            $("#prodCateId").val("");
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
				url : "${request.contextPath}/productController/findProductByPage.do",
				type : "post",
				cache : false,
				data : {
					page : nowPage,
					selValue : selValue,
                    findType : 1,
                    isCategory:isCategory,
                    propOrders:propOrders
				},
				dataType : "json",
				success : function(data) {
					productVue.products = data.products;
					pageVue.page = data.page;
					$("#sousuo").prev().val(selValue);
					
				},
				error : function() {}
			});
		}
		
		function clear(){
			$("[name=prodProperty]").val("");
			$("[name=ventorName]").val(""),
			$("[name=prodCateName]").val(""),
			$("[name=prodCode]").val(""),
			$("[name=keyWord]").val(""),
			$("[name=modelType]").val(""),
			$("[name=modelName]").val(""),
			$("[name=description]").val(""),
			$("[name=productName]").val(""),
			$("[name=easyCode]").val(""),
			$("#gid").val("");
			$("#basicUnit").val(""),
			$("#amount").val(""),
			$("[name=maxStock]").val(""),
			$("[name=minStock]").val(""),
			$("[name=safeStock]").val(""),
			$("#preview").html("");
			$("#isRecommend").val("-1");
			gid = "";
			$("#dialogventor li").removeClass("active");
			$("#prod-cate li").removeClass("active");
			$("#is-available").attr("checked", "false");
			$("#3D").removeClass("has-model");
            id = "";
            propertyId = "";
            sortNum = "";
            path = "";
		}

        function clearNotGid(){
            $("[name=prodProperty]").val("");
            $("[name=ventorName]").val(""),
            $("[name=prodCateName]").val(""),
            $("[name=prodCode]").val(""),
            $("[name=keyWord]").val(""),
            $("[name=modelType]").val(""),
            $("[name=modelName]").val(""),
            $("[name=description]").val(""),
            $("[name=productName]").val(""),
            $("[name=easyCode]").val(""),
            $("#gid").val("");
            $("#basicUnit").val(""),
            $("#amount").val(""),
            $("[name=maxStock]").val(""),
            $("[name=minStock]").val(""),
            $("[name=safeStock]").val(""),
            $("#preview").html("");
            $("#isRecommend").val("-1");
            $("#dialogventor li").removeClass("active");
            $("#prod-cate li").removeClass("active");
            $("#is-available").attr("checked", "false");
            $("#3D").removeClass("has-model");
            id= "";
            propertyId = "";
            sortNum = "";
            path = "";
        }
		
		var gid = "";
		function showQAQ(obj){
			$(".panel-material-list").hide();
			gid = $(obj).children("td").last().find("span").text();
			getProdById(gid);
			$(".panel-detail").show();
		} 
	
		function getEditInfo(){
			getProdInfoById(gid);
		}
		
		var i = 0;
		function clickType(obj){
            if($("#categorySel").val() == 0){
                toast("toast-warning", "请选择大类别");
                return;
            }

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
					toast('toast-warning', "清先选择类别！");
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
  		    	searchFlag = $("#sousuo").prev().val()
  				getProductInfoByPage(pageFlag,searchFlag);
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
		/*分类 */
		var fenlei = 0;
		function clickforfenlei(obj){
			$(".dialog").hide();
			var yuans = $(obj).next();
			if (fenlei == 0) {
				var typeTxt = $("#cateName").val();
                $(".childrenUl li").removeClass("active");
                $(".childrenUl li:contains('"+typeTxt+"')").addClass('active');
				yuans.css("display","block");
				fenlei = 1;
			} else {
				yuans.css("display","none");
				fenlei = 0;
			}
				
		}
		 
		
		  function getProdCateFenlei(categoryId){
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
	                     
	                         alldata +="<li ><h4>"+data[i].categoryName+"</h4><ul>";

	                         $.each(data[i].categorys,function(j,item){
	                         
	                             alldata +="<li ><h5>"+data[i].categorys[j].categoryName+"</h5><ul class='childrenUl'>" ;

	                              $.each(data[i].categorys[j].categorys,function(k,item){
	                                 alldata += "<li class='bottom_fenlei'  onclick='getProdCateInfoFenlei(this)'><a>"+data[i].categorys[j].categorys[k].categoryName+"</a></li><input type='hidden' value='"+data[i].categorys[j].categorys[k].gid+"'>";
	                              });
	                              alldata += "</ul></li>";
	                         });
	                         
	                         alldata += "</ul></li>";
	                     }); 
	                     $("#prod-cate-fenlei").html(alldata);
	                 },
	                 error : function() {}
	             }); 
         }  
		 
		  function getProdCateInfoFenlei(obj){
			  
              $("#prod-cate-fenlei li").attr("name","false");
              $("#prod-cate-fenlei li").removeClass("active");
              $(obj).addClass("active");
              $(obj).attr("name","checked");
             
          }
		 
		  //全局变量为判断是否是类别查询做标识
		  var isCategory = "0";
		  
		  $(function(){
			$("#saveCate-fenlei").click(function(){
	            $("#cateName").val("请选择");
	            var id = $("#prod-cate-fenlei li[name='checked']").next().val();
	            var cateName = $("#prod-cate-fenlei li[name='checked']").text();
	            $("#cateName").val(cateName);
	            $("#sousuoInput").val(cateName)
	            $("#fenlei").click();
	            isCategory = "1";
	            pageFlag = 1;
	            $("#sousuo").click();
	            //findPropertys(id);
	            //getProductInfoByCategoryName(null,cateName);
	        });
			
	        $("#exitCate-fenlei").click(function(){
	            $("#fenlei").click();
	        });
		  })
		  
		  
		  
		

		
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
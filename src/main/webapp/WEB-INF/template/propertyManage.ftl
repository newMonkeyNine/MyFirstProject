<!DOCTYPE html>
<html lang="zh-cn">
    <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="renderer" content="webkit"/>
    <title>规格管理</title>
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
        <article class="propertyManage">
            <header>
            <h1 class="brand"><span class="icon icon-logo"></span>物料系统</h1>
            <div class="tabs">
                <a href="${request.contextPath}/selectionProductController/toMaterial.do">料库</a>
                <a href="${request.contextPath}/selectionProductController/toProductListPage.do">产品结构清单</a>
                <a class="active" href="${request.contextPath}/selectionProductController/toPropertyManage.do">规格管理</a>
                <a href="${request.contextPath}/selectionProductController/toCategoryManage.do">分类管理</a>
            </div>
            <div class="user-info">
                <span class="name">${userInfo.userName}</span>
                <span class="position">${userInfo.roleName}</span>
                <a class="logout" href="javascript:outLogin();">退出</a>
            </div>
        </header>
            <section>
                <div class="panel">
                    <div class="panel-header">
                        <div class="current-type">
                            <span>当前物料类别：</span>
                            <input type="text" name="" id="cateName" value="铜材" readonly="readonly" />
                            <span class="icon icon-list" id="typeInfo" onclick="clickCategory(this)"></span>
                            <!--类别弹框-->
                            <aside class="dialog-pro-category" id="prodCate">
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
                        <div class="btn-group">
                            <button class="btn btn-add" type="button" id="addPropertyButton">添加规格</button>
                        </div>
                    </div>
                    <div class="panel-body" id="propertyTab">
                        <div class="table-header">
                            <span>规格参数</span>
                            <span>显示排序</span>
                            <span>规格项</span>
                        </div>
                        <ul class="table-body" :id="propertys.id">
                            <!--规格参数1-->
                            <li v-for="item in propertys.propertyList">
                                <div class="property-type" :id="item.id">
                                    <span class="icon icon-close"></span>
                                    <div class="item-name propertyNames">{{item.propertyName}}<span class="icon icon-edit"></span></div>
                                    <div class="edit"><input type="text" maxlength="15" name="propertyName" value=""/><button class="btn-save-name" type="button">保存</button></div>
                                </div>
                                <!-- 显示排序 -->
                                <div class="show-order" :id="item.id">
                                    <div class="item-name sortNos" >{{item.sortNo}}<span class="icon icon-edit"></span></div>
                                    <div class="edit"><input type="number" name="sortNo" value=""/><button class="btn-save-no" type="button">保存</button></div>
                                </div>
                                <ul class="property-item">
                                    <li v-for="item1 in item.valueList" class="item" :id="item1.id">{{item1.value}}<span class="icon icon-close-circle"></span></li>
                                    <!--添加规格项按钮-->
                                    <li class="btn-add-item addValues"><span class="icon icon-add"></span></li>
                                    <!--规格项编辑器-->
                                    <li class="item-editor">
                                        <input type="text" maxlength="15" name="propertyValue" value="" placeholder="请输入"/>
                                        <button class="btn-save" type="button">保存</button>
                                        <button class="btn-cancel" type="button">取消</button>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <!--分页-->
                    <!-- <div id="page" class="table-footer">
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
                    </div> -->
                </div>
            </section>
        </article>
        <!-- 遮罩层 -->
        <div class="mask"></div>
        <!-- 添加规格弹窗 -->
        <aside class="dialog-add-property" id="addpropertyDialog">
            <header>
                <h3>添加规格</h3>
            </header>
            <section>
                <div class="property-type">
                    <span class="label">规格参数</span>
                    <input type="text" name="propertyName1" maxlength="15" value="" placeholder="请输入"/>
                </div>
                <!-- 显示排序 -->
                <div class="show-order">
                    <span class="label">显示排序</span>
                    <input type="number" name="sortNo1" max="88888" value="" placeholder="请输入"/>
                </div>
                <div class="property-item">
                    <span class="label">规格项</span>
                    <div>
                        <input type="text" name="propertyValue1" maxlength="15" class="propertyValue1" value="" placeholder="请输入"/>
                        <button class="btn-add-item" type="button"><span class="icon icon-add"></span>添加规格项</button>
                    </div>
                </div>
            </section>
            <footer>
                <div class="btn-group">
                    <button class="btn btn-save" type="button" id="savePropertyDialog">保存</button>
                    <button class="btn btn-cancel" type="button" id="exitPropertyDialog">取消</button>
                </div>
            </footer>
            <span class="icon icon-close-circle"></span>
        </aside>
        <script type="text/javascript">
            var productCategoryId = '4f224d14b22311e7952b00163e0a3652';

            $(function(){
                $(document).click(function(){
                    $("[name=propertyName1]").val("");
                    $("[name=sortNo1]").val("");
                    $(".propertyValue1").each(function(index,item){
                        var $i = $(item);
                        $i.val("");
                        if (index > 0) {
                            $i.remove();
                        }
                    })
                    $("#addpropertyDialog").hide();
                    $("#addPropertyButton").show();
                });

                $("#addPropertyButton").click(function(event){
                    event.stopPropagation();
                });

                $("#addpropertyDialog").click(function(event){
                    event.stopPropagation();
                });

                initDate();
                $("#addPropertyButton").click(function(){
                    $(".propertyNames").each(function(i,item){
                         var $i = $(item);
                         if ($i.is(":hidden")) {
                            $i.next().hide();
                            $i.show();
                         }
                     });
                     
                     $(".sortNos").each(function(i,item){
                        var $i = $(item);
                        if ($i.is(":hidden")) {
                            $i.next().hide();
                            $i.show();
                         }
                     });
                     
                     $(".addValues").each(function(i,item){
                         var $i = $(item);
                         if ($i.is(":hidden")) {
                            $i.next().hide();
                            $i.show();
                         }
                     }); 
                    $("#addPropertyButton").hide();
                    $("#addpropertyDialog").show();
                });
                
                $("#exitPropertyDialog").click(function(){
                    $("[name=propertyName1]").val("");
                    $("[name=sortNo1]").val("");
                    $(".propertyValue1").each(function(index,item){
                        var $i = $(item);
                        $i.val("");
                        if (index > 0) {
                            $i.remove();
                        }
                    })
                    $("#addpropertyDialog").hide();
                    $("#addPropertyButton").show();
                });
                
                
                $("#savePropertyDialog").click(function(){
                    var values = "";
                    var name = $("[name=propertyName1]").val();
                    var sortNo = $("[name=sortNo1]").val();
                    if (name == "" || name == null) {
                    	toast('toast-warning', "请输入规格参数！");
                        return;
                    } else if (sortNo == "" || sortNo == null){
                    	toast('toast-warning', "请输入序号！");
                        return;
                    }
                    $(".propertyValue1").each(function(index,item){
                        var $i = $(item);
                        if ($i.val() != "" && $i.val() != null){
                            values += $i.val() + ",";
                        }
                    })
                    if (values == ""){
                    	toast('toast-warning', "请至少输入一项规格属性！");
                        return;
                    } 
                    addPropertyNameAndValue(name,sortNo,values);
                    $("[name=propertyName1]").val("");
                    $("[name=sortNo1]").val("");
                    $(".propertyValue1").each(function(index,item){
                        var $i = $(item);
                        $i.val("");
                        if (index > 0) {
                            $i.remove();
                        }
                    })
                    $("#addpropertyDialog").hide();
                    $("#addpropertyDialog").hide();
                    $("#addPropertyButton").show();
                });
                
                
                
                 var value = "";
                 var propertyNames = new Array();
                 var sortNos = new Array();
                 $(".table-body").click(function(e){
                     var target = e.srcElement || e.target;
                     if(target.className === "icon icon-edit"){
                         $(".propertyNames").each(function(i,item){
                             var $i = $(item);
                             if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         });
                         
                         $(".sortNos").each(function(i,item){
                             var $i = $(item);
                            if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         });
                         
                         $(".addValues").each(function(i,item){
                             var $i = $(item);
                             if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         }); 
                         
                         
                         var $v=$(target);
                         var propertyname = $v.parent().text();
                         value = propertyname;
                         $v.parent().next().show();
                         $v.parent().next().children("input").val(propertyname);
                         $v.parent().hide();
                     } else if (target.className === "icon icon-close") {
                         $(".propertyNames").each(function(i,item){
                             var $i = $(item);
                             if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         });
                         
                         $(".sortNos").each(function(i,item){
                            var $i = $(item);
                            if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         });
                         
                         $(".addValues").each(function(i,item){
                             var $i = $(item);
                             if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         }); 
                         
                         var $v=$(target);
                         var id = $v.parent().prop("id");
                         if (confirm("是否删除该规格？")==true){
                            deletePropertyInfoById(id,$v);
                         }
                     } else if (target.className === "btn-save-name") {
                         var $v=$(target);
                         var name = $v.prev().val();
                         var id = $v.parent().parent().attr("id");
                         updatePropertyNameById(name,id,$v);
                     } else if (target.className === "btn-save-no") {
                         var $v=$(target);
                         var no = $v.prev().val();
                         var id = $v.parent().parent().attr("id");
                         updateSortNoById(no,id,$v);
                     } else if (target.className === "icon icon-add") {
                        $(".propertyNames").each(function(i,item){
                             var $i = $(item);
                             if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         });
                         
                         $(".sortNos").each(function(i,item){
                            var $i = $(item);
                            if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         });
                         
                         $(".addValues").each(function(i,item){
                             var $i = $(item);
                             if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         }); 
                          
                          
                         $("[name=propertyValue]").val("");
                         var $v=$(target);
                         $v.parent().next().show();
                         $v.parent().hide();
                     } else if (target.className === "btn-cancel") {
                         var $v=$(target);
                         $v.parent().prev().show();
                         $v.parent().hide();
                     } else if (target.className === "btn-save") {
                         var $v=$(target);
                         var name = $v.prev().val();
                         if (name == "" || name == null) {
                             toast("toast-warning", "请输入规格属性名称！");
                             return;
                         }
                         var propertyId = $v.parent().parent().prev().prop("id");
                         var cateId = $(".table-body").prop("id");
                         addPropertyInfo(name,propertyId,cateId,$v);
                     } else if (target.className === "icon icon-close-circle") {
                         $(".propertyNames").each(function(i,item){
                             var $i = $(item);
                             if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         });
                         
                         $(".sortNos").each(function(i,item){
                            var $i = $(item);
                            if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         });
                         
                         $(".addValues").each(function(i,item){
                             var $i = $(item);
                             if ($i.is(":hidden")) {
                                $i.next().hide();
                                $i.show();
                             }
                         }); 
                         
                         var $v=$(target);
                         var id = $v.parent().prop("id");
                         if (confirm("是否删除该规格属性？")==true){
                             deletePropertyInfo(id,$v);
                         }
                         
                     }
                     value = "";
                 });
                
                 $(".dialog-add-property").click(function(e){
                    var target = e.srcElement || e.target;
                    if (target.className === "btn-add-item") {
                        var $v=$(target);
                        $v.prev().after("<input type='text' name='propertyValue1' class='propertyValue1' value='' placeholder='请输入'/>");
                    }
                 });
                
                $("#saveCate").click(function(){
                    $("#cateName").val("请选择");
                    var id = $("#prod-cate li[name='checked']").next().val();
                    var CateName = $("#prod-cate li[name='checked']").text();
                    productCategoryId = id;
                    $("#cateName").val(CateName);
                    //$("#prodCate").hide();
                    $("#typeInfo").click();
                    findPropertys(id);
                });
                
                $("#exitCate").click(function(){
                    //$("#prodCate").hide();
                    $("#typeInfo").click();
                });
                
                
                //分页
                $("#page").on("click", ".pager a", function() {
                    var nowPage = $(this).attr("data-index");
                    var totalPage = $(this).attr("totalPage");
                    var direction = $(this).attr("direction");
                    if (direction == undefined) {
                        if (nowPage != undefined) {
                            getProductList(nowPage,null, null);
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
                            getProductList(nowPage,null, null);
                        }
                    }
                });

                //页面跳转
                $("#page").on("click", ".jump", function() {
                    var nowPage = $(".jumpPage").val();
                    if(nowPage==""){
                    	toast('toast-warning', "请输入页码！");
                    	return;
                     }else{
                        maxPage = $(this).attr("data-index");
                        var maxPage = $(this).data("index");
                        if (nowPage > maxPage) {
                            nowPage = maxPage;
                        } else if (nowPage < 1) {
                            nowPage = 1;
                        }
                        getProductList(nowPage,null,null);
                    }
                });
                
            });
            
            
            function closeAll(){
                
            }

            var propertysVue = new Vue({
                el : "#propertyTab",
                data : {
                    propertys : new Object()
                }
            });
            
            function initDate(){
                getProdCate(null);
                findPropertys(productCategoryId);
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
                            
                                alldata +="<li><h5>"+data[i].categorys[j].categoryName+"</h5><ul class='childrenUl'>" ;

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
            
            function updatePropertyNameById(name,id,obj){
                $.ajax({
                    url : "${request.contextPath}/propertyController/updatePropertyNameById.do",
                    type : "post",
                    cache : false,
                    dataType : "json",
                    data : {
                        propertyName : name,
                        propertyId : id,
                        cateId : $(".table-body").prop("id")
                    },
                    success : function(data) {
                    	toast('toast-success', data.message);
                        if (data.status > 0) {
                            var name = obj.prev().val();
                            obj.parent().prev().show();
                            obj.parent().prev().html(name+"<span class='icon icon-edit'></span>");
                            obj.parent().hide();
                        }
                    },
                    error : function() {}
                });
            }
            
            function updateSortNoById(no,id,obj){
                $.ajax({
                    url : "${request.contextPath}/propertyController/updateSortNoById.do",
                    type : "post",
                    cache : false,
                    dataType : "json",
                    data : {
                        sortNo : no,
                        propertyId : id,
                        cateId : $(".table-body").prop("id")
                    },
                    success : function(data) {
                    	toast('toast-success', data.message);
                        if (data.status > 0) {
                            var name = obj.prev().val();
                            obj.parent().prev().show();
                            obj.parent().prev().html(name+"<span class='icon icon-edit'></span>");
                            obj.parent().hide();
                        }
                    },
                    error : function() {}
                });
            }
            
            function addPropertyInfo(name,propertyId,cateId,obj){
                $.ajax({
                    url : "${request.contextPath}/propertyController/addPropertyValueInfo.do",
                    type : "post",
                    cache : false,
                    dataType : "json",
                    data : {
                        name : name,
                        propertyId : propertyId,
                        cateId : cateId
                    },
                    success : function(data) {
                    	toast('toast-success', data.message);
                        if (data.status > 0) {
                            obj.parent().prev().show();
                            obj.parent().hide();
                            obj.parent().prev().prev().after("<li class='item' id='"+data.id+"'>"+data.name+"<span class='icon icon-close-circle'></span></li>");
                        }
                        
                    },
                    error : function() {}
                });
            }
            
            function addPropertyNameAndValue(name,sortNo,values){
                $.ajax({
                    url : "${request.contextPath}/propertyController/addPropertyNameAndValue.do",
                    type : "post",
                    cache : false,
                    dataType : "json",
                    data : {
                        id : $(".table-body").prop("id"),
                        propertyName : name,
                        sortNo : sortNo,
                        values : values
                    },
                    success : function(data) {
                    	toast('toast-success', data.message);
                        if (data.status > 0) {
                            findPropertys(productCategoryId);
                            // var htmls = "";
                            // htmls = "<li><div class='property-type' id='"+data.work.id+"' > <span class='icon icon-close'></span>"
                            //             +"<div class='item-name'>"+data.work.propertyName+"<span class='icon icon-edit'></span></div>"
                            //             +"<div class='edit'><input type='text' name='propertyName' value=''/><button class='btn-save-name' type='button'>保存</button></div></div>"
                            //             +"<div class='show-order' id='"+data.work.id+"'> "
                            //             +"<div class='item-name'>"+data.work.sortNo+"<span class='icon icon-edit'></span></div>"
                            //             +"<div class='edit'><input type='number' name='sortNo' value=''/><button class='btn-save-no' type='button'>保存</button></div></div>"
                            //             +"<ul class='property-item'>";
                                        
                            // $.each(data.work.valueList,function(index,item){
                            //     htmls += "<li class='item' id='"+item.id+"'>"+item.value+"<span class='icon icon-close-circle'></span></li>"
                            // });
                            // htmls += "<li class='btn-add-item'><span class='icon icon-add'></span>添加规格项</li>"
                            //             +"<li class='item-editor'>"
                            //             +"<input type='text' name='propertyValue' value='' placeholder='请输入'/>"
                            //             +"<button class='btn-save' type='button'>保存</button> <button class='btn-cancel' type='button'>取消</button></li></ul></li>";
                            // $(".table-body").append(htmls);
                        }
                    },
                    error : function() {}
                });
            }
            
            function deletePropertyInfo(id,obj){
                $.ajax({
                    url : "${request.contextPath}/propertyController/deletePropertyInfo.do",
                    type : "post",
                    cache : false,
                    dataType : "json",
                    data : {
                        id : id
                    },
                    success : function(data) {
                    	toast('toast-success', data.message);
                        if (data.status > 0) {
                            obj.parent().remove();
                        }
                    },
                    error : function() {}
                });
            }
            
            function deletePropertyInfoById(id,obj){
                $.ajax({
                    url : "${request.contextPath}/propertyController/deletePropertyInfoById.do",
                    type : "post",
                    cache : false,
                    dataType : "json",
                    data : {
                        id : id
                    },
                    success : function(data) {
                    	toast('toast-success', data.message);
                        if (data.status > 0) {
                            obj.parent().parent().remove();
                        }
                    },
                    error : function() {}
                });
            }
            
            function findPropertys(id){
                $.ajax({
                    url : "${request.contextPath}/propertyController/findpropertyByCateId.do",
                    type : "post",
                    cache : false,
                    dataType : "json",
                    data : {
                        id : id
                    },
                    success : function(data) {
                        if (data.status <= 0) {
                        	toast('toast-success', data.message);
                        } else {
                            if (data.work != null)
                            {
                                propertysVue.propertys = data.work;
                            }
                        }
                        
                    },
                    error : function() {}
                });
            }
            
            
            
            function getProdCateInfo(obj){
                $("#prod-cate li").attr("name","false");
                $("#prod-cate li").removeClass("active");
                $(obj).addClass("active");
                $(obj).attr("name","checked");
            }
            
            
            var k = 0;
            function clickCategory(obj){
                var cataTab = $(obj).next();
                $(".dialog").hide();
                if (k == 0) {
                    var typeTxt = $("#cateName").val();
                    $(".childrenUl li").removeClass("active");
                    $(".childrenUl li:contains('"+typeTxt+"')").addClass('active');
                    cataTab.css("display","block");                 
                    k = 1;
                } else {
                    cataTab.css("display","none");
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
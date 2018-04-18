<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="renderer" content="webkit"/>
    <title>产品结构清单</title>
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
    <script type="text/javascript">
        var productVue;
        var pageVue;
        var subProductVue;
        var childrenBomVue;
        var categoryVue;
        var productLineVue;
        var bomPageVue;
        var pageFlag = 1;

        $(function(){
            productVue = new Vue({
                el : "#main",
                data : {
                    products : [],
                    itemStr : 'item'
                },
                updated : function(){
                    $("#main input:checkbox").prop("checked", false);
                    $("#result-ul li:visible").each(function(index, item){
                        $("#item"+$(item).data('id')).prop("checked", true);
                    });
                }
            });

            pageVue = new Vue({
                el : "#page",
                data : {
                    page : new Object()
                }
            });

            bomPageVue = new Vue({
                el : "#bom_page",
                data : {
                    page : new Object()
                }
            });

            subProductVue = new Vue({
                el : "#sub_product",
                data : {
                    subProduct : new Object()
                },
                updated : function () {
                    showEditPanl();
                    if (subProductVue.subProduct.bomTechnicss != null && subProductVue.subProduct.bomTechnicss.length > 0) {
                        $("#lineSelect").val(subProductVue.subProduct.bomTechnicss[0].technics.lineId);
                        $("#li"+subProductVue.subProduct.bomTechnicss[0].technics.lineId).show();

                        $.each(subProductVue.subProduct.bomTechnicss, function(index, item){
                            $("#"+item.technics.gid).addClass('active');
                        });
                    }
                    
                }
            });

            childrenBomVue = new Vue({
                el : "#children_bom",
                data : {
                    products : []
                },
                methods : {
                    deleteChildrenBom : function(event){
                        $(event.target).parents('li').remove();
                    }
                },
                updated : function () {
                    showEditPanl();
                }
            });

            categoryVue = new Vue({
                el : "#categoryNav",
                data : {
                    categorys : []
                },
                updated : function(){
                    $("#categoryNav li").click(function(){
                        $(this).addClass("active").siblings().removeClass("active");
                        getProductList(1, null, $(this).attr("id"));
                    });

                    $("#categoryNav li").eq(0).click();
                }
            });

            productLineVue= new Vue({
                el : "#productLineSel",
                data : {
                    productLine : [],
                    str : 'li'
                },
                updated : function(){
                    $("#productLineSel li").unbind('click');
                    $("#productLineSel li").click(function(){
                        if ($(this).hasClass('active')) {
                            $(this).removeClass("active");
                        } else {
                            $(this).addClass("active");
                        }
                    });
                }
            });

            findProductBomChildren(1);

            $(document).click(function(){
                $(".flows.on").each(function(){
                    $(this).removeClass("on");
                    clearTechnicsLossEdit();
                });
                $("button[class='edit']").show();
            });

            $(".flows > span").click(function(event){
                event.stopPropagation();
            });

            $(".dialog-pro-select").click(function(event){
                event.stopPropagation();
            });
        });

        function childrenBomNumBlur(event){
            var productId = $(event).parents('li').find("input[class='productId']").val();
            if ($(event).val() != null && $(event).val() != '') {
                $.each(childrenBomVue.products, function(index, item){
                    if (item.product.gid == productId) {
                        item.bomNum = $(event).val();
                    }
                });
            }
        }

        function childrenLossNumBlue(event){
            var productId = $(event).parents('li').find("input[class='productId']").val();
            if ($(event).val() != null && $(event).val() != '') {
                $.each(childrenBomVue.products, function(index, item){
                    if (item.product.gid == productId) {
                        item.lossNum = $(event).val();
                    }
                });
            }
        }

        function childrenWorkTypeChange(event){
            var productId = $(event).parents('li').find("input[class='productId']").val();
            if ($(event).val() != null && $(event).val() != '') {
                $.each(childrenBomVue.products, function(index, item){
                    if (item.product.gid == productId) {
                        item.bomType = $(event).val();
                    }
                });
            } 
        }


        //打开新增产品面板
        function toAddProductBom(){
            $("#searchInput").val('');
            subProductVue.subProduct = null;
            subProductVue.subProduct = new Object();
            childrenBomVue.products = [];
            var collapse = $("#subBomBtn").parent().parent().parent();
            if(!collapse.hasClass("open")){
                $("#subBomBtn").click();
            }
            isProducts = 'product';
            getCategoryInfo();
        }

        function updateProductBom(){
            $("#searchInput").val('');
            $(".mask").show();
            $("#dialog-pro-select").show();
            isProducts = 'updateProduct';
            getCategoryInfo();
        }

        function getCategoryInfo(){
            $.post("${request.contextPath}/categoryController/findCategoryInfo.do",
                {
                },
                function(data) {
                    if (data.code == 200) {
                        categoryVue.categorys = data.data;
                    }
            },"json");
        }

        //加载产品列表
        function getProductList(page, searchTxt, categoryId){
            $.post("${request.contextPath}/productController/findProductByPage.do",
                {
                    page : page,
                    searchTxt : searchTxt,
                    categoryId : categoryId

                },
                function(data) {
                    productVue.products = data.products;
                    pageVue.page = data.page
            },"json");
        }

        var isProducts = 'product';

        //选中产品
        function addChecked(event){
            if (isProducts == 'product' || isProducts == 'updateProduct') {
                checkedProduct(event);
            } else {
                checkedProducts(event);
            }
        }

        //添加单个产品时
        function checkedProduct(event){

            $(event).parent().siblings().each(function(index, item){
                if ($(item).children('input').is(':checked')) {
                    $(item).children('input').attr('checked', false);
                }
            });
            var productCode = $(event).children().eq(2).text();
            
            if (!$(event).prev('input').is(':checked')) {
                $(".no-result").hide();
                //当前为选中状态
                $("#result-ul li:visible").remove();
                /*var $li = $('<li class="result">'+productName+' '+propertys+'（'+productCode+'）<span class="icon icon-close-circle"></span></li>');*/
                var $li = $('<li class="result">'+productCode+'<span class="icon icon-close-circle"></span></li>');
                $("#result-ul").append($li);
                $li.data('id', $(event).parent().attr('id'));
                $li.click(function(){
                    removeSelectLi(this);
                });
            }else{
                $("#result-ul li:visible").remove();
            }
        }

        //添加多个产品时
        function checkedProducts(event){
            var productCode = $(event).children().eq(2).text();
            
            if (!$(event).prev('input').is(':checked')) {
                $(".no-result").hide();
                /*var $li = $('<li class="result">'+productName+' '+propertys+'（'+productCode+'）<span class="icon icon-close-circle></span></li>');*/
                var $li = $('<li class="result">'+productCode+'<span class="icon icon-close-circle"></span></li>');
                $("#result-ul").append($li);
                $li.data('id', $(event).parent().attr('id'));
                $li.click(function(){
                    removeSelectLi(this);
                });
            }else{
                $("#result-ul li:visible").each(function(index, item){
                    if ($(item).data('id') == $(event).parent().attr('id')) {
                        $(item).remove();
                    }
                });
            }
        }

        function removeSelectLi(event){
            var gid = $(event).data('id');
            $("#"+gid).children('input').attr("checked", false);
            $(event).remove();
        }

        //判断提示消息是否显示
        function checkResultLi(){

        }

        function getProductByIds(ids){
            $.post("${request.contextPath}/productController/findProductByIds.do",
                {
                    jsonStr : JSON.stringify(ids)
                },
                function(data) {
                    if (isProducts == 'product') {
                        subProductVue.subProduct = data.boms[0];
                        getProductLineInfo();
                    } else if (isProducts == 'products') {
                        $.each(data.boms, function(index, item){
                            childrenBomVue.products.push(item);
                        });
                    } else if (isProducts == 'updateProduct'){
                        subProductVue.subProduct.product = data.boms[0].product;

                    } else {
                        addTechnicsLossLi(data.boms);
                    }
            },"json");
        }

        function getProductLineInfo(){
            productLineVue.productLine= [];
            $.post("${request.contextPath}/productLineController/findProductLineInfo.do",
                {
                },
                function(data) {
                	
                    if (data.code == 200) {
                        productLineVue.productLine = data.data;
                    }
                    
            },"json");
        }

        function toProductInfo(){
            var ids = new Array();
            $("#result-ul li:visible").each(function(index, item){
                ids.push($(item).data("id"));
            });

            if (ids == null ||ids.length <= 0) {
                toast("toast-warning", "请选择物料");
                return;
            }
            clearProductPanl();
            getProductByIds(ids);
            //getProductLineInfo();
            if (isProducts != 'lossMrl') {
            //显示新增产品面板
            $(".panel-product-list").hide();
            $(".panel-append").show();
            $("#bom_page").hide();
            }
            
        }

        //
        function addChildrenBom(){
            $("#searchInput").val('');
            isProducts = 'products';
            $(".mask").show();
            $("#dialog-pro-select").show();
           // $('.operate  .edit').css('display','inline-block');
            /*$("#children_bom li").each(function(index, item){
                var $li = $('<li class="result">'+$(item).find('.productCode').text().substr(5)+'<span class="icon icon-close-circle"></span></li>');
                $("#result-ul").append($li);
                $li.data('id', $(item).find("input[class='productId']").val());
                $li.click(function(){
                    removeSelectLi(this);
                });
            });*/
            getCategoryInfo();
        }

        function checkProductTxtNull(subBom){
            var bool = false;
            
            if (subBom.bomNum == null || subBom.bomNum == '') {
                toast("toast-warning", "请填写产品的需求数量");
                bool = true;
                return bool;
            }
            if (subBom.bomType == null || subBom.bomType == '') {
                toast("toast-warning", "请填写产品的来源");
                bool = true;
                return bool;
            }
            if (subBom.lossNum == null || subBom.lossNum == '') {
                toast("toast-warning", "请填写产品的损耗");
                bool = true;
                return bool;
            }

            $.each(subBom.childrenBom, function(index, item){
                if (item.bomNum == null || item.bomNum == '') {
                toast("toast-warning", "请填写"+item.productName+"的需求数量");
                bool =  true;
                return;
            }
            if (item.bomType == null || item.bomType == '') {
                toast("toast-warning", "请填写"+item.productName+"的来源");
                bool = true;
                return;
            }
            if (item.lossNum == null || item.lossNum == '') {
                toast("toast-warning", "请填写"+item.productName+"的损耗");
                bool =  true;
                return;
            }
            });

            return bool;
        }

        function saveProductBom(){
        	
            var subBom = new Object();
            subBom.productId = $("#productId").val();
            subBom.gid = $("#bomId").val();
            subBom.bomNum = $("#bomNum").val();
            subBom.bomType = $("#workType").val();
            subBom.lossNum = $("#lossNum").val();

            var boms = new Array();
            $("#children_bom li").each(function(index, item){
                var gid = $(item).attr('id');
                var bom = new Object();
                bom.productId =$(item).find("input[class='productId']").val();
                bom.gid = $(item).find("input[class='bomId']").val();
                bom.bomNum = $(item).find("input[class='bomNum']").val();;
                bom.bomType = $(item).find("select[class='workType']").val();
                bom.lossNum = $(item).find("input[class='lossNum']").val();
                bom.productName = $(item).find("span[class='name'] span").text();
                boms.push(bom);

            });

            subBom.childrenBom = boms;

            if(checkProductTxtNull(subBom)){
                return;
            }

            var technicsAry = new Array();
            $("#productLineSel li").each(function(index, item){
                if ($(item).hasClass('active')) {
                    technicsAry.push($(item).attr('id'));
                }
            });

            $.post("${request.contextPath}/productBomController/addProductBom.do",
                {
                    jsonStr : JSON.stringify(subBom),
                    technicss : JSON.stringify(technicsAry)
                },
                function(data) {
                    if (data.code == 200) {
                        toast("toast-success", data.msg);
                        $(".panel-product-list").show();
                        $(".panel-append").hide();
                        $("#bom_page").show();
                        
                        findProductBomChildren(pageFlag);
                        $("#deleteBtn").hide();
                    }else if (data.canNotAdd != null){
                    	 toast("toast-warning", data.canNotAdd);
                    }else {
                         toast("toast-warning", data.msg);
                    }
            },"json");

        }

        //还原选择产品面板内容
        function clearProductPanl(){
            $("#result-ul li").each(function(index, item){
                $(item).remove();
            })
            //隐藏选择产品面板
            $(".mask").hide();
            $("#dialog-pro-select").hide();
            $("#searchInput").val();
        }

        function showEditPanl(){
            $(".collapse-title .edit").unbind('click');
            $(".collapse-title .edit").click(function(){
                var collapse = $(this).parent().parent().parent();
                if(collapse.hasClass("open")){
                    collapse.removeClass("open");
                    $(this).text("编辑");
                }else{
                    $(".collapse.open").each(function(){
                        if ($(this).children('div[class=collapse-content]').children('div[class=info]').attr('id') != 'sub_product') {
                            $(this).removeClass("open");
                            $(this).find(".collapse-title .edit").text("编辑");
                        }
                    });
                    collapse.addClass("open");
                    $(this).text("收起");
                }
            });
        }

        function toast(className,text){
            var html = '<div class="toast ' + className + '">' + '<p>' + text + '</p>' + '</div>';
            var $toast = $(html).appendTo($("body")).show();
            window.setTimeout(function(){
                $toast.fadeOut(2000);
            },2000);
        }

        function toEditPage(parent){
            $("#bom_page").hide();
            $("#deleteBtn").show();
            subProductVue.subProduct = null;
            subProductVue.subProduct = new Object();
            childrenBomVue.products = [];
            getProductLineInfo();
            var collapse = $("#subBomBtn").parent().parent().parent();
            if(!collapse.hasClass("open")){
                $("#subBomBtn").click();
            }


            $.post("${request.contextPath}/productBomController/findProductBomByParentId.do",
                {
                    parentId : parent
                },
                function(data) {
                    if (data.code == 200) {
                        subProductVue.subProduct = data.data;
                        if (data.data.boms.length != 0) {
                            childrenBomVue.products = data.data.boms;
                        } else {
                            childrenBomVue.products = [];
                        }
                        $(".panel-product-list").hide();
                        $(".panel-append").show();
                    }
                    else {
                        toast("toast-warning", data.msg);
                    }
            },"json");
        }
        
        function findProductBomChildren(pageNum){
            $.ajax({
  			   	url : "${request.contextPath}/productBomController/findProductBomParent.do",
  			   	type : "post",
  			  	data:{"page":pageNum},
  			    beforeSend: function(){
  		    	} ,
 			   	success : function(data) {
	 			   	if (data.code == 200) {
	                    $("#productBomTab").empty();
	                    $.each(data.data,function(index, item){
	                        addProductBomChildrenBom(item, null, '');
	                    });
	                    //产品列表：层级展开、收起
	                    $("li.outer .name .icon").click(function(){
	                        var outer = $(this).parent().parent().parent();
	                        if(outer.hasClass("open")){
	                            outer.removeClass("open");
	                        }else{
	                            outer.addClass("open");
	                        }
	                    });
						
	                    bomPageVue.page = data.page;
	
	                    //单击事件==》展开工序窗口
	                    addClickByTechnics();
	                    addCloseLossClick();
	                    $(".dialog").click(function(event){
	                        event.stopPropagation();
	                    });
	                }
	                else {
	                    toast("toast-warning", data.msg);
	                }
	  		 	}
  	  		}); 
     }
     
        //产线下拉列表更改事件
        function productTechnicsChange(event){
            var gid = $(event).val();
            $("[class='technicsDiv']").hide();
            $("#li"+gid).show();
            $("#productLineSel li").removeClass('active');
        }

        //递归添加BOM元素
        function addProductBomChildrenBom(productBom, parentInnerDom, text_indent){
            var technicsHtml = checkTechnicsCount(productBom);
            var workType;
            if (productBom.bomType == 1) {
                workType = '自产';
            } else if (productBom.bomType == 2){
                workType = '外购';
            } else {
                workType = '外协加工';
            }
            if (productBom.boms != null && productBom.boms.length > 0) {
                var rootDom = $('<li class="outer"><div>'+text_indent+'<span class="name"><span class="icon icon-drop-down"></span>'+productBom.product.productName+' '+productBom.product.propertys+'</span></div><span>'+productBom.product.productCode+'</span><span>'+productBom.bomNum+' '+productBom.product.basicUnit+'</span><span>'+workType+'</span><span>'+productBom.product.unitPrice+'</span><span onclick="toEditPage(\''+productBom.gid+'\');" class="detail"></span>'+technicsHtml+'</li>');

                var innerDom;
                innerDom = '<li class="inner"><ul class="table-body"></ul></li>';
                innerDom = $(innerDom);
                if (parentInnerDom == null) {
                    $("#productBomTab").append(rootDom);
                    $("#productBomTab").append(innerDom);
                } else {
                    parentInnerDom.children('ul').append(rootDom);
                    parentInnerDom.children('ul').append(innerDom);
                }
                
                text_indent = text_indent + '<span class="text-indent"></span>';
                var text_indent_c = text_indent + '<span class="text-indent"></span>';
                $.each(productBom.boms, function(index, item){
                    var childrenTechnics = checkTechnicsCount(item);
                    var c_workType;
                    if (item.bomType == 1) {
                        c_workType = '自产';
                    } else if (item.bomType == 2){
                        c_workType = '外购';
                    } else {
                        c_workType = '外协加工';
                    }
                    if (item.boms != null && item.boms.length > 0) {
                        var parentBom = $('<li class="outer"><div>'+text_indent+'<span class="name"><span class="icon icon-drop-down"></span>'+item.product.productName+' '+item.product.propertys+'</span></div><span>'+item.product.productCode+'</span><span>'+item.bomNum+' '+item.product.basicUnit+'</span><span>'+c_workType+'</span><span>'+item.product.unitPrice+'</span><span onclick="toEditPage(\''+item.gid+'\');" class="detail"></span>'+childrenTechnics+'</li>');
                        innerDom.children('ul').append(parentBom); 
                        var innerDom_children = '<li class="inner"><ul class="table-body"></ul></li>';
                        innerDom_children = $(innerDom_children);
                        innerDom.children('ul').append(innerDom_children);
                        $.each(item.boms, function(index1, item1){
                            addProductBomChildrenBom(item1, innerDom_children, text_indent_c);
                        });
                    } else {//<a href="javascript:toEditPage(\''+item.gid+'\');">查看</a>
                        var childrenDom = '<li class="leaf"><div>'+text_indent+'<span class="name">'+item.product.productName+' '+item.product.propertys+'</span></div><span>'+item.product.productCode+'</span><span>'+item.bomNum+' '+item.product.basicUnit+'</span><span>'+c_workType+'</span><span>'+item.product.unitPrice+'</span><span onclick="toEditPage(\''+item.gid+'\');" class="detail"></span>'+childrenTechnics+'</li>';
                        innerDom.children('ul').append(childrenDom);
                    }
                });
            } else {
                var childrenDom = $('<li class="leaf"><div>'+text_indent+'<span class="name">'+productBom.product.productName+' '+productBom.product.propertys+'</span></div><span>'+productBom.product.productCode+'</span><span>'+productBom.bomNum+' '+productBom.product.basicUnit+'</span><span>'+workType+'</span><span>'+productBom.product.unitPrice+'</span><span onclick="toEditPage(\''+productBom.gid+'\');" class="detail"></span>'+technicsHtml+'</li>');
                if (parentInnerDom == null) {
                    $("#productBomTab").append(childrenDom);
                } else {
                    parentInnerDom.children('ul').append(childrenDom);
                }
            }
        }

        //判断BOM下是否有工序，有工序时，才拼接工序HTML
        function checkTechnicsCount(productBom){
        	
            if (productBom.opCount != null) {
                var technics = getBomTechnicsHtml(productBom);
                var technicsDiv = '<div class="flows"><span>'+productBom.opCount+'</span>'+technics+'</div>';
                return technicsDiv;
            } else {
                var technicsDiv = '<div class="flows no-flows"><span></span></div>';
                return technicsDiv;
            }
        }


        var productBomTechnicsId;
        //显示产品物料弹窗-耗材
        function showLossDialog(event){
        	
            clearTechnicsLossEdit();
            $(".lossEdit").removeClass('lossEdit');
            productBomTechnicsId = $(event).parent().parent().parent().attr("id");
            isProducts = 'lossMrl';
            $(".mask").show();
            $("#dialog-pro-select").show();
            /*$("#children_bom li").each(function(index, item){
                var $li = $('<li class="result">'+$(item).find('.productCode').text().substr(5)+'<span class="icon icon-close"></span></li>');
                $("#result-ul").append($li);
                $li.data('id', $(item).find("input[class='productId']").val());
                $li.click(function(){
                    removeSelectLi(this);
                });
            });*/
            getCategoryInfo();
        }

        //产品BOM下的工序编辑按钮
        function editBomTechnics(event){
        	
            $("button[class='edit']").show();

            $(event).hide();
            clearTechnicsLossEdit();
            $(event).parent().parent().parent().find('tbody').addClass('lossEdit');

            //单价替换为文本框
            var opPrice_ = $(event).parent().parent().next().children('span').text();
            $(event).parent().parent().next().children('span').empty();
            var $op_price = $('<input type="number" name="opPrice" />');
            $(event).parent().parent().next().children('span').append($op_price);
            $op_price.val(opPrice_);

            $(event).next().show();

            $(event).parent().parent().parent().find('tbody tr').each(function(index, item){
                var mrlNumber = $(item).children().eq(3).children().eq(0).text();
                var $mrlInput = $('<input type="number" name="mrlNumber" />');
                $(item).children().eq(3).empty();
                $(item).children().eq(3).append($mrlInput);
                $mrlInput.val(mrlNumber);

                var lossNumber = $(item).children().eq(4).children().eq(0).text();
                var $lossInput = $('<input type="number" name="lossNumber" />');
                $(item).children().eq(4).empty();
                $(item).children().eq(4).append($lossInput);
                $lossInput.val(lossNumber);

                $(item).children().eq(0).children().show();
            });
        }

        //检查添加耗材完整性
        function validationTechnicsLoss(lossAry){
            var isValidation = false;
            $.each(lossAry, function(index, item){
                if(item.lossNumber == null || item.lossNumber == '')
                {
                    toast('toast-warning', '请填写损耗');
                    isValidation = true;
                    return;
                }
                if (item.mrlNumber == null || item.mrlNumber == '') {
                    toast('toast-warning', '请填写耗材数量');
                    isValidation = true;
                    return;
                }
                
            });
            return isValidation;
        }

        //保存工序下的物料信息
        function saveTechnicsLoss(event){
            
            var type = 'edit';
            var gid = $(event).parents('li').prop('id');
            var opPrice = $(event).parents('li').find('input[name=opPrice]').val();
            var lossAry = new Array();
            $(event).parents('li').children('table').children('tbody').find('tr').each(function(index, item){
                var lossObj = new Object();
                lossObj.gid = $(item).attr('id');
                if (lossObj.gid != null) {
                    type = 'edit';
                }
                lossObj.productId = $(item).attr('productId');
                lossObj.lossNumber = $(item).find('[name=lossNumber]').val();
                lossObj.mrlNumber = $(item).find('[name=mrlNumber]').val();
                lossAry.push(lossObj);
            });

            if(validationTechnicsLoss(lossAry)){
                return;
            }

            $.post("${request.contextPath}/productBomTechnicsLossController/addTechnicsLoss.do",
                {
                    opId : gid,
                    lossStr : JSON.stringify(lossAry),
                    opPrice : opPrice,
                    type : type
                },
                function(data) {
                    if (data.code == 200) {
                        toast('toast-success', data.msg);
                        refreshTechnicsInfo(gid);
                        $("#"+gid+" button[class='save']").hide();
                        $(".lossEdit").removeClass("lossEdit");
                        $(event).prev().show();
                    } else {
                        toast('toast-warning', data.msg);
                    }
            },"json"); 
        }

        //重新加载工序下的耗材信息
        function refreshTechnicsInfo(technicsId){
            $.post("${request.contextPath}/productBomTechnicsController/findBomTechnicsInfo.do",
                {
                    technicsId : technicsId
                },
                function(data) {
                    $technicsTab = $("#"+technicsId+" tbody");
                    $span = $("#"+technicsId + " span[class='price']");
                    $span.empty();
                    $span.text(data.data[0].opPrice);
                    $technicsTab.empty();
                    $.each(data.data[0].technicsLoss, function(index, item){
                        var $technicsTd = $('<tr id="'+item.gid+'"><td><span class="icon icon-close closeLoss"></span>'+item.product.productName+'</td><td>'+item.product.propertys+'</td><td>'+item.product.productCode+'</td><td><span>'+item.mrlNumber+'</span><span>'+item.product.basicUnit+'</span></td><td><span>'+item.lossNumber+'</span><span>%</span></td></tr>');
                        $technicsTd.attr('productId', item.product.gid);
                        
                        $technicsTab.append($technicsTd);
                    });
                    addCloseLossClick();
            },"json");
        }


        //传入BOM信息，拼接BOM下的工序信息HTML代码
        function getBomTechnicsHtml(productBom){
            var $technicsDiv = $('<div><div class="dialog"><h3>工序</h3><ol class="steps"></ol></div></div>');
            $.each(productBom.bomTechnicss, function(index, item){
                index = index + 1;
                var $technicsLi = $('<li id="'+item.gid+'">'+
                                        '<span class="number">'+index+'</span>'+
                                        '<div>'+
                                            '<span>'+item.technics.technicsName+'</span>'+
                                            '<div class="operate">'+
                                                '<button class="edit" onclick="editBomTechnics(this);" type="button">编辑</button>'+
                                                '<button class="save" onclick="saveTechnicsLoss(this);" type="button">保存</button>'+
                                                '<button class="add" onclick="showLossDialog(this);" type="button">添加耗材</button>'+
                                            '</div>'+
                                        '</div>'+
                                        '<p>单价(元)：<span class="price">'+item.opPrice+'</span></p>'+
                                        '<table>'+
                                            '<thead>'+
                                                '<tr>'+
                                                    '<th>耗材</th>'+
                                                    '<th>规格</th>'+
                                                    '<th>料号</th>'+
                                                    '<th>数量</th>'+
                                                    '<th>损耗(%)</th>'+
                                                '</tr>'+
                                            '</thead>'+
                                            '<tbody>'+
                                            '</tbody>'+
                                        '</table>'+
                                    '</li>');
                $.each(item.technicsLoss, function(index, item){
                    var $technicsTd = $('<tr id="'+item.gid+'"><td><span class="icon icon-close closeLoss"></span>'+item.product.productName+'</td><td>'+item.product.propertys+'</td><td>'+item.product.productCode+'</td><td><span>'+item.mrlNumber+'</span><span>'+item.product.basicUnit+'</span></td><td><span>'+item.lossNumber+'</span><span>%</span></td></tr>');
                    $technicsTd.attr('productId', item.product.gid);
                    $technicsLi.find('tbody').append($technicsTd);
                });
                $technicsDiv.find('ol').append($technicsLi);
            });
            return $technicsDiv.html();
        }

        function addCloseLossClick(){
            $(".closeLoss").unbind('click');
            $(".closeLoss").click(function(){
                $(this).parents('tr').remove();
            });
        }

        function addTechnicsLossLi(boms){
            $("#"+productBomTechnicsId+" button[class='edit']").click();
            productBomTechnicsId=null;
            $.each(boms, function(index, item){
                var $technicsTd = $('<tr><td><span class="icon icon-close closeLoss"></span>'+item.product.productName+'</td><td>'+item.product.propertys+'</td><td>'+item.product.productCode+'</td><td><input type="number" name="mrlNumber" /></td><td><input type="number" value="0" name="lossNumber" /></td></tr>');
                $technicsTd.attr('productId', item.product.gid);
                $(".lossEdit").append($technicsTd);
                $technicsTd.find('span').show();
            });

            addCloseLossClick();
        }

        function addClickByTechnics(){
            //产品列表：工序展开收起，一次只能展开一个工序
            $(".flows > span").click(function(){
                var flows = $(this).parent();
                if(flows.hasClass("on")){
                    flows.removeClass("on");
                    clearTechnicsLossEdit();
                }else{
                    $(".flows.on").each(function(){
                        clearTechnicsLossEdit();
                       $(this).removeClass("on");
                    });
                    flows.addClass("on");
                }
                event.stopPropagation();
            });
        }

        function cancelDeleteDiv(){
            $("#bomIfDialog").hide();
            $(".mask").hide();
        }

        function showDeleteDiv(){
            $("#bomIfDialog").show();
            $(".mask").show();
        }

        function deleteProductBom(){
            var productBomId = $("#bomId").val();

            $.post("${request.contextPath}/productBomController/deleteProductBom.do",
                {
                    productBomId : productBomId
                },
                function(data) {
                    if (data.code == 200) {
                        toast("toast-success", data.msg);
                        $(".panel-product-list").show();
                        $(".panel-append").hide();
                        findProductBomChildren(1);
                        $("#bomIfDialog").hide();
                        $(".mask").hide();
                    } else {
                        toast("toast-warning", data.msg);
                    }
            },"json");
        }

        //退出物料耗材的编辑状态
        function clearTechnicsLossEdit(){

            $(".lossEdit").parents('li').find("button[class='save']").hide();
            var technicsId = $(".lossEdit").parents('li').attr("id");
            refreshTechnicsInfo(technicsId);
            $(".lossEdit").removeClass('lossEdit');
        }


        function searchProduct(){
            var searchTxt = $("#searchInput").val();
            var categoryId = $("#categoryNav li[class='active']").attr('id');
            getProductList(1, searchTxt, categoryId);
        }

    </script>
</head>
<body>
    <article class="productList">
        <header>
            <h1 class="brand"><span class="icon icon-logo"></span>物料系统</h1>
            <div class="tabs">
                <a href="${request.contextPath}/selectionProductController/toMaterial.do">料库</a>
                <a class="active" href="${request.contextPath}/selectionProductController/toProductListPage.do">产品结构清单</a>
                <a href="${request.contextPath}/selectionProductController/toPropertyManage.do">规格管理</a>
                <a href="${request.contextPath}/selectionProductController/toCategoryManage.do">分类管理</a>
            </div>
            <div class="user-info">
                <span class="name">${userInfo.userName}</span>
                <span class="position">${userInfo.roleName}</span>
                <a class="logout" href="javascript:outLogin();">退出</a>
            </div>
        </header>
        <section>
            <!--产品列表-->
            <div class="panel panel-product-list">
                <div class="panel-header">
                    <div class="btn-group">
                        <button id="btn-add-bom" onclick="toAddProductBom();" class="btn btn-add" type="button">新增产品结构</button>
                    </div>
                    
                    <div class="btn-group">
                        <button class="btn btn-import" type="button" id="downLoadListModel">下载模版</button>
                    </div>
                    <div class="btn-group">
                        <form class="fileform6" method= "post" enctype ="multipart/form-data">
                        <input type="button" value="导入产品结构" onclick="importProdList.click()" class="btn btn-import">  
					 	<input type="file" id="importProdList" style="display:none" onchange="importListExcel(this)"  name="fileName">
				   		</form>
                    </div>
                </div>
                <div class="panel-body">
                    <ul class="table-header">
                        <li>产品</li>
                        <li>料号</li>
                        <li>数量</li>
                        <li>来源</li>
                        <li>单价（元）</li>
                        <li>详情</li>
                        <li>工序</li>
                    </ul>
                    <ul id="productBomTab" class="table-body">
                    </ul>
                </div>
            </div>
            
            <div id="bom_page" class="table-footer">
                <div class="table-info">
                    <template v-if="page">
                    共 {{page.totalPage}} 页 {{page.totalRecord}} 条记录
                    </template>
                </div>
                <template v-if="page && page.pageList">
                <div class="bom_pager pager">
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
                        到第<input type="number" min="1" :max="page.totalPage" class="bom_jumpPage" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>页
                        <button class="bom_jump" :data-index="page.totalPage">确定</button>
                    </span>
                </div>
                </template>
            </div>

            <!--新增产品-->
            <div class="panel panel-append">
                <div class="panel-header">
                    <a class="return" href="javascript:;">返回</a>
                    <div class="btn-group">
                        <button onclick="showDeleteDiv();" id="deleteBtn" style="display: none;" class="btn btn-delete" type="button">删除</button>
                    </div>
                </div>
                <div class="panel-body">
                    <!--产品面板-->
                    <div class="collapse open">             
                            <div class="collapse-title">
                                <span>产品</span><span v-if="subProduct.product != null" class="name"></span>
                                <div class="operate">
                                    <a class="edit" id="subBomBtn" href="javascript:;">收起</a>
                                </div>
                            </div>
                            <div class="collapse-content">
                                <div id="sub_product" v-if="subProduct.product != null" class="info">
                                    <div>
                                        <input type="hidden" id="productId" name="productId" :value="subProduct.product.gid">
                                        <input type="hidden" id="bomId" name="bomId" :value="subProduct.gid" >
                                        <a href="javascript:updateProductBom();" ><font color="red">修改</font></a>
                                        <span class="name">名称：{{subProduct.product.productName}}</span>
                                        <span>规格型号：{{subProduct.product.propertys}}</span>
                                        <span>物料编号：{{subProduct.product.productCode}}</span>
                                        <span>单位：{{subProduct.product.basicUnit}}</span>
                                        <span>单价(元)：{{subProduct.product.unitPrice}}</span>
                                    </div>
                                    <div>
                                       <span class="form-item required"><label>需求单数</label><input id="bomNum" type="number" name="" min="0" :value="subProduct.bomNum" placeholder="请输入"/></span>
                                       <span class="form-item required">
                                            <label>来源</label>
                                            <select id="workType" :value="subProduct.bomType" name="">
                                               <option value="1">自产</option>
                                               <option value="2">外购</option>
                                               <option value="3">外协加工</option>
                                            </select>
                                       </span>
                                       <span class="form-item required">
                                             <label>损耗(%)</label>
                                             <input id="lossNum" type="number" placeholder="请输入" name="" min="0" :value="subProduct.lossNum == null ? 0 : subProduct.lossNum"/>
                                        </span>
                                    </div>
                                </div>
                                <div id="productLineSel" class="flows">
                                    <h3>工序</h3>
                                    <div>  
                                        <select id="lineSelect" onchange="productTechnicsChange(this);">
                                            <option value="0">--请选择--</option>
                                        <template v-for="item in productLine">
                                            <option :value="item.gid">{{item.lineName}}</option>
                                        </template>
                                        </select>
                                        <template v-for="item in productLine">
                                        <div :id="str + item.gid" class="technicsDiv" style="display: none;">
                                            <ul>
                                                <template v-for="item2 in item.technicss">
                                                    <li  class="flow-item" :id="item2.gid">{{item2.technicsName}}</li>
                                                </template>
                                            </ul>
                                        </div>
                                        </template>
                                    </div>
                                </div>
                            </div>
                    </div>

                    <!--子件容器-->
                    <div id="children_bom" class="component-container">
                        <ul>
                            <template v-for="item in products">
                            <li :id="item.gid" class="collapse">
                                <div class="collapse-title">
                                    <input type="hidden" class="productId" name="productId" :value="item.product.gid">
                                    <input type="hidden" class="bomId" name="bomId" :value="item.gid">
                                    <span></span><span class="name">{{item.product.productName}} {{item.product.propertys}} 数量: {{item.bomNum}}</span>
                                    <div class="operate">
                                        <a class="edit" href="javascript:;">编辑</a>
                                        <a class="delete" @click="deleteChildrenBom($event)" >删除</a>
                                    </div>
                                </div>
                                <div class="collapse-content">
                                    <div class="info">
                                        <div>
                                            <span class="name">名称：<span>{{item.product.productName}}</span><a class="edit" href="javascript:;"><!-- 修改 --></a></span>
                                            <span>规格型号：{{item.product.propertys}}</span>
                                            <span class="productCode">物料编号：{{item.product.productCode}}</span>
                                            <span>单位：{{item.product.basicUnit}}</span>
                                            <span>单价(元)：{{item.product.unitPrice}}</span>
                                        </div>
                                        <div>
                                           <span class="form-item required"><label>需求单数</label><input class="bomNum" type="number" name="" min="0" :value="item.bomNum" placeholder="请输入"/></span>
                                           <span class="form-item required">
                                                <label>来源</label>
                                                <select class="workType" :value="item.bomType" name="">
                                                   <option value="1">自产</option>
                                                   <option value="2">外购</option>
                                                   <option value="3">外协加工</option>
                                                </select>
                                           </span>
                                           <span class="form-item required">
                                                 <label>损耗(%)</label>
                                                 <input type="number" class="lossNum" placeholder="请输入" max="100" name="" min="0" :value="item.lossNum == null ? 0 : item.lossNum"/>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            </template>
                        </ul>
                        <a class="btn-add-component" href="javascript:addChildrenBom();">添加子件</a>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="btn-group">
                        <button onclick="saveProductBom()" class="btn btn-save" type="button">保存</button>
                    </div>
                </div>
            </div>
        </section>
    </article>
    <div class="mask"></div>
    <aside class="dialog-pro-select" id="dialog-pro-select">
        <header>
            <div class="select-result">
                <h3>所选物料：</h3>
                <ul id="result-ul">
                    <li style="display: none;" class="no-result">最多可选择1项</li>
                    <!--没有选择时显示，有选择隐藏，选择产品时只能选择一项，选择子件时只能选择3项
                    <li class="no-result">最多可选择1项</li>
                    <li class="no-result">最多可选择3项</li>
                   -->
                   <!-- <li class="result">盒子 10*25（GT642）<span class="icon icon-close-circle"></span></li>
                   <li class="result">盒子 10*25（GT642）<span class="icon icon-close-circle"></span></li>
                   <li class="result">盒子 10*25（GT642）<span class="icon icon-close-circle"></span></li> -->
                </ul>
            </div>
            <div class="search-bar">
                <span class="icon icon-search"></span>
                <input id="searchInput" type="text" placeholder="请输入搜索关键字"/>
                <button onclick="searchProduct();" type="button">搜索</button>
            </div>
        </header>
        <section>
            <ul id="categoryNav" class="nav">
                <template v-for="item in categorys">
                    <li :id="item.gid">{{item.categoryName}}</li>
                </template>
                
            </ul>
            <div class="main">
                <div class="table-header">
                    <span>名称</span>
                    <span>规格型号</span>
                    <span>物料编号</span>
                    <span>单位</span>
                    <span>单价(元)</span>
                    <span>选择</span>
                </div>
                <ul id="main" class="table-body">
                <template v-for="item in products">
                    <li :id="item.gid">
                        <input type="checkbox" name="" value="" :id="itemStr+item.gid"/>
                        <label  onclick="addChecked(this);" :for="itemStr+item.gid">
                            <span>{{item.productName}}</span>
                            <span>{{item.propertys}}</span>
                            <span>{{item.productCode}}</span>
                            <span>{{item.basicUnit}}</span>
                            <span>{{item.unitPrice}}</span>
                            <span></span>
                        </label>
                    </li>
                </template>
                </ul>
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
        </section>
        <footer>
            <button onclick="toProductInfo();" type="button" class="save">确定</button>
        </footer>
        <span class="icon icon-close-circle"></span>
    </aside>
    <div style="display: none;" class="toast toast-success">
        <p>已成功添加至BOM车</p>
    </div>
    <div id="bomIfDialog" style="display: none;" class="dialog-confirm">
        <p>确定删除该BOM？</p>
        <div>
            <button type="button" onclick="cancelDeleteDiv();" class="cancel">取消</button>
            <button type="button" onclick="deleteProductBom();" class="ok">确定</button>
        </div>
    </div>
    <script type="text/javascript">
        $(function(){
            //新增产品：面板展开、收起，一次只能展开一个面板
            $(".collapse-title .edit").click(function(){
                var collapse = $(this).parent().parent();
                if(collapse.hasClass("open")){
                    collapse.removeClass("open");
                    $(this).text("编辑");
                }else{
                    $(".collapse.open").each(function(){
                        $(this).removeClass("open");
                        $(this).find(".collapse-title .edit").text("编辑");
                    });
                    collapse.addClass("open");
                    $(this).text("收起");
                }
            });

            //添加工序
            $(".collapse-content > .flows > .add-flow").click(function(){
                $(this).siblings("div").show();
            });

            //选择弹窗显示/隐藏
            $("#btn-add-bom").click(function(){
                $(".mask").show();
                $("#dialog-pro-select").show();
            });
            $(".mask").click(function(){
                clearProductPanl();
            });
            $("#dialog-pro-select").children(".icon.icon-close-circle").click(function(){
                clearProductPanl();
            });


            //新增产品显示、隐藏
            /*$(".btn-add").click(function(){
                $(".panel-product-list").hide();
                $(".panel-append").show();
            });*/
            $(".return").click(function(){
                $(".panel-product-list").show();
                $(".panel-append").hide();
                $("#bom_page").show();
                $("#deleteBtn").hide();
            });

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
                    alert("请输入页码");
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


            $("#bom_page").on("click", ".bom_pager a", function() {
                var nowPage = $(this).attr("data-index");
                pageFlag = nowPage;
                var totalPage = $(this).attr("totalPage");
                var direction = $(this).attr("direction");
                if (direction == undefined) {
                    if (nowPage != undefined) {
                        findProductBomChildren(nowPage);
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
                        findProductBomChildren(nowPage);
                    }
                }
            });

            //页面跳转
            $("#bom_page").on("click", ".bom_jump", function() {
                var nowPage = $(".bom_jumpPage").val();
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
                    findProductBomChildren(nowPage);
                }
            });

            $("#children_bom").on('blur', "input[class='bomNum']", function(){
                childrenBomNumBlur(this);
            });

            $("#children_bom").on('blur', "input[class='lossNum']" ,function(){
                childrenLossNumBlue(this);
            });

            $("#children_bom").on('change', "select[class='workType']", function(){
                childrenWorkTypeChange(this);
            });
        });

        //退出登录
        function outLogin(){
            window.location.href = '${request.contextPath}/loginController/outLogin.do';
        }
        
        //产品结构清单excel模版下载
        $("#downLoadListModel").click(function(){
			var url = "http://"+ location.host +"/materials/static/img/excel/bom产品列表模版.xlsx";
			window.open(url)  
		});  
        
        //导入bom的产品结构清单文件
		function importListExcel(file){
			var importExcel = document.getElementById('importProdList');
			if (importExcel == null || "" == importExcel ){  
				alert("请您先选择要上传的文件");
			} 
			
			var formData = new FormData($(".fileform6")[0]);
			  $.ajax({
	 			   	url : "${request.contextPath}/importController/importListExcel.do?type=excel",
	 			   	type : "post",
	 			   	dataType : "json",
	 			   	data : formData,
	 			   	processData : false, // 不处理数据
	 			   	contentType : false, // 不设置内容类型
	 			   	success : function(data) {
	 			   		$("#importProdList").val("");				//解决不能上传同一文件两次
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
		
    </script>

</body>
﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.Product.product_price_window" validateRequest="false"%>

    <div class="modal-header">
        <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body" style="max-height:500px;overflow-y:auto;">
        <div class="row">
            <div class="col-xlg-2 col-lg-3 col-md-3">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <form>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <input type="text" name="key" id="key" value="<%=key %>" class="form-control form-control-sm" onkeydown="if(event.keyCode==13){search_();}">
                                            <div class="input-group-append">
                                                <button type="button" class="btn btn-primary" onclick="searchproduct();"><i class="ti-search"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <ul class="list-style-none">
                                    <%=CreateTree() %>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xlg-10 col-lg-9 col-md-9">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 m-b-10">
                                <button class="btn btn-success" onclick="saveproduct_price();"><i class="ti-check"></i> <%=Tag("提交")%></button>
                            </div>
                        </div>
                        <div id="productlist"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
    </div>
    <script>
        var userlevelid=<%=userlevelid %>;
        function selectproductone(id,number) {
            search_product(id,number);
        }
        function searchproduct(id)
        {
            if(id!=undefined)
                userlevelid=id;
            var key = $("#key").val();
            reloadproducts(1,key,userlevelid); 
        }
        function reloadproducts(pageindex,key,userlevelid){
            var url = "<%=site.AdminPath %>/product/product_price_list_window.aspx?page="+pageindex+"&key="+key+"&userlevelid="+userlevelid+"&productid=<%=product.id%>";
            GetHtml(url,'productlist');
        }
        function saveproduct_price()
        {
            $("#EditModal").modal("hide");
            var postData=GetFormJsonData("shop");
            var url="<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Price_Edit&userlevelid="+userlevelid+"&productid=<%=product.id%>";
            RequestAjax(url,postData,function(){MsgBox(1,"<%=Tag("操作成功")%>","?")});
        }
        reloadproducts(1,'',<%=userlevelid%>);
    </script>
    <script src="<%=site.AdminJsPath %>/tree.js"></script>

  
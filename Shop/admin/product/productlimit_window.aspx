﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.productlimit_window" validateRequest="false"%>

    <style>
        .menu.table td, .menu.table th {
            padding: .25rem 0;
            border-top: none;
        }
    </style>
    <div class="modal-header">
        <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body" style="max-height:700px;overflow-y:auto;">
        <div class="row">
            <div class="col-xlg-2 col-lg-2 col-md-2">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <form>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <input type="text" name="key" id="key" value="<%=key %>" class="form-control" onkeydown="if(event.keyCode==13){searchproduct();}">
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
                                <div class="card-body inbox-panel p-t-0 p-b-0">
                                    <div class="table-responsive">
                                        <table class="menu table table-hover no-wrap">
                                            <%=CreateTree(0,0) %>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xlg-10 col-lg-10 col-md-10">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 m-b-10">
                                <button class="btn btn-success" onclick="saveproductlimit();"><i class="ti-check"></i> <%=Tag("提交")%></button>
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
            var typeid = 0;
            function selectproductone(id, number) {
                search_product(id, number);
            }
            function searchproduct(id) {
                if (id != undefined)
                    typeid = id;
                var key = $("#key").val();
                reloadproducts(1, typeid, key,<%=user.id %>,<%=userlevel.id %>);
            }
            function reloadproducts(pageindex, typeid, key, userid, userlevelid) {
                var url = "<%=site.AdminPath %>/product/productlimit_list_window.aspx?page=" + pageindex + "&typeid=" + typeid + "&key=" + key + "&userid=" + userid + "&userlevelid=" + userlevelid;
                GetHtml(url, 'productlist');
            }
            function saveproductlimit() {
                $("#EditModal").modal("hide");
                var postData = GetFormJsonData("limit");
                var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=ProductLimit_Edit&userlevelid=<%=userlevel.id %>&userid=<%=user.id %>";
                RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
            }
            reloadproducts(1, 0, '',<%=user.id %>,<%=userlevel.id %>);
        </script>
        <script src="<%=site.AdminJsPath %>/tree.js"></script>

  
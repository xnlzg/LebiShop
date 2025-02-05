﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.User.productlimit_window" validateRequest="false"%>

    <div class="modal-header">
        <h4 class="modal-title"><%=LB.Tools.RequestTool.RequestString("title")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
    </div>
    <div class="modal-body" style="max-height:500px;overflow-y:auto;">
        <div class="row">
            <div class="col-xlg-2 col-lg-2 col-md-3">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <form>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <input type="text" name="searchkey" id="searchkey" value="<%=key %>" class="form-control form-control-sm" onkeydown="if(event.keyCode==13){search_();}">
                                            <div class="input-group-append">
                                                <button type="button" class="btn btn-primary" onclick="searchproduct(<%=userlevelid%>);"><i class="ti-search"></i></button>
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
            <div class="col-xlg-10 col-lg-10 col-md-9">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 m-b-10">
                                <button class="btn btn-success" onclick="saveproductlimit();"><i class="ti-check"></i> <%=Tag("提交")%></button>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover no-wrap">
                                <thead>
                                    <tr>
                                        <th>
                                            <%=Tag("账号")%>
                                        </th>
                                        <th>
                                            <%=Tag("姓名")%>
                                        </th>
                                        <th>
                                            <%=Tag("分组")%>
                                        </th>
                                        <th style="width: 60px">
                                            <a href="javascript:void(0);" onclick="$('input[cname=\'IsShow\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));">
                                                <%=SYS.ProductLimitType=="0"?Tag("禁止浏览"):Tag("允许浏览")%>
                                            </a>
                                        </th>
                                        <th style="width: 60px">
                                            <a href="javascript:void(0);" onclick="$('input[cname=\'IsPriceShow\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));">
                                                <%=SYS.ProductLimitType=="0"?Tag("禁止看价"):Tag("允许看价")%>
                                            </a>
                                        </th>
                                        <th style="width: 60px">
                                            <a href="javascript:void(0);" onclick="$('input[cname=\'IsBuy\']').attr('checked',!$(this).attr('checked'));$(this).attr('checked',!$(this).attr('checked'));">
                                                <%=SYS.ProductLimitType=="0"?Tag("禁止购买"):Tag("允许购买")%>
                                            </a>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="productlist"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
    </div>
    <script>
        var userlevelid =<%=userlevelid %>;
        function selectproductone(id, number) {
            search_product(id, number);
        }
        function searchproduct(id) {
            if (id != undefined)
                userlevelid = id;
            var key = $("#searchkey").val();
            reloadproducts(1, key, userlevelid);
        }
        function reloadproducts(pageindex, key, userlevelid) {
            var url = "<%=site.AdminPath %>/user/productlimit_list_window.aspx?page=" + pageindex + "&key=" + key + "&userlevelid=" + userlevelid + "&productid=<%=product.id%>";
            GetHtml(url, 'productlist');
        }
        function saveproductlimit() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("limit");
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=ProductLimit_Edit_product&userlevelid=" + userlevelid + "&productid=<%=product.id%>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?") });
        }
        reloadproducts(1, '',<%=userlevelid %>);
    </script>
    <script src="<%=site.AdminJsPath %>/tree.js"></script>

  
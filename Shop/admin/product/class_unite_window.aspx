﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.Class_Unite_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("合并分类")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="fromid"><%=Tag("源分类")%>：</label>
                <select name="fromid" id="fromid" class="form-control">
                    <%=Shop.Bussiness.EX_Product.TypeOption(0, 0, 0, CurrentLanguage.Code, Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                </select>
            </div>
            <div class="form-group">
                <label for="toid"><%=Tag("目的分类")%>：</label>
                <select name="toid" id="toid" class="form-control">
                    <%=Shop.Bussiness.EX_Product.TypeOption(0, 0, 0, CurrentLanguage.Code, Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        $("#EditModal").modal("hide");
        function SaveObj(){var fromid=$("#fromid").val();var toid=$("#toid").val();var postData={"toid":toid,"fromid":fromid};var url="<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Class_Unite";RequestAjax(url,postData,function(){MsgBox(1,"<%=Tag("操作成功")%>","?")})}
    </script>

  
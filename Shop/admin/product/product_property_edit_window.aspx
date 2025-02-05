﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_property_edit_window" validateRequest="false"%>

    <form action="javascript:SaveObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("商品规格")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Way_1"><%=Tag("生成范围")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="Way_1" name="Way" value="1" class="custom-control-input" sonproduct="true" checked>
                        <span class="custom-control-label"><%=Tag("选定商品")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="Way_0" name="Way" value="0" class="custom-control-input" sonproduct="true">
                        <span class="custom-control-label"><%=Tag("全部商品")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Pro_Type_id"><%=Tag("商品类别")%>：</label>
                <select id="Pro_Type_id" name="Pro_Type_id" class="form-control" sonproduct="true" onchange="getsubproducts();">
                    <option value=""><%=Tag("请选择")%></option>
                    <%=Shop.Bussiness.EX_Product.TypeOption(0, 0, 0, CurrentLanguage.Code)%>
                </select>
            </div>
            <div class="form-group" id="table4">
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
        </div>
    </form>
    <script>
        function Product_Edit_muti() {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("sonproduct");
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Property_Edit&ids=<%=ids %>";
            RequestAjax(url, postData, function () { MsgBox(1, "<%=Tag("操作成功")%>", "?"); });
        }
        function CreateProduct() {
            if (!confirm("<%=Tag("确认要生成同款的商品数据吗？")%>"))
                return false;
            var ggs = GetChkCheckedValues("Property131");
            var pid = 99999999;
            var tid = $("#Pro_Type_id").val();
            var postData = { "ggs": ggs, "pid": pid, "tid": tid, "randnum": 99999999 };
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=CreateProductGuiGe";
            RequestAjax(url, postData, function () { getsubproducts(); });
        }
        function Product_Status_Edit_muti(status) {
            var postData = GetFormJsonData("ShopKeyID");
            var action = $("#action").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Status_Edit_muti&status=" + status;
            RequestAjax(url, postData, function () { getsubproducts(); });
        }
        function DeleteConfirm() {
            $("#Modal-Confirm").modal("show");
            $("#Confirm-Content").html("<%=Tag("确认要删除吗？")%>");
            $("#Modal-Confirm .btn-success.btn-ok").attr("onclick", "Product_Del();");
        }
        function Product_Del() {
            $("#Modal-Confirm").modal("hide");
            var postData = GetFormJsonData("ShopKeyID");
            var action = $("#action").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Del";
            RequestAjax(url, postData, function () { getsubproducts(); });
        }
        function getsubproducts() {
            var id = $("#Pro_Type_id").val();
            var Property131 = GetChkCheckedValues("Property131");
            var ProPertyMain = $("#ProPertyMain").val();
            $.ajax({
                type: "POST",
                url: "product_edit_list.aspx?tid=" + id + "&pid=99999999&Property131=" + Property131 + "&ProPertyMain=" + ProPertyMain + "&mutiadd_property=1",
                data: '',
                success: function (res) {
                    $("#table4").html(res);
                }
            });
        }
    </script>

  
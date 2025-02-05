﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_Image_Edit_window" validateRequest="false"%>

    <form action="javascript:SavePImageObj();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("批量编辑商品图片")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="ImageOriginalson"><%=Tag("商品主图")%>：</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="image_ImageOriginalson"><%if (model.ImageOriginal != ""){%><img src="<%=Image(model.ImageOriginal," small")%>" height="20" /><%}else{ %><i class="ti-image"></i><%}%></span>
                    </div>
                    <input type="text" id="ImageOriginalson" name="ImageOriginalson" value="<%=model.ImageOriginal %>" class="form-control">
                    <div class="input-group-append fileupload">
                        <span class="input-group-text"><i class="ti-upload"></i></span>
                        <input type="file" id="file_ImageOriginalson" name="file_ImageOriginalson" class="upload" onchange="uploadImage('ImageOriginalson')">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="sonImages"><%=Tag("展示图")%>：</label>
                <div class="input-group">
                    <textarea id="sonImages" name="sonImages" class="form-control" shop="true" style="height: 60px;display:none;"><%=model.Images %></textarea>
                    <div id="sonimagesdiv"></div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-check"></i> <%=Tag("保存")%></button>
        </div>
    </form>
    <script>
        function SavePImageObj() {
            $("#EditModal").modal("hide");
            var smalliamge = $("#ImageOriginalson").val();
            var images = $("#sonImages").val();
            var postData = { "smalliamge": smalliamge, "images": images };
            var action = $("#action").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_product.aspx?__Action=Product_Image_Edit_muti&ids=<%=ids %>";
            RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "");getsubproducts();});
        }
        function getsubproducts() {
            $.ajax({
                type: "POST",
                url: "subproduct_list.aspx?pid=<%=id %>&randnum=<%=randnum %>",
                data: '',
                success: function (res) {
                    $("#subproducts").html(res);
                }
            });
        }
        $(function () {
            var images = $("#sonImages").val();
            $.ajax({
                type: "POST",
                url: "<%=site.AdminPath %>/product/imagesupload.aspx?input=sonImages",
                data: { "images": images },
                success: function (res) {
                    $("#sonimagesdiv").html(res);
                }
            });
        });
    </script>

  
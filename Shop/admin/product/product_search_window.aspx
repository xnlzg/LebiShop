﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.product_search_window" validateRequest="false"%>

    <form action="javascript:SearchProduct();" novalidate>
        <div class="modal-header">
            <h4 class="modal-title"><%=Tag("商品查询")%></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        </div>
        <div class="modal-body" style="max-height:500px;overflow-y:auto;">
            <div class="form-group">
                <label for="Name"><%=Tag("名称")%>：</label>
                <input type="text" id="Name" name="Name" value="<%=model.Name %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchProduct();}">
            </div>
            <div class="form-group">
                <label for="Number"><%=Tag("商品编号")%>：</label>
                <input type="text" id="Number" name="Number" value="<%=model.Number %>" class="form-control" shop="true" onkeydown="if(event.keyCode==13){SearchProduct();}">
            </div>
            <div class="form-group">
                <label for="Type_id_ProductType"><%=Tag("商品类型")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeCheckbox("ProductType", "Type_id_ProductType", model.Type_id_ProductType, "shop=\"true\"", CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="iscombo_2"><%=Tag("组合商品")%>：</label>
                <div class="input-group">
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="iscombo_2" name="iscombo" value="" class="custom-control-input" shop="true" <%=model.iscombo==""?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("全部")%></span>
                    </label>
                    <label class="custom-control custom-radio m-r-20">
                        <input type="radio" id="iscombo_1" name="iscombo" value="1" class="custom-control-input" shop="true" <%=model.iscombo=="1"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("是")%></span>
                    </label>
                    <label class="custom-control custom-radio">
                        <input type="radio" id="iscombo_1" name="iscombo" value="0" class="custom-control-input" shop="true" <%=model.iscombo=="0"?"checked":"" %>>
                        <span class="custom-control-label"><%=Tag("否")%></span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="Type_id_ProductStatus"><%=Tag("状态")%>：</label>
                <div class="input-group">
                    <%=Shop.Bussiness.EX_Type.TypeCheckbox("ProductStatus", "Type_id_ProductStatus", model.Type_id_ProductStatus, "shop=\"true\"", CurrentLanguage.Code)%>
                </div>
            </div>
            <div class="form-group">
                <label for="Brand_id"><%=Tag("品牌")%>：</label>
                <%
                int Brand_id = 0;
                int.TryParse(model.Brand_id, out  Brand_id);
                %>
                <select id="Brand_id" name="Brand_id" class="form-control" shop="true">
                    <option value="0">
                        <%=Tag("全部")%>
                    </option>
                    <%=Shop.Bussiness.EX_Product.BrandOption(Brand_id, CurrentLanguage.Code)%>
                </select>
            </div>
            <%if (Shop.LebiAPI.Service.Instanse.Check("plugin_gongyingshang")){ %>
            <div class="form-group">
                <label for="Supplier_id"><%=Tag("商家")%>：</label>
                <%
                int Supplier_id = 0;
                int.TryParse(model.Supplier_id, out  Supplier_id);
                %>
                <select id="Supplier_id" name="Supplier_id" class="form-control" shop="true">
                    <option value="0">
                        <%=Tag("全部")%>
                    </option>
                    <%=Shop.Bussiness.EX_Supplier.SupplierOption(Supplier_id, CurrentLanguage.Code)%>
                </select>
            </div>
            <%} %>
            <div class="form-group">
                <label for="Count_Sales1"><%=Tag("销量")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Count_Sales1" name="Count_Sales1" value="<%=model.Count_Sales1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Count_Sales2" name="Count_Sales2" value="<%=model.Count_Sales2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" onkeydown="if(event.keyCode==13){SearchProduct();}">
                </div>
            </div>
            <div class="form-group">
                <label for="Count_Stock1"><%=Tag("库存")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Count_Stock1" name="Count_Stock1" value="<%=model.Count_Stock1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Count_Stock2" name="Count_Stock2" value="<%=model.Count_Stock2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" onkeydown="if(event.keyCode==13){SearchProduct();}">
                </div>
            </div>
            <div class="form-group">
                <label for="Count_StockCaution1"><%=Tag("预警库存")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Count_StockCaution1" name="Count_StockCaution1" value="<%=model.Count_StockCaution1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Count_StockCaution2" name="Count_StockCaution2" value="<%=model.Count_StockCaution2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" onkeydown="if(event.keyCode==13){SearchProduct();}">
                </div>
            </div>
            <div class="form-group">
                <label for="Count_Views1"><%=Tag("浏览量")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Count_Views1" name="Count_Views1" value="<%=model.Count_Views1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Count_Views2" name="Count_Views2" value="<%=model.Count_Views2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d]/g,'')" onkeydown="if(event.keyCode==13){SearchProduct();}">
                </div>
            </div>
            <div class="form-group">
                <label for="Price1"><%=Tag("价格")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Price1" name="Price1" value="<%=model.Price1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Price2" name="Price2" value="<%=model.Price2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" onkeydown="if(event.keyCode==13){SearchProduct();}">
                </div>
            </div>
            <%if (Shop.Bussiness.EX_Admin.CheckPower("product_price_cost")){ %>
            <div class="form-group">
                <label for="Price_Cost1"><%=Tag("成本价")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Price_Cost1" name="Price_Cost1" value="<%=model.Price_Cost1 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Price_Cost2" name="Price_Cost2" value="<%=model.Price_Cost2 %>" class="form-control" shop="true" onkeyup="value=value.replace(/[^\d\.]/g,'')" onkeydown="if(event.keyCode==13){SearchProduct();}">
                </div>
            </div>
            <%} %>
            <div class="form-group">
                <label for=""><%=Tag("商品标签")%>：</label>
                <div class="input-group">
                    <% foreach (DB.LebiShop.Lebi_Pro_Tag t in DB.LebiShop.B_Lebi_Pro_Tag.GetList("", "")){ %>
                    <label class="custom-control custom-checkbox m-r-20">
                        <input type="checkbox" id="Pro_Tag_id_<%=t.id %>" name="Pro_Tag_id" value="<%=t.id %>" class="custom-control-input" shop="true" <%=(","+model.Pro_Tag_id+",").Contains(","+t.id+",")?"checked":"" %>>
                        <span class="custom-control-label"><%=Shop.Bussiness.Language.Content(t.Name,CurrentLanguage.Code) %></span>
                    </label>
                    <%} %>
                </div>
            </div>
            <div class="form-group">
                <label for="Time_Add1"><%=Tag("添加时间")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Time_Add1" name="Time_Add1" value="<%=model.Time_Add1 %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Time_Add2" name="Time_Add2" value="<%=model.Time_Add2 %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="Time_OnSale1"><%=Tag("上架时间")%>：</label>
                <div class="input-daterange input-group">
                    <input type="text" id="Time_OnSale1" name="Time_OnSale1" value="<%=model.Time_OnSale1 %>" class="form-control" shop="true">
                    <div class="input-group-append">
                        <span class="input-group-text bg-info b-0 text-white">-</span>
                    </div>
                    <input type="text" id="Time_OnSale2" name="Time_OnSale2" value="<%=model.Time_OnSale2 %>" class="form-control" shop="true">
                </div>
            </div>
            <div class="form-group">
                <label for="Pro_Type_id"><%=Tag("商品分类")%>：</label>
                <div class="input-group">
                    <select name="Pro_Type_id" id="Pro_Type_id" shop="true" multiple="multiple" size="8">
                        <%=Shop.Bussiness.EX_Product.TypeOption(0,model.Pro_Type_id,0,CurrentLanguage.Code,Shop.Bussiness.EX_Admin.Project().Pro_Type_ids)%>
                    </select>
                </div>
            </div>
            <%if (domain3admin){ %>
            <div class="form-group">
                <label for="Site_ids"><%=Tag("站点")%>：</label>
                <div class="input-group">
                    <%=site.SiteCheckbox("Site_ids",model.Site_ids,CurrentLanguage.Code)%>
                </div>
            </div>
            <%} %>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal"><i class="ti-close"></i> <%=Tag("关闭")%></button>
            <button type="submit" class="btn btn-success"><i class="ti-search"></i> <%=Tag("搜索")%></button>
        </div>
    </form>
    <script>
        $('#Time_Add1').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });        $('#Time_Add2').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        $('#Time_OnSale1').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });        $('#Time_OnSale2').daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {format: 'YYYY-MM-DD'}
        });
        function SearchProduct()
        {
            $("#EditModal").modal("hide");
            var postData = GetFormJsonData("shop");
            var url = "<%=site.AdminPath %>/ajax/ajax_search.aspx?__Action=ProductSearch";
            $.ajax({
                type: "POST",
                url: url,
                data: postData,
                dataType: 'json',
                success: function (res) {
                    <%=callback %>(res.url);
                }
            });
        }
        $().ready(function () {
            $('#Pro_Type_id').multiselect2side({
                selectedPosition: 'right',
                moveOptions: false,
                //search: "<img src='img/search.gif' align=\"absmiddle\" /> ",
                labelsx: '',
                labeldx: '',
                autoSort: false,
                autoSortAvailable: false
            });
        });
    </script>

  
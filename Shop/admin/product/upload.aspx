﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.product.upload" validateRequest="false"%>

<html>
<head>
<title>LebiShop Upload</title>
<script src="<%=site.AdminAssetsPath %>/plugins/jquery/jquery.min.js"></script>
<script src="<%=site.AdminAssetsPath %>/plugins/SaPload/SaPload.dev.js"></script>
<style type="text/css">
html,body{margin:0;padding:0;font-size:12px;}
.SaPload {width:1000px; height:40px;margin:0 auto;overflow:hidden;display:block;}
</style>
</head>
<body>
<script type="text/javascript">
    var sp1;
    var i=<%=i %>;
    $(document).ready(function () {
        <%if (model.UpLoadMode=="0"){ %>
        var sp1 = SaPload.createNew({"sa_box_id":"SaPload1","sa_args":'{"name":"test"}', "sa_path": "<%=site.AdminAssetsPath %>/plugins/SaPload/", "sa_upload_url": "<%=site.WebPath %>/ajax/imageuploadmuti.aspx","sa_skin":"flash"<%if (CurrentLanguage.Code=="EN"){ %>, "sa_lang": "english"<%} %>,"sa_upload_max_size":"1204","sa_upload_max_num":"100"});
        SaPload.JsonData = function (t) {
			var obj = eval('(' + t + ')');
			if(obj.action=='back'){
			    t=eval('(' + obj.msg + ')').img;
			    t='1';
			    parent.document.getElementById('<%=inputname %>').value += "@" + t;
			    i++;
			    t='<%=WebPath %>' + t;
			    if(t.indexOf('/')==-1)
			        t='<%=webconfig.ImageURL %>' + t;
			    var div = '<li class="imagespreviewlist" id="<%=inputname %>img' + i + '"><span class="image"><img src="' + t + '"/></span><span class="image-manage"><a href="javascript:void(0)" onclick="deleteimage(\'' + t + '\',' + i + ')"><%=Tag("删除") %></a></span></li>';
                parent.document.getElementById('<%=inputname %>images').innerHTML += div;
            }
        };
        <%}else{ %>
        var sp1 = SaPload.createNew({ "sa_box_id": "SaPload1", "sa_args": '{"name":"test"}', "sa_path": "<%=site.AdminAssetsPath %>/plugins/SaPload/", "sa_upload_url": "../../ajax/imageuploadmuti.aspx", "sa_model": "html5", "sa_skin": "default", "sa_upload_max_size": "1204", "sa_upload_max_num": "100","sa_upload_type":'{"图片文件":"*.jpg;*.jpeg;*.gif;*.png"}'<%if (CurrentLanguage.Code=="EN"){ %>, "sa_lang": "english"<%} %> });
        SaPload.PicData = function (t) {
            var obj = eval('(' + t + ')');
            t=obj.img;
            parent.document.getElementById('<%=inputname %>').value += "@" + t;
            i++;
            t='<%=WebPath %>' + t;
            if(t.indexOf('/')==-1)
                t='<%=webconfig.ImageURL %>' + t;
            var div = '<li class="imagespreviewlist" id="<%=inputname %>img' + i + '"><span class="image"><img src="' + t + '"/></span><span class="image-manage"><a href="javascript:void(0)" onclick="deleteimage(\'' + t + '\',' + i + ')"><%=Tag("删除") %></a></span></li>';
            parent.document.getElementById('<%=inputname %>images').innerHTML += div;
        };
        <%} %>
    });
</script>
<span id="SaPload1" class="SaPload"></span>
</body>
</html>

  
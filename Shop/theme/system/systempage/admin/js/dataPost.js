
//�������ݶ���
//һ����ӻ����
function SaveData(objName, postData, href) {
    if (href == undefined)
        href = "";
    var __Add = "";
    if ($("#IsAdd").attr("checked") == true)//�Ƿ�ѡ�˸������
        __Add = "&__Add=1";
    $.ajax({
        type: "POST",
        url: AdminPath + "Ajax/UpData.aspx?__Action=Save&__Target=" + objName + __Add,
        data: postData,
        error: function (state) {
            MsgBox(2, "Error", "");
            return false;
        },
        success: function (res) {
            var jdata = eval("(" + res + ")"); //ת��Ϊjson����           
            if (jdata.err == "OK") {
                if (href.length > 1) {
                    MsgBox(1, "OK", href + jdata.ID);
                }
                else {
                    MsgBox(1, "OK", href);
                }
                return false;
            }
            else {

                MsgBox(2, jdata.err, "");
                return false;
            }
        },
        complete: function () {

        }
    });
}
/*
*********************************************
ɾ�����ݶ���
˵����
objName:�������
postData:json��ʽ�Ĺؼ��ֲ�������ʱ�Զ������ࡰCZSetID=true���ĸ�ѡ������ȡ
href:������ɺ󷵻ص�ַ
*********************************************
*/
function DelData(objName, postData, href, msg, ifalert) {


    if (postData == "") {
        var result = "";
        var chname = "";
        var chks = $("input[CZSetID='true']:checked");
        $.each(chks, function (i, o) {
            if (i > 0)
                result += ",";
            result += $(o).val();
            chname = $(o).attr("name")
        });
        if (result == "") {
            alert("Error!");
            return false;
        }
        else {
            result = "" + chname + ":\"" + result + "\"";
            postData = eval("({" + result + "})");

        }
    }
    if (msg != "NoAsk") {
        if (msg == undefined) {
            msg = "ȷ��Ҫɾ����?";
        }

        if (!confirm(msg)) {
            return false;
        }
    }

    if (href == undefined)
        href = "";
    $.ajax({
        type: "POST",
        url: AdminPath + "Ajax/UpData.aspx?__Action=Del&__Target=" + objName,
        data: postData,
        error: function (state) {
            MsgBox(2, "Error", "");
            return false;
        },
        success: function (res) {

            if (ifalert == true || ifalert == undefined) {
                if (res == "OK") {
                    MsgBox(1, "OK", href);
                }
                else {

                    MsgBox(2, res, "");
                }
            }
        },
        complete: function () {
        }
    });
    return true;
}
/*
*********************************************
����µ�����
˵����
objName:����
objValue:ֵ
*********************************************
*/
function AddObj(objName, objValue) {
    var input = "<input FormObj=\"true\" id=\"" + objName + "\" name=\"" + objName + "\" type=\"hidden\" value=\"" + objValue + "\" />";
    $("#Editor").append(input);
}
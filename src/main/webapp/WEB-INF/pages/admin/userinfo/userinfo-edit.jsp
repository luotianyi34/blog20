<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">
<head>
    <base href="${basePath}">
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="static/x-admin/css/font.css">
    <link rel="stylesheet" href="static/x-admin/css/xadmin.css">
    <link rel="stylesheet" href="static/x-admin/css/theme2.css">
    <script type="text/javascript" src="static/x-admin/js/jquery.min.js"></script>
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/x-admin/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<div style="width: 90%;margin: 0 30px 0 auto">
    <form id="edit" lay-filter="edit" class="layui-form">
        <input type="hidden" name="userId" id="userId" value="${userinfo.userId}">
        <div class="layui-form-item">
            <label class="layui-form-label" for="username"><span class="x-red">*</span>用户名</label>
            <div class="layui-input-block">
                <input type="text" name="username" id="username" placeholder="请输入用户名" autocomplete="off"
                       value="${userinfo.username}" lay-verify="required|username" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="nickname"><span class="x-red">*</span>昵称</label>
            <div class="layui-input-block">
                <input type="text" name="nickname" id="nickname" placeholder="请输入昵称" autocomplete="off"
                       value="${userinfo.nickname}" lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="phone">手机号</label>
            <div class="layui-input-block">
                <input type="text" name="phone" id="phone" placeholder="请输入手机号" autocomplete="off"
                       value="${userinfo.phone}" class="layui-input">
            </div>
        </div>
        <c:if test="${userinfo.userId != 1}">
            <div class="layui-form-item">
                <label class="layui-form-label" for="status">状态</label>
                <div class="layui-input-block">
                    <select name="status" id="status">
                        <option value="1">可用</option>
                        <option value="2">禁用</option>
                    </select>
                </div>
            </div>
        </c:if>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <button class="layui-btn" type="submit" lay-submit lay-filter="submitBtn">提交</button>
            </div>
        </div>
    </form>

</div>
</body>
<script>


    layui.use(["form", "upload"], function () {
        const {form} = layui;
        /*获取状态值*/
        let status = "${userinfo.status}";
        let type = "${type}";
        /*更新修改时下拉框的值*/
        if (status) {
            $("#status").val(status);
            $("#username").prop("disabled", true);
            if (type === "info") {
                $("#status").prop("disabled", true);
            }
            /*在layui中通过js更新select的值后，必须调用form.render去重新渲染*/
            form.render();
        }
        form.verify({
            username: function (username) {
                if (!"${userinfo.userId}") {
                    let code = 200;
                    $.ajax({
                        url: "userinfo/check/username",
                        method: "get",
                        data: {username},
                        dataType: "json",
                        async: false,
                        success(res) {
                            code = res.code;
                        }
                    });
                    if (code === 500) {
                        return "用户名已存在";
                    }
                }
            }
        })
        /*监听提交*/
        form.on("submit(submitBtn)", function ({field}) {
            $.ajax({
                url: "userinfo/update",
                data: field,
                method: "post",
                dataType: "json",
                success(res) {
                    if (res.code === 200) {
                        layer.msg((field.userId ? "修改" : "添加") + "成功", {icon: 6}, function () {
                            const index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                            parent.table.reload("dataList")
                        });
                    } else {
                        layer.alert(res.msg, {icon: 5});
                    }
                }
            });
            return false;
        });
    });
</script>
</html>

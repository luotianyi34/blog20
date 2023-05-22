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
        <div class="layui-form-item">
            <label class="layui-form-label" for="username"><span class="x-red">*</span>用户名</label>
            <div class="layui-input-block">
                <input type="text" name="username" id="username" placeholder="请输入用户名" autocomplete="off"
                       value="${loginInfo.username}" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="oldPassword"><span class="x-red">*</span>原密码</label>
            <div class="layui-input-block">
                <input type="password" name="oldPassword" id="oldPassword" placeholder="请输入原密码" autocomplete="off"
                       lay-verify="required|password" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="password"><span class="x-red">*</span>新密码</label>
            <div class="layui-input-block">
                <input type="password" name="password" id="password" placeholder="新密码" autocomplete="off"
                       class="layui-input" lay-verify="required">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label" for="resPassword"><span class="x-red">*</span>确认密码</label>
            <div class="layui-input-block">
                <input type="password" name="resPassword" id="resPassword" placeholder="确认密码" autocomplete="off"
                       class="layui-input" lay-verify="required|respwd">
            </div>
        </div>
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
        /*自定义验证*/
        form.verify({
            respwd: function (value) {
                if (value !== $("#password").val()) {
                    return "两次密码不一致！"
                }
            },
            password: function (password) {
                let code = 200;
                $.ajax({
                    url: "userinfo/check/password",
                    method: "get",
                    data: {password, userId: "${loginInfo.userId}"},
                    dataType: "json",
                    async: false,
                    success(res) {
                        code = res.code;
                    }
                });
                if (code === 500) {
                    return "原密码不正确";
                }
            }
        })
        /*监听提交*/
        form.on("submit(submitBtn)", function ({field}) {
            field.id = "${loginInfo.userId}";
            field.phone = field.oldPassword;
            $.ajax({
                url: "userinfo/pwd",
                data: field,
                method: "post",
                dataType: "json",
                success(res) {
                    if (res.code === 200) {
                        layer.msg("修改密码成功,请重新登录！", {icon: 6}, function () {
                            top.location.replace("${basePath}")
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

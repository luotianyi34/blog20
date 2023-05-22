<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>未登录</title>
    <base href="${basePath}">
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
</head>
<body>
</body>
<script>
    layui.use(['layer'], function () {
        layer.alert("登录失效，请重新登录！", function () {
            top.location.replace("login");
        })
    })
</script>
</html>

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
        <input type="hidden" name="bannerId" id="bannerId" value="${href.bannerId}">
        <div class="layui-form-item">
            <label class="layui-form-label" for="name"><span class="x-red">*</span>连接名</label>
            <div class="layui-input-block">
                <input type="text" name="name" id="name" placeholder="请输入连接名" autocomplete="off"
                       value="${href.name}" lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="url"><span class="x-red">*</span>连接地址</label>
            <div class="layui-input-block">
                <input type="text" name="url" id="url" placeholder="请输入连接地址" autocomplete="off"
                       value="${href.url}" lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="orderNum">排序值</label>
            <div class="layui-input-block">
                <input type="text" name="orderNum" id="orderNum" placeholder="请输入排序值" autocomplete="off"
                       value="${href.orderNum}" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="target">打开方式</label>
            <div class="layui-input-block">
                <select name="target" id="target">
                    <option value="_self">当前页</option>
                    <option value="_blank">新窗口</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="status">状态</label>
            <div class="layui-input-block">
                <select name="status" id="status">
                    <option value="1">可用</option>
                    <option value="2">禁用</option>
                </select>
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
        /*获取状态值*/
        let status = "${href.status}";
        let target = "${href.target}";

        /*更新修改时下拉框的值*/
        if (status) {
            $("#status").val(status);
            $("#target").val(target);
            /*在layui中通过js更新select的值后，必须调用form.render去重新渲染*/
            form.render();
        }
        /*监听提交*/
        form.on("submit(submitBtn)", function ({field}) {
            $.ajax({
                url: "href/update",
                data: field,
                method: "post",
                dataType: "json",
                success(res) {
                    if (res.code === 200) {
                        layer.msg((field.bannerId ? "修改" : "添加") + "成功", {icon: 6}, function () {
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

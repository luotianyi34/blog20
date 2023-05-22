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
<div class="x-nav">
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="username" placeholder="用户名" autocomplete="off"
                                   class="layui-input">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="nickname" placeholder="昵称" autocomplete="off"
                                   class="layui-input">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="phone" placeholder="手机号" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <select name="status" id="status">
                                <option value="">[选择状态]</option>
                                <option value="1">可用</option>
                                <option value="2">禁用</option>
                            </select>
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <button class="layui-btn" lay-submit="" lay-filter="search"><i
                                    class="layui-icon">&#xe615;</i></button>
                        </div>
                    </form>
                </div>
                <div class="layui-card-body layui-table-body layui-table-main">
                    <table id="dataList" lay-filter="dataList"></table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/html" id="toolbar">
    <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" lay-event="add">添加</button>
</script>
<script type="text/html" id="statusTemp">
    {{# if(d.status === 1){ }}
    <button type="button" lay-event="status" title="点击更改状态" class="layui-btn layui-btn-sm">可用</button>
    {{# }else{ }}
    <button type="button" lay-event="status" title="点击更改状态" class="layui-btn layui-btn-sm layui-btn-danger">禁用
    </button>
    {{# } }}
</script>
<script type="text/html" id="optTemp">
    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-event="update">修改</button>
    <button type="button" class="layui-btn layui-btn-sm layui-btn-warm" lay-event="delete">删除</button>
</script>
<script>

    var table;
    layui.use(['table', 'form'], function () {
        table = layui.table;
        const form = layui.form;
        /*获取部门列表*/
        table.render({
            elem: "#dataList",
            url: "userinfo/page",
            cols: [[
                {title: "编号", field: "userId"},
                {title: "用户名", field: "username"},
                {title: "昵称", field: "nickname"},
                {title: "联系方式", field: "phone"},
                {title: "状态", field: "status", templet: "#statusTemp"},
                {title: "操作", fixed: "right", templet: "#optTemp"}
            ]],
            toolbar: "#toolbar",
            page: true,
            limit: 5,
            limits: [5, 10, 20, 50, 100],
            done(res) {
                if (res.code === 401) {
                    layer.alert(res.msg, function () {
                        if (res.code === 401) {
                            top.location.replace("${basePath}");
                        }
                    })
                }
            }
        });
        table.on("tool(dataList)", function (obj) {
            const {data: {userId}, event} = obj;
            if (event === "delete") {
                layer.confirm("确定删除编号[" + userId + "]的数据吗?", {icon: 3}, function (index) {
                    $.ajax({
                        url: "userinfo/delete/" + userId,
                        method: "delete",
                        success(res) {
                            if (res.code === 200) {
                                layer.msg("删除成功!", {icon: 6});
                                table.reload("dataList")
                            } else {
                                layer.alert(res.msg)
                            }
                        }
                    });
                    layer.close(index);
                })
            } else if (event === "update") {
                xadmin.open("修改用户", "userinfo/edit?userId=" + userId, 500, 400)
            } else if (event === "status") {
                if (userId === 1) {
                    layer.msg("管理员不能更改状态！", {icon: 5});
                } else {
                    layer.confirm("确定更改编号[" + userId + "]的状态吗?", {icon: 3}, function (index) {
                        $.ajax({
                            url: "userinfo/status/",
                            data: {
                                userId,
                                status: obj.data.status === 1 ? 2 : 1
                            },
                            method: "post",
                            success(res) {
                                if (res.code === 200) {
                                    layer.msg("更新成功!", {icon: 6});
                                    table.reload("dataList")
                                } else {
                                    layer.alert(res.msg)
                                }
                            }
                        });
                        layer.close(index);
                    })

                }
            }
        });
        table.on("toolbar(dataList)", function (obj) {
            if (obj.event === "add") {
                xadmin.open("添加用户", "userinfo/edit", 500, 400)
            }
        });

        form.on("submit(search)", function (data) {
            table.reload("dataList", {
                where: data.field,
                page: {
                    curr: 1
                }
            })
            return false;
        });
    });
</script>
</html>

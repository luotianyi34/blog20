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
    <style>
        .layui-table-cell {
            height: 100px !important;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
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
    <button type="button" class="layui-btn layui-btn-sm">可用</button>
    {{# }else{ }}
    <button type="button" class="layui-btn layui-btn-sm layui-btn-danger">禁用</button>
    {{# } }}
</script>
<script type="text/html" id="optTemp">
    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-event="update">修改</button>
    <button type="button" class="layui-btn layui-btn-sm layui-btn-warm" lay-event="delete">删除</button>
</script>
<script type="text/html" id="srcTemp">
    <div id="src_{{d.bannerId}}" style="height: 80px;width: 80px;border-radius: 50%;overflow: hidden;">
        <img src="static/upload/{{d.src}}" layer-src="static/upload/{{d.src}}" alt=""
             style="height: 100%;width: 100%;display: block">
    </div>
</script>
<script>

    var table;
    layui.use(['table', 'form'], function () {
        table = layui.table;
        const form = layui.form;
        /*获取部门列表*/
        table.render({
            elem: "#dataList",
            url: "banner/page",
            cols: [[
                {title: "编号", field: "bannerId"},
                {title: "排序值", field: "orderNum"},
                {title: "图片简介",field: "name"},
                {title:"导航",field: "url"},
                {title: "地址", field: "src", templet: "#srcTemp"},
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
                } else {
                    for (let banner of res.data) {
                        layer.photos({
                            photos: "#src_" + banner.bannerId
                        })
                    }
                }
            }
        });
        table.on("tool(dataList)", function (obj) {
            const {data: {bannerId}, event} = obj;
            if (event === "delete") {
                layer.confirm("确定删除编号[" + bannerId + "]的数据吗?", {icon: 3}, function (index) {
                    $.ajax({
                        url: "href/delete/" + bannerId,
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
            } else {
                xadmin.open("修改连接", "banner/edit?id=" + bannerId, 500, 600)
            }
        });
        table.on("toolbar(dataList)", function (obj) {
            if (obj.event === "add") {
                xadmin.open("添加连接", "banner/edit", 500, 600)
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

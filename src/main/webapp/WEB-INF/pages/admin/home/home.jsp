<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <base href="${basePath}">
    <title>我的博客后台管理</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
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
    <script>
        // 是否开启刷新记忆tab功能
        const is_remember = false;
    </script>
</head>
<body class="index">
<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href="home">我的博客后台管理</a></div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
    </div>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">${loginInfo.username}</a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a onclick="xadmin.open('个人信息','userinfo/edit?userId=${loginInfo.userId}&type=info',400,400)">个人信息</a>
                </dd>
                <dd>
                    <a onclick="xadmin.open('修改密码','userinfo/password',500,500)">修改密码</a></dd>
                <dd>
                    <a href="javascript:;" id="logout">退出</a></dd>
            </dl>
        </li>
    </ul>
</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <li>
                <a href="javascript:;" onclick="xadmin.add_tab('用户管理','userinfo/list',true)">
                    <i class="iconfont left-nav-li" lay-tips="用户管理">&#xe6b8;</i>
                    <cite>用户管理</cite>
                </a>
            </li>
            <li>
                <a href="javascript:;" onclick="xadmin.add_tab('轮播管理','banner/list',true)">
                    <i class="iconfont left-nav-li" lay-tips="轮播管理">&#xe6a8;</i>
                    <cite>轮播管理</cite>
                </a>
            </li>
            <li>
                <a href="javascript:;" onclick="xadmin.add_tab('连接管理','href/list',true)">
                    <i class="iconfont left-nav-li" lay-tips="连接管理">&#xe811;</i>
                    <cite>连接管理</cite>
                </a>
            </li>
            <li>
                <a href="javascript:;" onclick="xadmin.add_tab('类型管理','category/list',true)">
                    <i class="iconfont left-nav-li" lay-tips="类型管理">&#xe699;</i>
                    <cite>类型管理</cite>
                </a>
            </li>
            <li>
                <a href="javascript:;" onclick="xadmin.add_tab('标签管理','tag/list',true)">
                    <i class="iconfont left-nav-li" lay-tips="标签管理">&#xe6c5;</i>
                    <cite>标签管理</cite>
                </a>
            </li>
            <li>
                <a href="javascript:;" onclick="xadmin.add_tab('博客管理','blog/list',true)">
                    <i class="iconfont left-nav-li" lay-tips="博客管理">&#xe6fb;</i>
                    <cite>博客管理</cite>
                </a>
            </li>
            <li>
                <a href="javascript:;" onclick="xadmin.add_tab('评论管理','comment/list',true)">
                    <i class="iconfont left-nav-li" lay-tips="评论管理">&#xe74e;</i>
                    <cite>评论管理</cite>
                </a>
            </li>
            <li>
                <a href="javascript:;" onclick="xadmin.add_tab('网站管理','website/info',true)">
                    <i class="iconfont left-nav-li" lay-tips="网站管理">&#xe6ae;</i>
                    <cite>网站管理</cite>
                </a>
            </li>
        </ul>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home">
                <i class="layui-icon">&#xe68e;</i>我的桌面
            </li>
        </ul>
        <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
            <dl>
                <dd data-type="this">关闭当前</dd>
                <dd data-type="other">关闭其它</dd>
                <dd data-type="all">关闭全部</dd>
            </dl>
        </div>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='welcome' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<div class="page-content-bg"></div>
<style id="theme_style"></style>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
</body>
<script>
    layui.use(['layer'], function () {
        const layer = layui.layer
        $("#logout").click(function () {
            layer.confirm("确定退出系统吗?", {icon: 3}, function (index) {
                // $.ajax({
                //     url:"logout",
                //     method:"post",
                //     dataType:"json",
                //     success:res=>{
                //         if(res.code === 200){
                //             location.href="/"
                //         }
                //     }
                // })

                $.post("logout", () => {
                    top.location.replace("${basePath}")
                })
                layer.close(index);
            })
        })
    })
</script>
</html>

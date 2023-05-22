<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>博客标签</title>
    <base href="<%=request.getContextPath()%>/">
    <link rel="stylesheet" href="static/x-admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/nav.css">
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/tag.css">
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/x-admin/js/jquery.min.js"></script>
    <script src="static/js/website.js"></script>
</head>
<body>
<div class="main">
    <div class="nav nav-fixed layui-row">
        <div class="title layui-col-md3">
            <div class="logo">
                <img src="static/x-admin/images/q.jpg" alt="">
            </div>
            <div class="web-name">
                <h1>我的博客</h1>
            </div>
        </div>
        <div class="menu layui-col-md-offset3 layui-col-md6">
            <ul>
                <li><a href="front/home">首页</a></li>
                <li><a href="front/category">分类</a></li>
                <li><a class="active" href="front/tag">标签</a></li>
                <li><a href="front/timeline">时光</a></li>
                <li><a href="front/user">信息</a></li>
            </ul>
        </div>
    </div>
    <div class="hot">
        <div class="info category">
        </div>
        <div class="info">
            <div class="list"></div>
            <div class="page" id="laypage"></div>
        </div>
    </div>
</div>
</body>
<script>
    let page = 1;
    let laypage;
    $(function () {
        getTagList();
        getBlogList();
    })

    layui.use(['laypage'], function () {
        laypage = layui.laypage;
    })

    function getTagList() {
        $.ajax({
            url: "front/tag/list",
            method: "get",
            dataType: "json",
            success(res) {
                if (res.code === 200) {
                    let $html = '<div onclick="changeTag(this)" class="tag">全部</div>';
                    for (const category of res.data) {
                        $html += '<div onclick="changeTag(this,' + category.tagId + ')" class="tag tag-success">' + category.name + '</div>';
                    }
                    $(".category").empty().append($html);
                }
            }
        });
    }

    function changeTag(_this, tagId) {
        page = 1
        $('.category .tag').addClass('tag-success');
        $(_this).removeClass("tag-success");
        getBlogList(tagId);
    }


    function getBlogList(tagId) {
        $.ajax({
            url: "front/blog/list/tag",
            method: "get",
            data: {
                page,
                tagId
            },
            dataType: "json",
            success(res) {
                if (res.code === 200) {
                    const blogList = res.data.list;
                    let $html = '';
                    for (let blog of blogList) {
                        $html += '<div class="blog-item"><div class="blog-title"><h2 title="' + blog.title + '"><a href="front/blog/detail/' + blog.blogId + '">' + blog.title + '</a></h2></div><div class="blog-profile"><p>' + blog.profile + '</p></div><div class="blog-info"><div class="blog-category"><div class="tag">' + blog.category.name + '</div></div><div class="blog-time"><p>' + blog.applyTime + '</p></div></div><div class="blog-tag">';
                        const tagList = blog.tagList;
                        for (const tag of tagList) {
                            $html += '<div class="tag tag-success">' + tag.name + '</div>';
                        }
                        $html += '</div></div>';
                    }
                    page = res.data.pageNum
                    laypage.render({
                        elem: "laypage",
                        count: res.data.total,
                        limit: 5,
                        curr: page,
                        jump: function (obj, first) {
                            console.log(obj); //得到当前页，以便向服务端请求对应页的数据。
                            //首次不执行
                            if (!first) {
                                page = obj.curr;
                                getBlogList(categoryId);
                            }
                        }
                    })
                    $(".list").empty().append($html);
                }
            }
        });
    }
</script>
</html>

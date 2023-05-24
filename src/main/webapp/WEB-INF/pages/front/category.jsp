<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>论坛分类</title>
    <base href="<%=request.getContextPath()%>/">
    <link rel="stylesheet" href="static/x-admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/nav.css">
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/category.css">
    <link rel="stylesheet" href="static/css/cursor.css">
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/x-admin/js/jquery.min.js"></script>
    <script src="static/js/website.js"></script>

</head>
<body>
<div class="main">
    <div class="nav nav-relative layui-row">
        <div class="title layui-col-md3">
            <div class="logo" style="cursor: pointer">
                <a id="" href="front/home">
                    <img src="static/x-admin/images/1daw.png" alt="">
                </a>
            </div>
            <div class="web-name">
                <h1>我的博客</h1>
            </div>
        </div>
        <div class="menu layui-col-md-offset3 layui-col-md6">
            <ul>
                <li><a href="front/home">首页</a></li>
                <li><a class="active" href="front/category">分类</a></li>
                <li><a href="front/tag">标签</a></li>
                <li><a href="front/timeline">时光</a></li>
                <li><a href="login">后台</a></li>
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
<script src="static/js/cursor.js"></script>
<script type="text/javascript">
    /* 鼠标特效 */
    var a_idx = 0;
    jQuery(document).ready(function($) {
        $("body").click(function(e) {
            var a = new Array("❤zakozako❤","❤suki❤","❤王天润sama～❤");
            var $i = $("<span></span>").text(a[a_idx]);
            a_idx = (a_idx + 1) % a.length;
            var x = e.pageX,
                y = e.pageY;
            $i.css({
                "z-index": 999,
                "top": y - 20,
                "left": x,
                "position": "absolute",
                "font-weight": "bold",
                "color": "rgb("+~~(255*Math.random())+","+~~(255*Math.random())+","+~~(255*Math.random())+")"
            });
            $("body").append($i);
            $i.animate({
                    "top": y - 180,
                    "opacity": 0
                },
                1500,
                function() {
                    $i.remove();
                });
        });
    });
</script>
<script>
    let page = 1;
    let laypage;
    $(function () {
        getCategoryList();
        getBlogList();
    })

    layui.use(['laypage'], function () {
        laypage = layui.laypage;
    })

    function getCategoryList() {
        $.ajax({
            url: "front/category/list",
            method: "get",
            dataType: "json",
            success(res) {
                if (res.code === 200) {
                    let $html = '<div onclick="changeCategory(this)" class="tag">全部</div>';
                    for (const category of res.data) {
                        $html += '<div onclick="changeCategory(this,' + category.tagId + ')" class="tag tag-success">' + category.name + '</div>';
                    }
                    $(".category").empty().append($html);
                }
            }
        });
    }

    function changeCategory(_this, categoryId) {
        page = 1
        $('.category .tag').addClass('tag-success');
        $(_this).removeClass("tag-success");
        getBlogList(categoryId);
    }


    function getBlogList(categoryId) {
        $.ajax({
            url: "front/blog/list/category",
            method: "get",
            data: {
                page,
                categoryId
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

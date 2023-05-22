<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>博客标签</title>
    <base href="<%=request.getContextPath()%>/">
    <link rel="stylesheet" href="static/x-admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/nav.css">
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/x-admin/js/jquery.min.js"></script>
    <script src="static/js/website.js"></script>
    <style>
        .main .hot {
            width: 960px;
            background-color: white;
            margin: 10px auto;
            padding: 20px 10px;
        }

        .main .hot .timeline-list p {
            height: 30px;
            line-height: 30px;
            margin: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .main .hot .timeline-list p a {
            text-decoration: none;
        }

        .main .hot .timeline-list p a:hover {
            color: #7c8ce4;
        }
    </style>
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
                <li><a href="front/tag">标签</a></li>
                <li><a class="active" href="front/timeline">时光</a></li>
                <li><a href="front/user">信息</a></li>
            </ul>
        </div>
    </div>
    <div style="height: 80px"></div>
    <div class="hot">
        <ul class="layui-timeline">
        </ul>
    </div>
</div>
</body>
<script>
    function getTimeline() {
        $.get('front/timeline/list', function (res) {
            if (res.code === 200) {
                let $html = '';
                const timeline = res.data;
                for (const time of timeline) {
                    const blogList = time.blogList;
                    $html += '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis"></i><div class="layui-timeline-content layui-text"><h3 class="layui-timeline-title">' + time.year + '年(' + time.count + '条)</h3><div class="timeline-list"><div id="time_' + time.year + '">';
                    for (const blog of blogList) {
                        $html += '<p><a title="' + blog.title + '" href="front/blog/detail/' + blog.blogId + '">' + blog.title + '</a></p>';
                    }
                    $html += '</div>';
                    if (time.count > 3) {
                        $html += '<p><a onclick="getBlogByYear(' + time.year + ',this)" style="color: #000" href="javascript:;">加载更多...</a></p>';
                    }
                    $html += '</div></div></li>';
                }
                $(".hot ul").empty().append($html);
            }
        })
    }

    function getBlogByYear(year, _this) {
        const text = $(_this).text();
        const data = {}
        if (text === '收起') {
            $(_this).text('加载更多...');
            data.limit = 3;
        } else {
            $(_this).text("收起");
        }
        $.ajax({
            url: "front/timeline/" + year,
            data,
            method: "get",
            dataType: "json",
            success(res) {
                const blogList = res.data;
                let $html = '';
                for (const blog of blogList) {
                    $html += '<p><a title="' + blog.title + '" href="front/blog/detail/' + blog.blogId + '">' + blog.title + '</a></p>';
                }
                $('#time_' + year).empty().append($html);
            }
        });
    }

    $(function () {
        getTimeline()
    })
</script>
</html>

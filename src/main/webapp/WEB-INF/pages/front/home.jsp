<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>首页-最新博客</title>
    <base href="<%=request.getContextPath()%>/">
    <link rel="stylesheet" href="static/x-admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/nav.css">
    <link rel="stylesheet" href="static/css/home.css">
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/x-admin/js/jquery.min.js"></script>
    <script src="static/js/website.js"></script>
</head>
<body>
<div class="main">
    <div class="nav nav-absolute layui-row">
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
                <li><a class="active" href="front/home">首页</a></li>
                <li><a href="front/category">分类</a></li>
                <li><a href="front/tag">标签</a></li>
                <li><a href="front/timeline">时光</a></li>
                <li><a href="front/user">信息</a></li>
            </ul>
        </div>
    </div>
    <div class="banner">
        <img id="banner" src="" alt="">
    </div>
    <div class="hot">
        <div class="info">
            <div class="list">
                <div class="blog-item">
                    <div class="blog-title">
                        <h2><a href="">
                            我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！</a>
                        </h2>
                    </div>
                    <div class="blog-profile">
                        <p>
                            我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！</p>
                    </div>
                    <div class="blog-info">
                        <div class="blog-category">
                            <div class="tag">技术类</div>
                        </div>
                        <div class="blog-time">
                            <p>2023-05-08 16:50:17</p>
                        </div>
                    </div>
                    <div class="blog-tag">
                        <div class="tag tag-success">HTML</div>
                        <div class="tag tag-success">JSP</div>
                        <div class="tag tag-success">Java</div>
                    </div>
                </div>
                <div class="blog-item">
                    <div class="blog-title">
                        <h2><a href="">
                            我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！</a>
                        </h2>
                    </div>
                    <div class="blog-profile">
                        <p>
                            我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！</p>
                    </div>
                    <div class="blog-info">
                        <div class="blog-category">
                            <div class="tag">技术类</div>
                        </div>
                        <div class="blog-time">
                            <p>2023-05-08 16:50:17</p>
                        </div>
                    </div>
                    <div class="blog-tag">
                        <div class="tag tag-success">HTML</div>
                        <div class="tag tag-success">JSP</div>
                        <div class="tag tag-success">Java</div>
                    </div>
                </div>
                <div class="blog-item">
                    <div class="blog-title">
                        <h2><a href="">
                            我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！我的标题名字非常非常的长！！！</a>
                        </h2>
                    </div>
                    <div class="blog-profile">
                        <p>
                            我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！我是内容很长的摘要~~~！！！</p>
                    </div>
                    <div class="blog-info">
                        <div class="blog-category">
                            <div class="tag">技术类</div>
                        </div>
                        <div class="blog-time">
                            <p>2023-05-08 16:50:17</p>
                        </div>
                    </div>
                    <div class="blog-tag">
                        <div class="tag tag-success">HTML</div>
                        <div class="tag tag-success">JSP</div>
                        <div class="tag tag-success">Java</div>
                    </div>
                </div>
            </div>
            <div class="user">
                <div class="avatar">
                    <div class="avatar-img">
                        <img id="avatar" src="" alt="">
                    </div>
                </div>
                <div class="name">
                    <h4 id="name"></h4>
                </div>
                <div class="profile">
                    <p id="profile"></p>
                </div>
            </div>
        </div>
    </div>
    <div class="back-top" title="回到顶部">
        <i class="layui-icon">&#xe619;</i>
    </div>
</div>
</body>
<script>
    /*初始化轮播图列表*/
    let bannerList = [];

    /*获取轮播图列表*/
    function getBannerList() {
        $.ajax({
            url: "front/banner",
            method: "get",
            dataType: "json",
            async: false,
            success(res) {
                if (res.code === 200) {
                    bannerList = res.data;
                }
            }
        });
    }

    /*更改背景图*/
    function changeBg() {
        /*随机生成要展示的图片下标*/
        let r = Math.floor(Math.random() * bannerList.length);
        /*获取图片地址*/
        let bannerSrc = 'static/upload/' + bannerList[r].src;
        /*重新渲染banner区域*/
        $("#banner").prop("src", bannerSrc);
    }


    /*获取首页博客列表*/
    function getBlogList() {
        $.ajax({
            url: "front/blog/home",
            method: "get",
            dataType: "json",
            success(res) {
                if (res.code === 200) {
                    const blogList = res.data;
                    let $html = '';
                    for (let blog of blogList) {
                        $html += '<div class="blog-item"><div class="blog-title"><h2 title="' + blog.title + '"><a href="front/blog/detail/' + blog.blogId + '">' + blog.title + '</a></h2></div><div class="blog-profile"><p>' + blog.profile + '</p></div><div class="blog-info"><div class="blog-category"><div class="tag">' + blog.category.name + '</div></div><div class="blog-time"><p>' + blog.applyTime + '</p></div></div><div class="blog-tag">';
                        const tagList = blog.tagList;
                        for (const tag of tagList) {
                            $html += '<div class="tag tag-success">' + tag.name + '</div>';
                        }
                        $html += '</div></div>';
                    }
                    $(".list").empty().append($html);
                }
            }
        });
    }

    $(function () {
        /*获取轮播图列表*/
        getBannerList();
        /*设置背景*/
        changeBg();
        /*自动切换背景*/
        setInterval(changeBg, 1000 * 60 * 5);
        /*隐藏回到顶部按钮*/
        $(".back-top").hide();
        /*监听滚动条滚动事件*/
        $(document).scroll(function () {
            /*获取滚动条股东高度*/
            const st = $(document).scrollTop()
            /*获取浏览器可视区域高度*/
            const sw = document.body.clientHeight;
            if (st > sw) {
                $(".nav").removeClass('nav-absolute').addClass('nav-fixed');
                $(".back-top").show();
            } else {
                $(".nav").removeClass('nav-fixed').addClass('nav-absolute');
                $(".back-top").hide();
            }
        });
        /*回到顶部*/
        $(".back-top").click(function () {
            $("html,body").animate({
                "scroll-top": 0
            }, 600)
        });
        /*加载首页博客列表*/
        getBlogList();
    })
</script>
</html>

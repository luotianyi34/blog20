<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>首页-最新咨询</title>
    <base href="<%=request.getContextPath()%>/">
    <link rel="stylesheet" href="static/x-admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/nav.css">
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/cursor.css">
    <link rel="stylesheet" href="static/css/universe.css">
<%--    <link rel="stylesheet" href="static/css/swiper-bundle.min.css">--%>
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/x-admin/js/jquery.min.js"></script>
    <script src="static/js/website.js"></script>
<%--    <script src="static/js/swiper-bundle.min.js"></script>--%>
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
                <h1 class="webName">ACG论坛</h1>
            </div>
        </div>
        <div class="menu layui-col-md-offset3 layui-col-md6">
            <ul>
                <li><a class="active" href="front/home">首页</a></li>
                <li><a href="front/category">分类</a></li>
                <li><a href="front/tag">标签</a></li>
                <li><a href="front/timeline">时光</a></li>
                <li><a href="login">后台</a></li>
            </ul>
        </div>
    </div>
    <div class="contain">
        <div class="banner">
            <a id="click" href="">
                <img id="banner" src="" alt="">
            </a>
        </div>
        <div class="opt">
            <div class="allow left">&lt;</div>
            <div class="allow right">&gt;</div>
            <div class="dots">
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
            </div>
        </div>
    </div>
    <div class="hot">
        <div class="info">
            <div class="list">
                <div class="blog-item">
                    <div class="blog-title">
                        <h2><a href=""> </a>
                        </h2>
                    </div>
                    <div class="blog-profile">
                        <p> </p>
                    </div>
                    <div class="blog-info">
                        <div class="blog-category">
                            <div class="tag"></div>
                        </div>
                        <div class="blog-time">
                            <p></p>
                        </div>
                    </div>
                    <div class="blog-tag">
                        <div class="tag tag-success">L</div>
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
    <iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=250 height=450 style="position:fixed;left:-10px;bottom: 0; z-index: 2" src="//music.163.com/outchain/player?type=0&id=7105278783&auto=1&height=430"></iframe>
    <div class="back-top" title="回到顶部">
        <i class="layui-icon">&#xe619;</i>
    </div>
</div>
</body>
<script src="static/js/cursor.js"></script>
<script>
    /*初始化轮播图列表*/
    let bannerList = [];
    let interval = null;
    window.index = -1;
    const contentBanner = document.querySelector(".contain");

    contentBanner.onmouseleave = function (){
        autoplay();
    }
    contentBanner.onmouseover = function (){
        clearInterval(interval);
    }

    var webName = document.querySelector(".webName")
    var color = ['#f00', '#000', 'yellow', 'blue', 'black', 'gold', 'orange', 'gray', 'pink', 'maroon', 'green', 'rgb(42, 75, 165)','#009393','#bbffbb','#ceceff','purple'];
    setInterval(function(){
        var math = Math.floor(Math.random() * color.length ); // 获取随机数
        webName.style.color = color[math]; //替换字体颜色
    },1000)

    function setBannerMovie() {
        /*获取所有的指示点*/
        const dots = document.getElementsByClassName("dot");

        /*删除所有指示点的样式*/
        for(const d of dots){
            d.classList.remove("active");
        }
        /*设置指定的指示点添加样式*/
        dots[window.index].classList.add("active");
        for (let i =0;i<dots.length;i++) {
            dots[i].onclick = function () {
                for (let j = 0; j < dots.length; j++) {
                    /*清空所有圆点的样式*/
                    dots[j].className = "dot";
                }
                window.index=i;
                /*给指定的按钮绑定样式*/
                dots[window.index].classList.add("active");
                let bannerSrc = 'static/upload/' + bannerList[window.index].src;
                let bannerUrl = bannerList[window.index].url;
                let bannerName = bannerList[window.index].name;
                /*重新渲染banner区域*/
                $("#banner").prop("src", bannerSrc);
                $("#banner").prop("title", bannerName);
                $("#click").prop("href", bannerUrl);

            }
        }
    }

    document.querySelector(".left").onclick = function () {
        console.log("click")
        if (window.index === 0){
            window.index = bannerList.length-1;
        }else {
            window.index--;
        }
        let bannerSrc = 'static/upload/' + bannerList[window.index].src;
        let bannerUrl = bannerList[window.index].url;
        let bannerName = bannerList[window.index].name;
        /*重新渲染banner区域*/
        $("#banner").prop("src", bannerSrc);
        $("#banner").prop("title", bannerName);
        $("#click").prop("href", bannerUrl);
        setBannerMovie()
    }

    document.querySelector(".right").onclick = function () {
        console.log("click")
        if (window.index === bannerList.length-1){
            window.index = 0;
        }else {
            window.index++;
        }
        let bannerSrc = 'static/upload/' + bannerList[window.index].src;
        let bannerUrl = bannerList[window.index].url;
        let bannerName = bannerList[window.index].name;
        /*重新渲染banner区域*/
        $("#banner").prop("src", bannerSrc);
        $("#banner").prop("title", bannerName);
        $("#click").prop("href", bannerUrl);
        setBannerMovie()
    }

    function autoplay(){
        /*自动切换背景*/
        interval = setInterval(changeBg, 3000);
    }

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
                    let bannerlist1 = res.data;
                    let $html = '';
                    for (let banner of bannerlist1){
                        $html += '<div class="dot">'+'</div>';
                    }
                }
            }
        });
    }
    /*更改背景图*/

    function changeBg() {
        /*随机生成要展示的图片下标*/
        // let r = Math.floor(Math.random() * bannerList.length);
        window.index++;
        if (window.index === bannerList.length){
            window.index = 0;
        }
        console.log(window.index);
        /*获取图片地址*/
        let bannerSrc = 'static/upload/' + bannerList[window.index].src;
        let bannerUrl = bannerList[window.index].url;
        let bannerName = bannerList[window.index].name;
        /*重新渲染banner区域*/
        $("#banner").prop("src", bannerSrc);
        $("#banner").prop("title",bannerName);
        $("#click").prop("href", bannerUrl);
        setBannerMovie()
    }


    /*获取首页博客列表*/
    function getBlogList() {
        $.ajax({
            url: "front/blog/home",
            method: "get",
            dataType: "json",
            success(res) {
                if (res.code === 200) {
                    let blogList = res.data;
                    let $html = '';
                    for (let blog of blogList) {
                        $html += '<div class="blog-item"><div class="blog-title"><h2 title="' + blog.title + '"><a href="front/blog/detail/' + blog.blogId + '">' + blog.title + '</a></h2></div><div class="blog-profile"><p>' + blog.profile + '</p></div><div class="blog-info"><div class="blog-category"><div class="tag">' + blog.category.name + '</div></div><div class="blog-time"><p>' + blog.applyTime + '</p></div></div><div class="blog-tag">';
                        const tagList = blog.tagList;
                        for (const tag of tagList) {
                            $html += '<div class="tag tag-success">' + tag.name + '</div>';
                        }
                        $html += '<div class="blog-read"><p>'+"阅读量"+blog.readCount+'</p></div>'+'</div></div>';
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

        autoplay();

        setBannerMovie();

        /*隐藏回到顶部按钮*/
        $(".back-top").hide();
        /*监听滚动条滚动事件*/
        $(document).scroll(function () {
            /*获取滚动条股东高度*/
            const st = $(document).scrollTop()
            /*获取浏览器可视区域高度*/
            const sw = document.body.clientHeight;
            if (st === 0) {
                $(".nav").removeClass('nav-fixed').addClass('nav-relative');
                $(".back-top").hide();
            } else {
                $(".nav").removeClass('nav-relative').addClass('nav-fixed');
                $(".back-top").show();
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
        console.log(bannerList)

    })
</script>
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



</html>

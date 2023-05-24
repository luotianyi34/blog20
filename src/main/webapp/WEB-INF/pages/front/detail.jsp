<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>${blog.title}</title>
    <base href="<%=request.getContextPath()%>/">
    <link rel="stylesheet" href="static/x-admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/nav.css">
    <link rel="stylesheet" href="static/css/home.css">
    <link rel="stylesheet" href="static/css/detail.css">
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
                <li><a href="front/category">分类</a></li>
                <li><a href="front/tag">标签</a></li>
                <li><a href="front/timeline">时光</a></li>
                <li><a href="login">后台</a></li>
            </ul>
        </div>
    </div>
    <div class="hot">
        <div class="info">
            <div class="blog-detail-title">
                <h2>${blog.title}</h2>
            </div>
            <div class="blog-detail-tag">
                <c:forEach var="tag" items="${blog.tagList}">
                    <div class="tag tag-success">${tag.name}</div>
                </c:forEach>
            </div>
            <div class="blog-detail-apply-time">发表时间：${blog.applyTimeStr}</div>
            <div class="blog-detail-category">
                博客类型：
                <div class="tag">${blog.category.name}</div>
            </div>
            <div class="blog-detail-profile">
                <p>${blog.profile}</p>
            </div>
            <div class="blog-detail-content">
                ${blog.content}
            </div>
            <div class="blog-detail-comment">
                <div class="comment-form">
                    <c:if test="${blog.blogComment == 1}">
                        <form id="comment" lay-filter="comment" class="layui-form">
                            <div class="layui-form-item">
                                <label class="layui-form-label" for="name"><span class="x-red">*</span>评论人</label>
                                <div class="layui-input-block">
                                    <input type="text" name="name" id="name" placeholder="请输入评论人姓名"
                                           maxlength="8"
                                           autocomplete="off"
                                           value="" lay-verify="required" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label" for="content"><span
                                        class="x-red">*</span>评论内容</label>
                                <div class="layui-input-block">
            <textarea lay-verify="required" placeholder="请输入内容" id="content" name="content"
                      class="layui-textarea" maxlength="200"></textarea>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label"></label>
                                <div class="layui-input-block">
                                    <button class="layui-btn" type="submit" lay-submit lay-filter="submitBtn">提交
                                    </button>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${blog.blogComment == 2}">
                        <p style="text-align: center;">该文章禁止评论！</p>
                    </c:if>
                </div>
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>评论列表</legend>
                </fieldset>
                <div class="comment-list">

                </div>
                <div class="page" id="laypage"></div>
            </div>
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
    const blogId = "${blog.blogId}";
    let page = 1;
    let laypage;
    let form;


    layui.use(['laypage', 'form'], function () {
        laypage = layui.laypage;
        form = layui.form;
        getCommentList();
        form.on("submit(submitBtn)", function ({field}) {
            field.blogId = blogId;
            $.ajax({
                url: 'front/comment/save',
                data: field,
                method: "post",
                dataType: "json",
                success(res) {
                    if (res.code === 200) {
                        layer.msg("表发完成！", {icon: 6});
                        $("#name").val("");
                        $("#content").val("");
                        getCommentList();
                    } else {
                        layer.msg(res.msg, {icon: 5});
                    }
                }
            })
            return false;
        });
    })

    let title = []
    function getCommentList() {
        $.ajax({
            url: "front/comment/list/" + blogId,
            data: {page},
            method: "get",
            dataType: "json",
            async: false,
            success(res) {
                const commentList = res.data.list;
                let $html = '';
                if (commentList.length > 0) {
                    for (const comment of commentList) {
                        $html += '<blockquote class="layui-elem-quote"><div class="comment-info"><div class="comment-name">评论人：' + comment.name + '</div><div class="comment-time">' + comment.commentTime + '</div></div><div class="comment-content"><p>' + comment.content + '</p></div></blockquote>'
                    }
                } else {
                    $html = '<h4 style="text-align: center">暂无评论！</h4>';
                }

                $(".comment-list").empty().append($html);
                page = res.data.pageNum
                if (res.data.total <= res.data.pageSize) {
                    $("#laypage").hide();
                } else {
                    $("#laypage").show();
                    laypage.render({
                        elem: "laypage",
                        count: res.data.total,
                        limit: 5,
                        curr: page,
                        jump: function (obj, first) {
                            //首次不执行
                            if (!first) {
                                page = obj.curr;
                                getCommentList();
                            }
                        }
                    })
                }

            }
        });
    }

</script>
</html>

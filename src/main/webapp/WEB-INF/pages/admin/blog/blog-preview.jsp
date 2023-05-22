<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>博客详情</title>
    <base href="<%=request.getContextPath()%>/">
    <link rel="stylesheet" href="static/x-admin/lib/layui/css/layui.css">
    <link rel="stylesheet" href="static/css/base.css">
    <link rel="stylesheet" href="static/css/home.css">
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/x-admin/js/jquery.min.js"></script>
    <style>
        .main .hot {
            padding-top: 20px;
        }

        .main .hot .info {
            width: 960px;
            flex-direction: column;
            background-color: #fff;
            padding: 10px;
        }

        .main .hot .info .blog-detail-title h2 {
            font-weight: bold;
            text-align: center;
        }

        .main .hot .info .blog-detail-apply-time {
            text-align: center;
            height: 50px;
            line-height: 50px;
        }

        .main .hot .info .blog-detail-category {
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .main .hot .info .blog-detail-profile {
            padding: 20px 10px;
            background-color: #f8f8f8;
            border: 1px solid #f4f4f4;
            width: 90%;
            margin: 15px auto;
        }

        .main .hot .info .blog-detail-tag {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 15px;
        }

        .main .hot .info .blog-detail-content {
            padding: 20px 10px;
            background-color: #FFF2E2;
            width: 90%;
            margin: 0 auto;
        }

        .main .hot .info .blog-detail-comment {
            padding: 20px 10px;
            width: 90%;
            margin: 0 auto;
        }

        .main .hot .info .blog-detail-comment .comment-list .comment-info {
            display: flex;
            height: 50px;
            align-items: center;
            justify-content: flex-start;
        }

        .main .hot .info .blog-detail-comment .comment-list .comment-info > div {
            width: 240px;
            margin-right: 10px;
        }

        .main .hot .info .blog-detail-comment .page {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px auto;
        }
    </style>
</head>
<body>
<div class="main">
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
        </div>
    </div>
</div>
</body>
</html>

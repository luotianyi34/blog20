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
        .image-group {
            height: 200px;
            width: 200px;
            margin-top: 10px;
            position: relative;
            border: 1px solid gray;
        }

        .image-group .image-div {
            height: 100%;
            width: 100%;
            overflow: hidden;
        }

        .image-group .image-div .image {
            height: 100%;
            width: 100%;
            position: absolute;
        }

        .image-group .image-div .image img {
            display: block;
            height: 100%;
            width: 100%;
        }

        .image-group .image-div .opt {
            height: 100%;
            width: 100%;
            background-color: rgba(0, 0, 0, .3);
            position: absolute;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .image-group .image-div .opt .iconfont {
            font-size: 26px;
            color: white;
            cursor: pointer;
            margin: 10px;
        }
    </style>
</head>
<body>
<div style="width: 90%;margin: 0 30px 0 auto">
    <form id="edit" lay-filter="edit" class="layui-form">
        <input type="hidden" name="bannerId" id="bannerId" value="${banner.bannerId}">
        <div class="layui-form-item">
            <label class="layui-form-label" for="src">图片</label>
            <div class="layui-input-block">
                <input type="hidden" name="src" id="src" value="${banner.src}" class="layui-input">
                <button type="button" id="uploadImage" class="layui-btn">上传图片</button>
                <div class="image-group">
                    <div class="image-div" id="srcImage">
                        <div class="image">
                            <img src="" alt="">
                        </div>
                        <div class="opt">
                            <i class="iconfont delete">&#xe69d;</i>
                            <i class="iconfont show">&#xe6ac;</i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="orderNum">排序值</label>
            <div class="layui-input-block">
                <input type="text" name="orderNum" id="orderNum" placeholder="请输入排序值" autocomplete="off"
                       value="${banner.orderNum}" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="url">导航</label>
            <div class="layui-input-block">
                <input type="text" name="url" id="url" placeholder="请输入导航文章" autocomplete="off"
                       value="${banner.url}" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="name">图片简介</label>
            <div class="layui-input-block">
                <input type="text" name="name" id="name" placeholder="请输入图片简介" autocomplete="off"
                       value="${banner.name}" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label" for="status">状态</label>
            <div class="layui-input-block">
                <select name="status" id="status">
                    <option value="1">可用</option>
                    <option value="2">禁用</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <button class="layui-btn" type="submit" lay-submit lay-filter="submitBtn">提交</button>
            </div>
        </div>
    </form>

</div>
</body>
<script>


    layui.use(["form", "upload"], function () {
        const {form, upload} = layui;
        /*获取状态值*/
        let status = "${banner.status}";

        /*更新修改时下拉框的值*/
        if (status) {
            $("#status").val(status);
            /*在layui中通过js更新select的值后，必须调用form.render去重新渲染*/
            form.render();
            $(".image-div").show();
            let src = $("#src").val();
            $("#srcImage").find("img").prop("src", "static/upload/" + src);
        } else {
            $(".image-div").hide();
        }

        /*控制图片操作层*/
        $(".image-div").mouseenter(function () {
            $(this).find(".opt").show();
        }).mouseleave(function () {
            $(this).find(".opt").hide();
        });
        /*绑定预览图片的事件*/
        $(".show").click(function () {
            let src = $(this).parents(".image-group").find("img").prop("src");
            console.log(src)
            layer.open({
                type: 1,
                title: "图片预览",
                content: '<img style="display: block;height: 100%;width: 100%;" src="' + src + '">',
                area: ["500px", "500px"]
            });
        })
        /*绑定删除图片的事件*/
        $(".delete").click(function () {
            layer.confirm("确定删除该图片吗？", {icon: 3}, index => {
                $(this).parents(".image-group").find(".image-div").hide().find("img").prop("src", "");
                $(this).parents(".layui-input-block").find("input").val("");
                layer.close(index);
            });
        });

        /*渲染图片上传组件*/
        upload.render({
            elem: "#uploadImage",
            url: "upload",
            accept: "images",/*限制类型*/
            acceptMime: "images",/*限制选择框*/
            exts: "png|jpg|jpeg|gif",/*支持的后缀*/
            done(res) {
                if (res.code === 200) {
                    $("#srcImage").show().find("img").prop("src", "static/upload/" + res.data);
                    $("#src").val(res.data)
                } else {
                    layer.error("上传失败！");
                }
            }
        });
        /*监听提交*/
        form.on("submit(submitBtn)", function ({field}) {
            $.ajax({
                url: "banner/update",
                data: field,
                method: "post",
                dataType: "json",
                success(res) {
                    if (res.code === 200) {
                        layer.msg((field.bannerId ? "修改" : "添加") + "成功", {icon: 6}, function () {
                            const index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                            parent.table.reload("dataList")
                        });
                    } else {
                        layer.alert(res.msg, {icon: 5});
                    }
                }
            });
            return false;
        });
    });
</script>
</html>

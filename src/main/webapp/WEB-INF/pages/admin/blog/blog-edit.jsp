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
    <script type="text/javascript" src="static/x-admin/js/xm-select.js"></script>
    <script src="static/x-admin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="static/x-admin/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<div style="width: 90%;margin: 20px 30px 0 auto">
    <form id="edit" lay-filter="edit" class="layui-form">
        <input type="hidden" name="blogId" id="blogId" value="${blog.blogId}">
        <div class="layui-form-item">
            <label class="layui-form-label" for="title"><span class="x-red">*</span>标题</label>
            <div class="layui-input-block">
                <input type="text" name="title" id="title" placeholder="请输入标题" autocomplete="off"
                       value="${blog.title}" lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="profile"><span class="x-red">*</span>摘要</label>
            <div class="layui-input-block">
        <textarea placeholder="请输入摘要" lay-verify="required" id="profile" name="profile"
                  class="layui-textarea">${blog.profile}</textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="categoryId"><span class="x-red">*</span>分类</label>
            <div class="layui-input-block">
                <select name="categoryId" lay-verify="required" id="categoryId">
                    <option value="">[选择分类]</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="tagIds"><span class="x-red">*</span>标签</label>
            <div class="layui-input-block">
                <div id="tagIds"></div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="content"><span class="x-red">*</span>内容</label>
            <div class="layui-input-block">
                <textarea id="content" style="display: none;"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" for="blogComment">评论权限</label>
            <div class="layui-input-block">
                <input type="checkbox" value="1" checked id="blogComment" name="blogComment" lay-skin="switch"
                       lay-text="允许|关闭">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <button class="layui-btn" type="submit" lay-submit lay-filter="applyBtn">直接发布</button>
                <button class="layui-btn layui-btn-warm" type="submit" lay-submit lay-filter="cgBtn">保存草稿</button>
            </div>
        </div>
    </form>

</div>
</body>
<script>
    layui.use(["form", "layedit"], function () {
        const {form, layedit} = layui;
        /*渲染多选下拉框*/
        let xs;
        /*加载标签列表*/
        $.ajax({
            url: "tag/select",
            method: "get",
            async: false,
            dataType: "json",
            success(res) {
                const tagList = res.data.map(item => {
                    return {
                        name: item.name,
                        value: item.tagId,
                        disabled: item.status === 2
                    }
                })
                xs = xmSelect.render({
                    el: "#tagIds",
                    data: tagList,
                    name: 'tagIds',
                    layVerify: 'required',
                    layVerType: 'message',
                    filterable: true
                });
            }
        });

        /*加载分类列表*/
        $.ajax({
            url: "category/select",
            method: "get",
            dataType: "json",
            success(res) {
                let $option = '';
                for (const o of res.data) {
                    let disabled = '';
                    if (o.status === 2) {
                        disabled = 'disabled'
                    }
                    let selected = '';
                    if (o.tagId == '${blog.categoryId}') {
                        selected = "selected"
                    }
                    $option += '<option ' + selected + ' ' + disabled + ' value="' + o.tagId + '">' + o.name + '</option>';
                }
                $("#categoryId").find('option:first').after($option);
                form.render();
            }
        });

        /*配置富文本的上传组件*/
        layedit.set({
            height: 600,
            uploadImage: {
                url: 'edit/upload' //接口url
            }
        });
        /*渲染富文本编辑器*/
        let content = layedit.build('content'); //建立编辑器
        let categoryId = "${blog.categoryId}";
        let blogComment = "${blog.blogComment}";
        /*更新修改时下拉框的值*/
        if (categoryId) {
            /*回显分类*/
            $("#categoryId").val(categoryId);
            $("#blogComment").prop("checked", blogComment === "1");
            /*在layui中通过js更新select的值后，必须调用form.render去重新渲染*/
            form.render();
            /*回显标签*/
            $.ajax({
                url: "blog/tag/list/${blog.blogId}",
                dataType: "json",
                method: "get",
                async: false,
                success(res) {
                    const tagIds = res.data.map(item => {
                        return {
                            value: item.tagId,
                            name: item.name
                        }
                    });
                    xs.setValue(tagIds)
                }
            })
            /*回显富文本编辑器的内容*/
            /*setContent:第三个参数true表示追加内容，false表示覆盖内容*/
            /*需要修改layedit.js源码中asyn函数前的layedit为this*/
            layedit.setContent(content, '${blog.content}', true);
        }
        /*监听提交*/
        form.on("submit(applyBtn)", function ({field}) {
            field.blogStatus = 1;
            field.content = layedit.getContent(content);
            console.log(field.content)
            if (!field.content) {
                layer.msg("内容不能为空", {icon: 5});
                return false;
            }
            submit(field);
            return false;
        });
        form.on("submit(cgBtn)", function ({field}) {
            field.blogStatus = 2;
            field.content = layedit.getContent(content);
            if (!field.content) {
                layer.msg("内容不能为空", {icon: 5});
                return false;
            }
            submit(field);
            return false;
        });
    });

    function submit(data) {
        if (!data.blogComment) {
            data.blogComment = 2
        }
        $.ajax({
            url: "blog/update",
            data,
            method: "post",
            dataType: "json",
            success(res) {
                if (res.code === 200) {
                    layer.msg((data.blogStatus === 1 ? "发表" : "保存") + "成功", {icon: 6}, function () {
                        const index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index); //再执行关闭
                        parent.table.reload("dataList")
                    });
                } else {
                    layer.alert(res.msg, {icon: 5});
                }
            }
        });
    }
</script>
</html>

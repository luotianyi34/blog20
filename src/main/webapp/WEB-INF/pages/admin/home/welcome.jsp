<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="static/x-admin/js/echarts.min.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <blockquote class="layui-elem-quote">欢迎
                        <span class="x-red">${loginInfo.nickname}</span>！当前时间:<b id="time"></b>
                    </blockquote>
                </div>
            </div>
        </div>
        <div class="layui-col-md12">
        </div>
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">统计图标</div>
                <div class="layui-card-body" style="display: flex;justify-content: space-around">
                    <div id="pie" style="height: 400px;width: 600px;"></div>
                    <div id="bar" style="height: 400px;width: 600px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
<script>
    $(function () {
        createChart();
        setTime();
        setInterval(setTime, 1000);
    })

    function setTime() {
        const time = new Date().toLocaleString();
        $("#time").text(time);
    }

    function createChart() {
        // 基于准备好的dom，初始化echarts实例
        const pieChart = echarts.init(document.getElementById('pie'));
        $.get('pie', function (res) {
            if (res.code === 200) {
                const tagList = res.data.tag.map(item => {
                    return {
                        name: item.year,
                        value: item.count
                    }
                })
                const categoryList = res.data.category.map(item => {
                    return {
                        name: item.year,
                        value: item.count
                    }
                })
                pieChart.setOption({
                    title: { /* 标题设置 */
                        text: '文章标签/分类占比图', /* 设置标题内容 */
                        subtext: '实时数据', /* 副标题 */
                        left: 'center'/* 标题组件左侧的偏移量，可以设置具体的数字表示具体的px值，也可以是百分比，或者css支持的位置单词 */
                    },
                    tooltip: { /* 提示框设置 */
                        trigger: 'item', /* 触发方式，可选值为axis(一般用在折线图中,表示在坐标轴上触发)和item(一般用在没有坐标的图例中，表示在数据上触发) */
                        formatter: '{a}<br/>{b}:{c}({d}%)'/* 格式化输出内容模板：a表示图标名称，b表示触发项的名称，c表述该项的数据值，d表示百分比 */
                    },
                    legend: { /* 图例设置 */
                        orient: 'vertical', /* 设置图例的布局方式，vertical表示垂直，horizontal表示水平方向展示 */
                        left: '0'
                    },
                    series: [/* 图标设置 */
                        {
                            name: '文章标签', /* 图标名称，和标题是有区别的 */
                            type: 'pie', /* 设置图标类型，可选值很多 */
                            radius: ["45%", "60%"], /* 设置半径 */
                            data: tagList
                        },
                        {
                            name: '文章分类', /* 图标名称，和标题是有区别的 */
                            type: 'pie', /* 设置图标类型，可选值很多 */
                            radius: [0, "30%"], /* 设置半径 */
                            label: {
                                position: 'inner',
                                fontSize: 14
                            },
                            data: categoryList
                        }
                    ]
                });
            }
        })

        const barChart = echarts.init(document.getElementById("bar"));
        $.get('bar', function (res) {
            if (res.code === 200) {
                const year = res.data.map(item => item.year);
                const count = res.data.map(item => item.count);
                barChart.setOption({
                    title: {
                        text: '博客年度数量总结',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    xAxis: {
                        type: 'category', /* 类目 */
                        data: year
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        type: 'bar',
                        data: count
                    }, {
                        type: 'line',
                        data: count
                    }]
                });
            }
        });

    }
</script>
</html>

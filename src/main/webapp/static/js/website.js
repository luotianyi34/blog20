$(function () {
    /*获取网站基本信息*/
    $.ajax({
        url: "front/website",
        method: "get",
        dataType: "json",
        success(res) {
            if (res.code === 200) {
                $(".logo img").prop("src", "static/upload/" + res.data.logo)
                $(".web-name h1").text(res.data.webName);
                $("#avatar").prop("src", "static/upload/" + res.data.avatar);
                $("#name").text(res.data.name);
                $("#profile").text(res.data.profile);
            }
        }
    })
})

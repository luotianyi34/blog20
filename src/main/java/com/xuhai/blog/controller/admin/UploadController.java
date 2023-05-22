package com.xuhai.blog.controller.admin;

import com.xuhai.blog.util.R;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * @Author PangJunjie
 * @Date 2022/1/18/018
 */
@RestController
public class UploadController {

    @PostMapping("/edit/upload")
    public Map<String, Object> editUpload(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        R r = upload(file, request);
        Map<String, String> map = new HashMap<String, String>();
        map.put("src", request.getContextPath() + "/static/upload/" + r.getData());
        map.put("title", r.getData().toString());
        Map<String, Object> json = new HashMap<String, Object>();
        json.put("code", 0);
        json.put("msg", "");
        json.put("data", map);
        return json;
    }

    @PostMapping("/upload")
    public R upload(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        String filePath = request.getRealPath("/") + "static/upload/";
        /*判断是否上传文件*/
        if (file.isEmpty()) {
            return R.error("未选择文件！");
        }
        /*获取原文件名称*/
        String originalFileName = file.getOriginalFilename();
        /*获取文件格式*/
        String[] of = originalFileName.split("\\.");
        /*获取uuid作为文件名*/
        String uuid = UUID.randomUUID().toString();
        /*拼接文件名*/
        String fileName = uuid + "." + of[of.length - 1];
        /*初始化存放图片的地址*/
        String imagePath = filePath + "/";
        /*初始化文件对象*/
        File tempFile = new File(imagePath);
        /*判断该文件夹是否存在*/
        if (!tempFile.exists()) {
            tempFile.mkdirs();
        }
        /*初始化图片对象*/
        File imageFile = new File(imagePath + fileName);
        /*转换文件流到本地硬盘*/
        try {
            file.transferTo(imageFile);
        } catch (IOException e) {
            e.printStackTrace();
            return R.error("上传失败！");
        }
        return R.data(fileName);
    }
}

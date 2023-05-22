package com.xuhai.blog.controller.front;

import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.service.BlogService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Author PangJunjie
 * @Date 2023/5/8/008
 */
@Controller
@ResponseBody
@RequestMapping("/front/blog")
public class FrontBlogController {

    @Autowired
    private BlogService blogService;

    @GetMapping("/home")
    public R home() {
        return R.data(blogService.getHomeList());
    }

    @GetMapping("/list/category")
    public R blogListCategory(int page, Integer categoryId) {
        Blog blog = new Blog();
        blog.setBlogStatus(1);
        blog.setStatus(1);
        blog.setCategoryId(categoryId);
        return R.data(blogService.getPage(page, 5, blog));
    }

    @GetMapping("/list/tag")
    public R blogListTag(int page, Integer tagId) {
        if (tagId == null) {
            Blog blog = new Blog();
            blog.setBlogStatus(1);
            blog.setStatus(1);
            return R.data(blogService.getPage(page, 5, blog));
        }
        return R.data(blogService.getPageByTagId(page, 5, tagId));
    }

}

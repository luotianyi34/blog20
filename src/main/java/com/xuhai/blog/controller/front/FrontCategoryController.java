package com.xuhai.blog.controller.front;

import com.xuhai.blog.bean.Tag;
import com.xuhai.blog.service.TagService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author PangJunjie
 * @Date 2023/5/9/009
 */
@RequestMapping("/front")
//@Controller
//@ResponseBody
@RestController
public class FrontCategoryController {
    @Autowired
    private TagService tagService;

    @GetMapping("/category/list")
    public R categoryList() {
        Tag tag = new Tag();
        tag.setStatus(1);
        tag.setType(1);
        return R.data(tagService.getList(tag));
    }

    @GetMapping("/tag/list")
    public R tagList() {
        Tag tag = new Tag();
        tag.setStatus(1);
        tag.setType(2);
        return R.data(tagService.getList(tag));
    }
}

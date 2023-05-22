package com.xuhai.blog.controller.admin;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.bean.Tag;
import com.xuhai.blog.service.BlogService;
import com.xuhai.blog.service.TagService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * @Author PangJunjie
 * @Date 2023/5/4/004
 */
@Controller
@RequestMapping("/blog")
public class BlogController {
    @Autowired
    private BlogService blogService;
    @Autowired
    private TagService tagService;

    @GetMapping("/list")
    public String list(Model model) {
        Tag tag = new Tag();
        tag.setType(1);
        model.addAttribute("categoryList", tagService.getList(tag));
        return "admin/blog/blog-list";
    }

    @GetMapping("/page")
    @ResponseBody
    public R page(int page, int limit, Blog blog) {
        PageInfo<Blog> pageInfo = blogService.getPage(page, limit, blog);
        return R.page(pageInfo.getTotal(), pageInfo.getList());
    }

    @GetMapping("/edit")
    public String edit(Integer blogId, Model model) {
        if (blogId != null) {
            model.addAttribute("blog", blogService.getById(blogId));
        }
        return "admin/blog/blog-edit";
    }

    @PostMapping("/update")
    @ResponseBody
    public R update(Blog blog) {
        blogService.saveOrUpdate(blog);
        return R.ok();
    }

    @DeleteMapping("/delete/{blogId}")
    @ResponseBody
    public R delete(@PathVariable Integer blogId) {
        blogService.delete(blogId);
        return R.ok();
    }

    @GetMapping("/tag/list/{blogId}")
    @ResponseBody
    public R tagList(@PathVariable Integer blogId) {
        return R.data(blogService.getTagByBlogId(blogId));
    }

    @GetMapping("/preview")
    public String preview(int blogId, Model model) {
        model.addAttribute("blog", blogService.getById(blogId));
        return "admin/blog/blog-preview";
    }
}

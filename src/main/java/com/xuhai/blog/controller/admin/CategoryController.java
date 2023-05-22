package com.xuhai.blog.controller.admin;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Tag;
import com.xuhai.blog.service.TagService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * @Author PangJunjie
 * @Date 2023/4/28/028
 */
@Controller
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    private TagService tagService;

    @GetMapping("/list")
    public String list() {
        return "admin/category/category-list";
    }

    @GetMapping("/page")
    @ResponseBody
    public R page(int page, int limit, Tag tag) {
        tag.setType(1);
        PageInfo<Tag> pageInfo = tagService.getPage(page, limit, tag);
        return R.page(pageInfo.getTotal(), pageInfo.getList());
    }

    @GetMapping("/edit")
    public String edit(Integer tagId, Model model) {
        if (tagId != null) {
            model.addAttribute("category", tagService.getById(tagId));
        }
        return "admin/category/category-edit";
    }

    @PostMapping("/update")
    @ResponseBody
    public R update(Tag tag) {
        tag.setType(1);
        tagService.saveOrUpdate(tag);
        return R.ok();
    }

    @DeleteMapping("/delete/{tagId}")
    @ResponseBody
    public R delete(@PathVariable Integer tagId) {
        tagService.delete(tagId);
        return R.ok();
    }

    @GetMapping("/select")
    @ResponseBody
    public R select() {
        Tag tag = new Tag();
        tag.setType(1);
        return R.data(tagService.getList(tag));
    }
}

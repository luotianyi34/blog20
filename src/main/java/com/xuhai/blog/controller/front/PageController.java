package com.xuhai.blog.controller.front;

import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author PangJunjie
 * @Date 2023/5/9/009
 */
@Controller
@RequestMapping("/front")
public class PageController {

    @Autowired
    private BlogService blogService;

    @GetMapping("/home")
    public String home() {
        return "front/home";
    }

    @GetMapping("/category")
    public String category() {
        return "front/category";
    }

    @GetMapping("/tag")
    public String tag() {
        return "front/tag";
    }

    @GetMapping("/blog/detail/{bolgId}")
    public String blog(@PathVariable Integer bolgId, Model model) {
        Blog blog = blogService.getById(bolgId);
        if (blog != null) {
            blogService.changeReadCount(bolgId);
            model.addAttribute("blog", blogService.getById(bolgId));
            return "front/detail";
        }
        return "redirect:/";
    }

    @GetMapping("/timeline")
    public String timeline() {
        return "front/timeline";
    }
}

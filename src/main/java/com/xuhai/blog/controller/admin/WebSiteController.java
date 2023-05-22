package com.xuhai.blog.controller.admin;

import com.xuhai.blog.bean.Website;
import com.xuhai.blog.service.WebsiteService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Author PangJunjie
 * @Date 2023/5/4/004
 */
@Controller
@RequestMapping("/website")
public class WebSiteController {

    @Autowired
    private WebsiteService websiteService;

    @GetMapping("/info")
    public String info(Model model) {
        model.addAttribute("website", websiteService.getInfo());
        return "admin/website/website-edit";
    }

    @PostMapping("/update")
    @ResponseBody
    public R update(Website website) {
        websiteService.saveOrUpdate(website);
        return R.ok();
    }
}

package com.xuhai.blog.controller.admin;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Banner;
import com.xuhai.blog.service.BannerService;
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
@RequestMapping("/href")
public class HrefController {
    @Autowired
    private BannerService bannerService;

    @GetMapping("/list")
    public String list() {
        return "admin/href/href-list";
    }

    @GetMapping("/page")
    @ResponseBody
    public R page(int page, int limit, Banner banner) {
        banner.setType(2);
        PageInfo<Banner> pageInfo = bannerService.getPage(page, limit, banner);
        return R.page(pageInfo.getTotal(), pageInfo.getList());
    }

    @GetMapping("/edit")
    public String edit(Integer id, Model model) {
        System.out.println("edit");
        if (id != null) {
            System.out.println(id);
            model.addAttribute("href", bannerService.getById(id));
        }
        System.out.println("return page");
        return "admin/href/href-edit";
    }

    @PostMapping("/update")
    @ResponseBody
    public R update(Banner banner) {
        banner.setType(2);
        bannerService.saveOrUpdate(banner);
        return R.ok();
    }

    @DeleteMapping("/delete/{bannerId}")
    @ResponseBody
    public R delete(@PathVariable Integer bannerId) {
        bannerService.delete(bannerId);
        return R.ok();
    }
}

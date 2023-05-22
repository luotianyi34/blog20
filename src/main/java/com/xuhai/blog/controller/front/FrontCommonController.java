package com.xuhai.blog.controller.front;

import com.xuhai.blog.service.BannerService;
import com.xuhai.blog.service.TimelineService;
import com.xuhai.blog.service.WebsiteService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Author PangJunjie
 * @Date 2023/5/8/008
 */
@Controller
@ResponseBody
@RequestMapping("/front")
public class FrontCommonController {
    @Autowired
    private BannerService bannerService;
    @Autowired
    private WebsiteService websiteService;
    @Autowired
    private TimelineService timelineService;


    @GetMapping("/banner")
    public R banner() {
        return R.data(bannerService.getHomeBanner());
    }

    @GetMapping("/website")
    public R website() {
        return R.data(websiteService.getInfo());
    }

    @GetMapping("/timeline/list")
    public R timeline() {
        return R.data(timelineService.getTimeline());
    }

    @GetMapping("/timeline/{year}")
    public R timeYear(@PathVariable String year, Integer limit) {
        return R.data(timelineService.getBlogByYear(year, limit));
    }
}

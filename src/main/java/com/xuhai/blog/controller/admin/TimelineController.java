package com.xuhai.blog.controller.admin;

import com.xuhai.blog.service.TimelineService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author PangJunjie
 * @Date 2023/5/12/012
 */
@RestController
public class TimelineController {

    @Autowired
    private TimelineService timelineService;

    @GetMapping("/bar")
    public R getYearCount() {
        return R.data(timelineService.getTimeline());
    }

    @GetMapping("/pie")
    public R getCategoryCount() {
        return R.data(timelineService.getCategoryTagCount());
    }

}

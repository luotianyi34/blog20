package com.xuhai.blog.service;

import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.bean.Timeline;

import java.util.List;
import java.util.Map;

/**
 * @Author PangJunjie
 * @Date 2023/5/11/011
 */
public interface TimelineService {
    List<Timeline> getTimeline();

    List<Blog> getBlogByYear(String year, Integer limit);

    Map<String, List<Timeline>> getCategoryTagCount();
}

package com.xuhai.blog.service.impl;

import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.bean.Timeline;
import com.xuhai.blog.mapper.TimelineMapper;
import com.xuhai.blog.service.TimelineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author PangJunjie
 * @Date 2023/5/11/011
 */
@Service
@Transactional
public class TimelineServiceImpl implements TimelineService {

    @Autowired
    private TimelineMapper timelineMapper;

    public List<Timeline> getTimeline() {
        return timelineMapper.getTimeline();
    }

    public List<Blog> getBlogByYear(String year, Integer limit) {
        return timelineMapper.getBlogByYear(year, limit);
    }

    public Map<String, List<Timeline>> getCategoryTagCount() {
        Map<String, List<Timeline>> map = new HashMap<String, List<Timeline>>();
        List<Timeline> categoryList = timelineMapper.getCategoryCount();
        List<Timeline> tagList = timelineMapper.getTagCount();
        map.put("category", categoryList);
        map.put("tag", tagList);
        return map;
    }

}

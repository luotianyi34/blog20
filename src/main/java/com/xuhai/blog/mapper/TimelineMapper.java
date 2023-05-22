package com.xuhai.blog.mapper;

import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.bean.Timeline;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/5/11/011
 */
public interface TimelineMapper {
    List<Timeline> getTimeline();

    List<Timeline> getTagCount();

    List<Timeline> getCategoryCount();

    List<Blog> getBlogByYear(@Param("year") String year, @Param("limit") Integer limit);
}

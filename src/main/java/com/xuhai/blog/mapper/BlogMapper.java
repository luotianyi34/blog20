package com.xuhai.blog.mapper;

import com.xuhai.blog.bean.Blog;

import java.util.List;

public interface BlogMapper {
    int deleteByPrimaryKey(Integer blogId);

    int insert(Blog record);

    int insertSelective(Blog record);

    Blog selectByPrimaryKey(Integer blogId);

    int updateByPrimaryKeySelective(Blog record);

    int updateByPrimaryKey(Blog record);

    List<Blog> getAll(Blog blog);

    List<Blog> getHomeList();

    int changeReadCount(Integer blogId);
}

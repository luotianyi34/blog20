package com.xuhai.blog.mapper;

import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.bean.BolgTag;
import com.xuhai.blog.bean.Tag;

import java.util.List;

public interface BolgTagMapper {
    int deleteByPrimaryKey(Integer blogTagId);

    int insert(BolgTag record);

    int insertSelective(BolgTag record);

    BolgTag selectByPrimaryKey(Integer blogTagId);

    int updateByPrimaryKeySelective(BolgTag record);

    int updateByPrimaryKey(BolgTag record);

    List<Tag> getTagByBlogId(Integer blogId);

    List<Blog> getBlogByTageId(Integer tagId);

    int deleteByBlogId(Integer blogId);

    int batchInsert(List<BolgTag> list);
}

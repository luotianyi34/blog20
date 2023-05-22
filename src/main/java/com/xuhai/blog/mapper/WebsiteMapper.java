package com.xuhai.blog.mapper;

import com.xuhai.blog.bean.Website;

public interface WebsiteMapper {
    int deleteByPrimaryKey(Integer websiteId);

    int insert(Website record);

    int insertSelective(Website record);

    Website selectByPrimaryKey(Integer websiteId);

    int updateByPrimaryKeySelective(Website record);

    int updateByPrimaryKey(Website record);
}
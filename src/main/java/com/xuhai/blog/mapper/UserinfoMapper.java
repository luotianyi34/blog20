package com.xuhai.blog.mapper;

import com.xuhai.blog.bean.Userinfo;

import java.util.List;

public interface UserinfoMapper {
    int deleteByPrimaryKey(Integer userId);

    int insert(Userinfo record);

    int insertSelective(Userinfo record);

    Userinfo selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(Userinfo record);

    int updateByPrimaryKey(Userinfo record);

    Userinfo login(Userinfo userinfo);

    List<Userinfo> getAll(Userinfo userinfo);
}

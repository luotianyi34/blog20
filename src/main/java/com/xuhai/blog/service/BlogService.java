package com.xuhai.blog.service;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.bean.Tag;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/5/4/004
 */
public interface BlogService {
    PageInfo<Blog> getPage(int page, int limit, Blog blog);

    Blog getById(int blogId);

    void saveOrUpdate(Blog blog);

    void delete(int blogId);

    List<Tag> getTagByBlogId(int blogId);

    List<Blog> getHomeList();

    PageInfo<Blog> getPageByTagId(int page, int limit, Integer tagId);

    void changeReadCount(int blogId);

}

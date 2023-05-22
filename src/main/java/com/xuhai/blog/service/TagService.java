package com.xuhai.blog.service;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Tag;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/4/28/028
 */
public interface TagService {
    PageInfo<Tag> getPage(int page, int limit, Tag tag);

    Tag getById(int tagId);

    void saveOrUpdate(Tag tag);

    void delete(int tagId);

    List<Tag> getList(Tag tag);

}

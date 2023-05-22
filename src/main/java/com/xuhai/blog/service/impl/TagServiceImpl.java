package com.xuhai.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Tag;
import com.xuhai.blog.mapper.TagMapper;
import com.xuhai.blog.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/4/28/028
 */
@Service
@Transactional
public class TagServiceImpl implements TagService {
    @Autowired
    private TagMapper tagMapper;

    public PageInfo<Tag> getPage(int page, int limit, Tag tag) {
        PageHelper.startPage(page, limit);
        List<Tag> list = tagMapper.getAll(tag);
        return new PageInfo<Tag>(list);
    }

    public Tag getById(int tagId) {
        return tagMapper.selectByPrimaryKey(tagId);
    }

    public void saveOrUpdate(Tag tag) {
        if (tag.getTagId() == null) {
            tagMapper.insertSelective(tag);
        } else {
            tagMapper.updateByPrimaryKeySelective(tag);
        }
    }

    public void delete(int tagId) {
        //删除前需要关联博客查询
        tagMapper.deleteByPrimaryKey(tagId);
    }

    public List<Tag> getList(Tag tag) {
        return tagMapper.getAll(tag);
    }
}

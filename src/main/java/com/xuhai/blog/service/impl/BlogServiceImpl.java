package com.xuhai.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Blog;
import com.xuhai.blog.bean.BolgTag;
import com.xuhai.blog.bean.Tag;
import com.xuhai.blog.mapper.BlogMapper;
import com.xuhai.blog.mapper.BolgTagMapper;
import com.xuhai.blog.mapper.CommentMapper;
import com.xuhai.blog.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/5/4/004
 */
@Service
@Transactional
public class BlogServiceImpl implements BlogService {
    @Autowired
    private BlogMapper blogMapper;
    @Autowired
    private BolgTagMapper bolgTagMapper;
    @Autowired
    private CommentMapper commentMapper;

    public PageInfo<Blog> getPage(int page, int limit, Blog blog) {
        PageHelper.startPage(page, limit);
        List<Blog> list = blogMapper.getAll(blog);
        return new PageInfo<Blog>(list);
    }

    public Blog getById(int blogId) {
        return blogMapper.selectByPrimaryKey(blogId);
    }

    public void saveOrUpdate(Blog blog) {
        if (blog.getBlogId() == null) {
            blog.setStatus(1);
            blog.setApplyTime(new Date());
            blog.setCreateTime(new Date());
            blogMapper.insertSelective(blog);
        } else {
            if (blog.getBlogStatus() == 1) {
                blog.setApplyTime(new Date());
            }
            blogMapper.updateByPrimaryKeySelective(blog);
            bolgTagMapper.deleteByBlogId(blog.getBlogId());
        }

        if (blog.getTagIds() != null && blog.getTagIds().length > 0) {
            List<BolgTag> tagList = new ArrayList<BolgTag>();
            for (Integer tagId : blog.getTagIds()) {
                BolgTag bolgTag = new BolgTag();
                bolgTag.setBlogId(blog.getBlogId());
                bolgTag.setTagId(tagId);
                tagList.add(bolgTag);
            }
            bolgTagMapper.batchInsert(tagList);
        }
    }

    public void delete(int blogId) {
        blogMapper.deleteByPrimaryKey(blogId);
        bolgTagMapper.deleteByBlogId(blogId);
        commentMapper.deleteCommentByBlogId(blogId);
    }

    public List<Tag> getTagByBlogId(int blogId) {
        return bolgTagMapper.getTagByBlogId(blogId);
    }

    public List<Blog> getHomeList() {
        return blogMapper.getHomeList();
    }

    public PageInfo<Blog> getPageByTagId(int page, int limit, Integer tagId) {
        PageHelper.startPage(page, limit);
        List<Blog> list = bolgTagMapper.getBlogByTageId(tagId);
        return new PageInfo<Blog>(list);
    }

    public void changeReadCount(int blogId) {
        blogMapper.changeReadCount(blogId);
    }
}

package com.xuhai.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Comment;
import com.xuhai.blog.mapper.CommentMapper;
import com.xuhai.blog.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/5/10/010
 */
@Service
@Transactional
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentMapper commentMapper;

    public PageInfo<Comment> getPage(int page, int limit, Comment comment) {
        PageHelper.startPage(page, limit);
        List<Comment> list = commentMapper.getAll(comment);
        return new PageInfo<Comment>(list);
    }

    public void saveOrUpdate(Comment comment) {
        if (comment.getCommentId() == null) {
            comment.setCommentTime(new Date());
            comment.setStatus(1);
            commentMapper.insertSelective(comment);
        } else {
            commentMapper.updateByPrimaryKeySelective(comment);
        }

    }

    public void delete(int commentId) {
        commentMapper.deleteByPrimaryKey(commentId);
    }
}

package com.xuhai.blog.mapper;

import com.xuhai.blog.bean.Comment;

import java.util.List;

public interface CommentMapper {
    int deleteByPrimaryKey(Integer commentId);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectByPrimaryKey(Integer commentId);

    int updateByPrimaryKeySelective(Comment record);

    int updateByPrimaryKey(Comment record);

    List<Comment> getAll(Comment comment);

    List<Comment> getCommentByBlogId(Integer blogId);

    int deleteCommentByBlogId(Integer blogId);
}

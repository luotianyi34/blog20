package com.xuhai.blog.service;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Comment;

/**
 * @Author PangJunjie
 * @Date 2023/5/10/010
 */
public interface CommentService {
    PageInfo<Comment> getPage(int page, int limit, Comment comment);

    void saveOrUpdate(Comment comment);

    void delete(int commentId);
}

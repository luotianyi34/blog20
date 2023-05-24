package com.xuhai.blog.controller.front;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Comment;
import com.xuhai.blog.service.CommentService;
import com.xuhai.blog.util.R;
import com.xuhai.blog.util.sensitive.SensitiveWordFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/5/10/010
 */
@RequestMapping("/front/comment")
@RestController
public class FrontCommentController {
    @Autowired
    private CommentService commentService;

    @GetMapping("/list/{blogId}")
    public R list(int page, @PathVariable Integer blogId) {
        Comment comment = new Comment();
        comment.setStatus(1);
        comment.setBlogId(blogId);
        PageInfo<Comment> pageInfo = commentService.getPage(page, 5, comment);
        List<Comment> list = pageInfo.getList();
        if (list != null && list.size() > 0) {
            /*加载关键字列表*/
            SensitiveWordFilter.loadWordFromFile("C:\\Users\\df\\IdeaProjects\\blog\\src\\main\\resources\\WorldList.txt");
            for (Comment c : list) {
                c.setContent(SensitiveWordFilter.Filter(c.getContent()));
            }
            pageInfo.setList(list);
        }
        return R.data(pageInfo);
    }

    @PostMapping("/save")
    public R save(Comment comment) {
        commentService.saveOrUpdate(comment);
        return R.ok();
    }
}

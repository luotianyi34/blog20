package com.xuhai.blog.controller.admin;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Comment;
import com.xuhai.blog.service.CommentService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * @Author PangJunjie
 * @Date 2023/5/11/011
 */
@RequestMapping("/comment")
@Controller
public class CommentController {

    @Autowired
    private CommentService commentService;

    @GetMapping("/list")
    public String list(Integer blogId, Model model) {
        if (blogId != null) {
            model.addAttribute("blogId", blogId);
        }
        return "admin/comment/comment-list";
    }

    @GetMapping("/page")
    @ResponseBody
    public R page(int page, int limit, Comment comment) {
        PageInfo<Comment> pageInfo = commentService.getPage(page, limit, comment);
        return R.page(pageInfo.getTotal(), pageInfo.getList());
    }

    @DeleteMapping("/delete/{commentId}")
    @ResponseBody
    public R delete(@PathVariable Integer commentId) {
        commentService.delete(commentId);
        return R.ok();
    }

    @PostMapping("/status")
    @ResponseBody
    public R status(Comment comment) {
        commentService.saveOrUpdate(comment);
        return R.ok();
    }
}

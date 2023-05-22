package com.xuhai.blog.controller.admin;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Userinfo;
import com.xuhai.blog.service.UserinfoService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * @Author PangJunjie
 * @Date 2023/4/27/027
 */
@Controller
@RequestMapping("/userinfo")
public class UserController extends BaseController {
    @Autowired
    private UserinfoService userinfoService;

    @GetMapping("/list")
    public String list() {
        return "admin/userinfo/userinfo-list";
    }

    @GetMapping("/page")
    @ResponseBody
    public R getPage(int page, int limit, Userinfo userinfo) {
        PageInfo<Userinfo> pageInfo = userinfoService.getPage(page, limit, userinfo);
        return R.page(pageInfo.getTotal(), pageInfo.getList());
    }

    @GetMapping("/edit")
    public String edit(Integer userId, String type, Model model) {
        if (userId != null) {
            model.addAttribute("userinfo", userinfoService.getById(userId));
        }
        model.addAttribute("type", type);
        return "admin/userinfo/userinfo-edit";
    }

    @PostMapping(value = {"/update", "/pwd", "/status"})
    @ResponseBody
    public R update(Userinfo userinfo) {
        userinfoService.saveOrUpdate(userinfo);
        return R.ok();
    }

    @DeleteMapping("/delete/{userId}")
    @ResponseBody
    public R delete(@PathVariable Integer userId, HttpSession session) {
        if (userId.equals(getLoginId(session))) {
            return R.error("当前登录用户不得删除！");
        }
        if (userId == 1) {
            return R.error("管理员不能删除");
        }
        userinfoService.delete(userId);
        return R.ok();
    }

    @GetMapping("/check/username")
    @ResponseBody
    public R checkUsername(Userinfo userinfo) {
        return userinfoService.checkUsername(userinfo) ? R.ok() : R.error();
    }

    @GetMapping("/check/password")
    @ResponseBody
    public R checkPassword(Userinfo userinfo) {
        return userinfoService.checkOldPassword(userinfo) ? R.ok() : R.error();
    }

    @GetMapping("/password")
    public String password() {
        return "admin/userinfo/userinfo-password";
    }
}

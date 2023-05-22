package com.xuhai.blog.controller.admin;

import com.xuhai.blog.bean.Userinfo;
import com.xuhai.blog.service.UserinfoService;
import com.xuhai.blog.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * @Author PangJunjie
 * @Date 2023/4/27/027
 */
@Controller
public class LoginController {
    @Autowired
    private UserinfoService userinfoService;

    @GetMapping("/login")
    public String loginPage() {
        return "admin/login";
    }

    @PostMapping("/login")
    @ResponseBody
    public R login(Userinfo userinfo, HttpSession session) {
        userinfo = userinfoService.login(userinfo);
        if (userinfo != null) {
            if (userinfo.getStatus() == 1) {
                session.setAttribute("loginInfo", userinfo);
                return R.ok();
            } else {
                return R.error("该用户已被封禁");
            }
        } else {
            return R.error("用户名或密码不正确");
        }
    }

    @GetMapping("/home")
    public String home() {
        return "admin/home/home";
    }

    @GetMapping("/welcome")
    public String welcome() {
        return "admin/home/welcome";
    }

    @GetMapping("/nologin")
    public String nologin() {
        return "admin/nologin";
    }

    @PostMapping("/logout")
    @ResponseBody
    public R logout(HttpSession session) {
        session.removeAttribute("loginInfo");
        return R.ok();
    }
}

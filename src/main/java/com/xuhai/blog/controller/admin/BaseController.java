package com.xuhai.blog.controller.admin;

import com.xuhai.blog.bean.Userinfo;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpSession;

/**
 * @Author PangJunjie
 * @Date 2023/4/27/027
 */
@Controller
public abstract class BaseController {
    public Integer getLoginId(HttpSession session) {
        return getLoginInfo(session).getUserId();
    }

    public Userinfo getLoginInfo(HttpSession session) {
        return (Userinfo) session.getAttribute("loginInfo");
    }
}

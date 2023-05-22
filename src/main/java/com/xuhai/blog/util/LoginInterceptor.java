package com.xuhai.blog.util;

import com.alibaba.fastjson.JSON;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author PangJunjie
 * @Date 2023/4/27/027
 */
public class LoginInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String basePath = request.getContextPath() + "/";
        request.setAttribute("basePath", basePath);
        Object loginInfo = request.getSession().getAttribute("loginInfo");
        if (loginInfo != null) {
            return true;
        } else {
            String xRequestedWith = request.getHeader("X-Requested-With");
            if (xRequestedWith != null && xRequestedWith.contains("XMLHttpRequest")) {
                response.setContentType("application/json;charset=utf-8");
                response.getWriter().println(JSON.toJSON(R.error(401, "未登录！")));
            } else {
                response.sendRedirect(basePath + "nologin");
            }
        }
        return false;
    }
}

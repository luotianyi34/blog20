package com.xuhai.blog.service;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Userinfo;

/**
 * @Author PangJunjie
 * @Date 2023/4/27/027
 */
public interface UserinfoService {
    Userinfo login(Userinfo userinfo);

    PageInfo<Userinfo> getPage(int page, int limit, Userinfo userinfo);

    Userinfo getById(int id);

    void saveOrUpdate(Userinfo userinfo);

    void delete(int id);

    boolean checkUsername(Userinfo userinfo);

    boolean checkOldPassword(Userinfo userinfo);
}

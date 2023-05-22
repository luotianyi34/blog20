package com.xuhai.blog.service;

import com.xuhai.blog.bean.Website;

/**
 * @Author PangJunjie
 * @Date 2023/5/4/004
 */
public interface WebsiteService {
    Website getInfo();

    void saveOrUpdate(Website website);


}

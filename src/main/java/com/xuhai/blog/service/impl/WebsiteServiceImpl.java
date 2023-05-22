package com.xuhai.blog.service.impl;

import com.xuhai.blog.bean.Website;
import com.xuhai.blog.mapper.WebsiteMapper;
import com.xuhai.blog.service.WebsiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Author PangJunjie
 * @Date 2023/5/4/004
 */
@Service
@Transactional
public class WebsiteServiceImpl implements WebsiteService {

    @Autowired
    private WebsiteMapper websiteMapper;

    public Website getInfo() {
        return websiteMapper.selectByPrimaryKey(1);
    }

    public void saveOrUpdate(Website website) {
        if (website.getWebsiteId() == null) {
            websiteMapper.insertSelective(website);
        } else {
            websiteMapper.updateByPrimaryKeySelective(website);
        }
    }
}

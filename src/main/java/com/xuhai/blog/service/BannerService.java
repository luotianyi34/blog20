package com.xuhai.blog.service;

import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Banner;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/4/28/028
 */
public interface BannerService {
    PageInfo<Banner> getPage(int page, int limit, Banner banner);

    Banner getById(int bannerId);

    void saveOrUpdate(Banner banner);

    void delete(int bannerId);

    List<Banner> getHomeBanner();
}

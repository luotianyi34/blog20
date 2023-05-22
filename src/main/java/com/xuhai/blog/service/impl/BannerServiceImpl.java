package com.xuhai.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Banner;
import com.xuhai.blog.mapper.BannerMapper;
import com.xuhai.blog.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/4/28/028
 */
@Service
@Transactional
public class BannerServiceImpl implements BannerService {
    @Autowired
    private BannerMapper bannerMapper;

    public PageInfo<Banner> getPage(int page, int limit, Banner banner) {
        PageHelper.startPage(page, limit);
        List<Banner> bannerList = bannerMapper.getAll(banner);
        return new PageInfo<Banner>(bannerList);
    }

    public Banner getById(int bannerId) {
        return bannerMapper.selectByPrimaryKey(bannerId);
    }

    public void saveOrUpdate(Banner banner) {
        if (banner.getBannerId() != null) {
            bannerMapper.updateByPrimaryKeySelective(banner);
        } else {
            bannerMapper.insertSelective(banner);
        }
    }

    public void delete(int bannerId) {
        bannerMapper.deleteByPrimaryKey(bannerId);
    }

    public List<Banner> getHomeBanner() {
        Banner banner = new Banner();
        banner.setStatus(1);
        banner.setType(1);
        return bannerMapper.getAll(banner);
    }
}

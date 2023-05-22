package com.xuhai.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xuhai.blog.bean.Userinfo;
import com.xuhai.blog.mapper.UserinfoMapper;
import com.xuhai.blog.service.UserinfoService;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/4/27/027
 */
@Service
@Transactional
public class UserinfoServiceImpl implements UserinfoService {
    @Autowired
    private UserinfoMapper userinfoMapper;

    public Userinfo login(Userinfo userinfo) {
        userinfo.setPassword(DigestUtils.md5Hex(userinfo.getPassword()));
        return userinfoMapper.login(userinfo);
    }

    public PageInfo<Userinfo> getPage(int page, int limit, Userinfo userinfo) {
        PageHelper.startPage(page, limit);
        List<Userinfo> list = userinfoMapper.getAll(userinfo);
        return new PageInfo<Userinfo>(list);
    }

    public Userinfo getById(int id) {
        return userinfoMapper.selectByPrimaryKey(id);
    }

    public void saveOrUpdate(Userinfo userinfo) {
        if (userinfo.getUserId() == null) {
            userinfo.setPassword(DigestUtils.md5Hex("666888"));
            userinfoMapper.insertSelective(userinfo);
        } else {
            if (StringUtils.isNotEmpty(userinfo.getPassword())) {
                userinfo.setPassword(DigestUtils.md5Hex(userinfo.getPassword()));
            }
            userinfoMapper.updateByPrimaryKeySelective(userinfo);
        }

    }

    public void delete(int id) {
        userinfoMapper.deleteByPrimaryKey(id);
    }

    public boolean checkUsername(Userinfo userinfo) {
        List<Userinfo> list = userinfoMapper.getAll(userinfo);
        return list.size() == 0;
    }

    public boolean checkOldPassword(Userinfo userinfo) {
        Userinfo user = getById(userinfo.getUserId());
        return DigestUtils.md5Hex(userinfo.getPassword()).equals(user.getPassword());
    }
}

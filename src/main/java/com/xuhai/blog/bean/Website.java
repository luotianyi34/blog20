package com.xuhai.blog.bean;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * website
 * @author 
 */
@Data
public class Website implements Serializable {
    /**
     * 主键自增
     */
    private Integer websiteId;

    /**
     * 网站名称
     */
    private String webName;

    /**
     * 站长名称
     */
    private String name;

    /**
     * 网站介绍
     */
    private String webProfile;

    /**
     * 站长介绍
     */
    private String profile;

    /**
     * 网站logo
     */
    private String logo;

    /**
     * 站长头像
     */
    private String avatar;

    /**
     * 用户编号
     */
    private Integer userinfoId;

    /**
     * 状态1可用2禁用
     */
    private Integer status;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 创建人编号
     */
    private Integer createAdmin;

    /**
     * 最后一次修改时间
     */
    private Date updateTime;

    /**
     * 用户编号
     */
    private Integer updateAdmin;

    private static final long serialVersionUID = 1L;
}
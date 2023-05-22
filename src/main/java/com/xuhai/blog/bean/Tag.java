package com.xuhai.blog.bean;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * tag
 *
 * @author
 */
@Data
public class Tag implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 主键自增
     */
    private Integer tagId;
    /**
     * 名称
     */
    private String name;
    /**
     * 标记，用来设置颜色
     */
    private String info;
    /**
     * 简介
     */
    private String profile;
    /**
     * 标记类型，1为分类2为标签
     */
    private Integer type;
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
     * 最后一次修改人
     */
    private Integer updateAdmin;
    /**
     * 用户编号
     */
    private Integer userinfoId;
    
}

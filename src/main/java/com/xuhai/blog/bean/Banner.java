package com.xuhai.blog.bean;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * banner
 * @author 
 */
@Data
public class Banner implements Serializable {
    /**
     * 主键自增
     */
    private Integer bannerId;

    /**
     * 名称
     */
    private String name;

    /**
     * 图片地址
     */
    private String src;

    /**
     * 跳转地址
     */
    private String url;

    /**
     * 跳转类型
     */
    private String target;

    /**
     * 排序值
     */
    private Integer orderNum;

    /**
     * 类型1轮播2外链
     */
    private Integer type;

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
     * 最后一次修改人
     */
    private Integer updateAdmin;

    private static final long serialVersionUID = 1L;
}
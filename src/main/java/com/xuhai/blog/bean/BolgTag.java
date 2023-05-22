package com.xuhai.blog.bean;

import java.io.Serializable;
import lombok.Data;

/**
 * bolg_tag
 * @author 
 */
@Data
public class BolgTag implements Serializable {
    /**
     * 主键自增
     */
    private Integer blogTagId;

    /**
     * 博客编号
     */
    private Integer blogId;

    /**
     * 标签编号
     */
    private Integer tagId;

    private static final long serialVersionUID = 1L;
}
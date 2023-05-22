package com.xuhai.blog.bean;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * comment
 *
 * @author
 */
@Data
public class Comment implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 主键自增
     */
    private Integer commentId;
    /**
     * 评论人
     */
    private String name;
    /**
     * 评论内容
     */
    private String content;
    /**
     * 评论时间
     */
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date commentTime;
    /**
     * 文章编号
     */
    private Integer blogId;
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

    private String title;
}

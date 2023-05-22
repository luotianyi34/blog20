package com.xuhai.blog.bean;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * blog
 *
 * @author
 */
@Data
public class Blog implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 主键自增
     */
    private Integer blogId;
    /**
     * 标题
     */
    private String title;
    /**
     * 摘要
     */
    private String profile;
    /**
     * 分类编号
     */
    private Integer categoryId;
    /**
     * 内容
     */
    private String content;
    /**
     * 发布时间
     */
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date applyTime;
    /**
     * 博客状态1发表2草稿
     */
    private Integer blogStatus;
    /**
     * 评论状态1可评论2不允许评论
     */
    private Integer blogComment;
    /**
     * 阅读量
     */
    private Integer readCount;
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
    private List<Tag> tagList;
    private List<Comment> commentList;
    private Tag category;
    private String[] timeRange;
    private Integer[] tagIds;

    private String applyTimeStr;

    public String getApplyTimeStr() {
        if (this.applyTime != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return sdf.format(this.applyTime);
        }
        return applyTimeStr;
    }
}

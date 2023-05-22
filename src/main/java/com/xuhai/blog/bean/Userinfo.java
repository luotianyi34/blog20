package com.xuhai.blog.bean;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * userinfo
 * @author 
 */
@Data
public class Userinfo implements Serializable {
    /**
     * 主键自增
     */
    private Integer userId;

    /**
     * 用户名
     */
    private String username;

    /**
     * 密码MD5加密
     */
    private String password;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 手机号
     */
    private String phone;

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
package com.xuhai.blog.util;

import lombok.Data;

/**
 * @Author PangJunjie
 * @Date 2023/4/25/025
 */
@Data
public class R {
    private static final Integer SUCCESS_CODE = 200;
    private static final Integer ERROR_CODE = 500;
    private Integer code;
    private String msg;
    private Object data;
    private Long count;

    public R(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public static R ok() {
        return ok("success");
    }

    public static R ok(String msg) {
        return new R(SUCCESS_CODE, msg);
    }

    public static R error(String msg) {
        return error(ERROR_CODE, msg);
    }

    public static R error(Integer code, String msg) {
        return new R(code, msg);
    }

    public static R error(Integer code) {
        return error(code, "error");
    }

    public static R error() {
        return error(ERROR_CODE, "error");
    }

    public static R page(Long count, Object data) {
        return page(0, "暂无数据", count, data);
    }

    public static R page(Integer code, String msg, Long count, Object data) {
        R r = new R(code, msg);
        r.setCount(count);
        r.setData(data);
        return r;
    }

    public static R data(Object data) {
        R r = new R(200, "success");
        r.setData(data);
        return r;
    }
}

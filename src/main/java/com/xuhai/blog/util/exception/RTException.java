package com.xuhai.blog.util.exception;

import lombok.Data;

/**
 * @Author PangJunjie
 * @Date 2023/4/26/026
 */
@Data
public class RTException extends RuntimeException {
    private String msg;

    public RTException(String msg) {
        super(msg);
        this.msg = msg;
    }

}

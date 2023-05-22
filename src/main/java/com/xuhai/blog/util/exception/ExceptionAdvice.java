package com.xuhai.blog.util.exception;

import com.xuhai.blog.util.R;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Author PangJunjie
 * @Date 2023/4/26/026
 */
@ControllerAdvice
@ResponseBody
public class ExceptionAdvice {

    private Logger logger = Logger.getLogger(ExceptionAdvice.class);

    @ExceptionHandler(RTException.class)
    public R handleRTException(RTException e) {
        logger.error(e.getMessage());
        return R.error(e.getMsg());
    }

    @ExceptionHandler(IllegalStateException.class)
    public R handleIllegalStateException() {
        logger.error("基本数据类型类型参数为接收到数据");
        return R.error("page和limit不能为空！");
    }

    @ExceptionHandler(Exception.class)
    public R handleException(Exception e) {
        logger.error(e.getMessage());
        return R.error(e.getMessage());
    }
}

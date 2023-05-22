package com.xuhai.blog.bean;


import lombok.Data;

import java.util.List;

/**
 * @Author PangJunjie
 * @Date 2023/5/11/011
 */
@Data
public class Timeline {
    private String year;
    private Integer count;
    private List<Blog> blogList;
}

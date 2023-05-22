package com.xuhai.blog.util.sensitive;

public class Main {
    public static void main(String[] args) throws Exception {
        SensitiveWordFilter.loadWordFromFile("D:\\记录\\OneDrive\\学校资料\\徐海学院\\2022-2023-2\\04.JavaEE框架开发-48课时-嵌入式20-1\\代码\\blog\\src\\main\\resources\\WorldList.txt");
        StringBuilder stringBuilder = new StringBuilder();
        long t1, t2;
        for (int i = 0; i < 100; i++) {
            stringBuilder.append("大家好，我是徐强，我不喜欢骂人的小朋友。");
        }
        String s = stringBuilder.toString();
        String result = null;
        t1 = System.nanoTime();
        for (int i = 0; i < 10000; i++) {
            result = SensitiveWordFilter.Filter(s);
        }
        t2 = System.nanoTime();
        System.out.println(result);
        System.out.println((t2 - t1) / 1000000 + "毫秒");
    }
}

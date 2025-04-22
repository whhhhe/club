package com.jingdianjichi.interview.server.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.*;

@Configuration
public class InterviewThreadPoolConfig {

    @Bean(name = "interviewExecutor")
    public ExecutorService interviewExecutor() {
        return new ThreadPoolExecutor(
                5,                      // corePoolSize
                10,                      // maximumPoolSize
                60L, TimeUnit.SECONDS, // keepAliveTime
                new LinkedBlockingQueue<>(100), // 阻塞队列
                new ThreadFactory() {
                    private final ThreadFactory defaultFactory = Executors.defaultThreadFactory();
                    private int count = 0;

                    @Override
                    public Thread newThread(Runnable r) {
                        Thread thread = defaultFactory.newThread(r);
                        thread.setName("interview-thread-" + count++);
                        thread.setDaemon(false); // 是否为守护线程
                        return thread;
                    }
                },
                new ThreadPoolExecutor.CallerRunsPolicy() // 饱和策略
        );
    }
}

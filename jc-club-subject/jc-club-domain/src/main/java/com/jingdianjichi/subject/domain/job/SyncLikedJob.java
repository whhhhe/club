package com.jingdianjichi.subject.domain.job;

import com.jingdianjichi.subject.domain.service.SubjectInfoDomainService;
import com.jingdianjichi.subject.domain.service.SubjectLikedDomainService;
import com.xxl.job.core.context.XxlJobHelper;
import com.xxl.job.core.handler.annotation.XxlJob;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;

/**
 * 同步点赞数据
 *
 * @author: ChickenWing
 * @date: 2024/1/8
 */
@Component
@Slf4j
public class SyncLikedJob {

    @Resource
    private SubjectLikedDomainService subjectLikedDomainService;

    @Resource
    private SubjectInfoDomainService subjectInfoDomainService;
    /**
     * 同步点赞数据任务
     */
    @XxlJob("syncLikedJobHandler")
    public void syncLikedJobHandler() throws Exception {
        XxlJobHelper.log("syncLikedJobHandler.start");
        try {
            subjectLikedDomainService.syncLiked();
        } catch (Exception e) {
            XxlJobHelper.log("syncLikedJobHandler.error" + e.getMessage());
        }
    }

    @XxlJob("setDiffAndTag")
    public void setDiffAndTag(){
        System.out.println("start");
        XxlJobHelper.log("setDiffAndTag.start");
        try{
            subjectInfoDomainService.setDiffAndTag();
        }catch (Exception e){
            XxlJobHelper.log("setDiffAndTag.error" + e.getMessage());
        }
    }

}

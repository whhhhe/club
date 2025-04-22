package com.jingdianjichi.interview.server.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jingdianjichi.interview.api.enums.EngineEnum;
import com.jingdianjichi.interview.api.req.InterviewSubmitReq;
import com.jingdianjichi.interview.api.req.StartReq;
import com.jingdianjichi.interview.api.vo.InterviewQuestionVO;
import com.jingdianjichi.interview.api.vo.InterviewResultVO;
import com.jingdianjichi.interview.api.vo.InterviewVO;
import com.jingdianjichi.interview.server.dao.SubjectDao;
import com.jingdianjichi.interview.server.entity.po.SubjectCategory;
import com.jingdianjichi.interview.server.entity.po.SubjectLabel;
import com.jingdianjichi.interview.server.service.InterviewEngine;
import com.jingdianjichi.interview.server.util.EvaluateUtils;
import com.jingdianjichi.interview.server.util.HttpUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;
import java.util.concurrent.ExecutorService;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@Slf4j
@SuppressWarnings("all")
public class AlBLInterviewEngine implements InterviewEngine {

    //换自己的token
    private static final String apiKey = "sk-5ac9980f10b140fa8fd744a68bc3516f";

    @Override
    public EngineEnum engineType() {
        return EngineEnum.ALI_BL;
    }

    @Resource(name = "interviewExecutor")
    private ExecutorService interviewExecutor;

    @Override
    public InterviewVO analyse(List<String> KeyWords) {

        log.info("ALI analyse......................");
        InterviewVO vo = new InterviewVO();
        List<InterviewVO.Interview> questionList = KeyWords.stream().map(item -> {
            InterviewVO.Interview interview = new InterviewVO.Interview();
            interview.setKeyWord(item);
            interview.setCategoryId(-1L);
            interview.setLabelId(-1L);
            return interview;
        }).collect(Collectors.toList());
        vo.setQuestionList(questionList);
        return vo;

    }

    @Override
    public InterviewResultVO submit(InterviewSubmitReq req) {
        long start = System.currentTimeMillis();
        log.info(">>> 调用 submit 方法，问题数：{}", req.getQuestionList() == null ? 0 : req.getQuestionList().size());

        // 并发执行调用 buildInterviewScore 方法
        List<InterviewSubmitReq.Submit> inputList = req.getQuestionList();
        List<CompletableFuture<InterviewSubmitReq.Submit>> futures = inputList.stream()
                .map(s -> CompletableFuture.supplyAsync(() -> {
                    try {
                        return buildInterviewScore(s);
                    } catch (Exception e) {
                        log.error("buildInterviewScore error", e);
                        return fallbackSubmit(s);
                    }
                }, interviewExecutor))
                .collect(Collectors.toList());

        List<InterviewSubmitReq.Submit> interviews = new ArrayList<>();
        CompletableFuture<Void> allDone = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));
        try {
            allDone.join();
            for (CompletableFuture<InterviewSubmitReq.Submit> future : futures) {
                interviews.add(future.get());
            }
        } catch (Exception e) {
            log.error("等待评分任务完成失败", e);
        }

        req.setQuestionList(interviews);

//        String tips = interviews.stream().map(item -> {
//            String keyWord = item.getLabelName();
//            String evaluate = EvaluateUtils.evaluate(item.getUserScore());
//            return String.format(evaluate, keyWord);
//        }).distinct().collect(Collectors.joining(";"));

        List<InterviewSubmitReq.Submit> submits = req.getQuestionList();
        double total = submits.stream().mapToDouble(InterviewSubmitReq.Submit::getUserScore).sum();
        double avg = submits.isEmpty() ? 0 : total / submits.size();
//
//        String avtTips = EvaluateUtils.avgEvaluate(avg);
        InterviewResultVO vo = new InterviewResultVO();
        vo.setAvgScore(avg);
        // 调用大模型生成整体点评
        try {
            StringBuilder summaryPrompt = new StringBuilder();
            summaryPrompt.append("以下是用户的模拟面试题目与作答内容，请你从整体角度评价本次面试表现，主要指出不足之处，简略说一下优点，并提出提升建议，最终输出一段总结文字,字数在100字以内：\n\n");

            for (InterviewSubmitReq.Submit s : interviews) {
                summaryPrompt.append(String.format("【题目】：%s\n", s.getSubjectName()));
                summaryPrompt.append(String.format("【回答】：%s\n\n", s.getUserAnswer()));
            }
            summaryPrompt.append("请给出整体表现点评：");

            JSONObject jsonData = new JSONObject();
            jsonData.put("model", "deepseek-r1-distill-llama-70b");

            JSONObject message = new JSONObject();
            message.put("role", "user");
            message.put("content", summaryPrompt.toString());

            JSONObject input = new JSONObject();
            input.put("messages", new JSONObject[]{message});
            jsonData.put("input", input);
            jsonData.put("parameters", new JSONObject());

            Map<String, String> headerMap = new HashMap<>();
            headerMap.put("Authorization", "Bearer " + apiKey);
            headerMap.put("Content-Type", "application/json");

            String url = "https://dashscope.aliyuncs.com/api/v1/services/aigc/text-generation/generation";
            String responseBody = HttpUtils.executePost(url, jsonData.toJSONString(), headerMap);

            String modelEvaluate = "";
            try {
                JSONObject resultJson = JSONObject.parseObject(responseBody);
                JSONObject output = resultJson.getJSONObject("output");
                JSONArray choices = output.getJSONArray("choices");
                if (choices != null && !choices.isEmpty()) {
                    modelEvaluate = choices.getJSONObject(0).getJSONObject("message").getString("content");
                }
            } catch (Exception e) {
                log.error("解析大模型点评失败", e);
                modelEvaluate = "大模型点评失败，请稍后再试。";
            }

            vo.setTips(modelEvaluate);
        } catch (Exception e) {
            log.error("调用大模型生成点评失败", e);
            vo.setTips("大模型点评异常，请稍后再试。");
        }
//        vo.setTips(tips);
//        vo.setAvgTips(avtTips);

        log.info("submit total cost {}ms", System.currentTimeMillis() - start);
        return vo;
    }


    @Override
    public InterviewQuestionVO start(StartReq req) {
        log.info("开始面试.............................");
        long start = System.currentTimeMillis();
        List<String> keywords = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            StartReq.Key key = req.getQuestionList().get(new Random().nextInt(req.getQuestionList().size()));
            keywords.add(key.getKeyWord());
        }
        System.out.println("*****************************************************");
        System.out.println(keywords);
        List<CompletableFuture<InterviewQuestionVO.Interview>> futures = keywords.stream()
                .map(keyword -> CompletableFuture.supplyAsync(() -> {
                    try {
                        log.info("开始构造面试题，关键词: {}", keyword);
                        InterviewQuestionVO.Interview result = buildInterview(keyword);
                        log.info("完成构造，关键词: {}, 结果: {}", keyword, result);
                        return result;
                    } catch (Exception e) {
                        log.error("构造面试题失败，关键词: {}", keyword, e);
                        throw new CompletionException(e); // 重要！包装异常，确保 join() 能感知
                    }
                }, interviewExecutor))
                .collect(Collectors.toList());
        CompletableFuture<Void> allDone = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));

        List<InterviewQuestionVO.Interview> interviews = new ArrayList<>();

        try {
            allDone.join(); // 触发 CompletionException
            for (CompletableFuture<InterviewQuestionVO.Interview> future : futures) {
                InterviewQuestionVO.Interview interview = future.get(); // 已完成
                if (interview != null) {
                    interviews.add(interview);
                }
            }
        } catch (CompletionException e) {
            log.error("某个任务失败了: {}", e.getCause().getMessage(), e.getCause());
        } catch (Exception e) {
            log.error("等待任务完成时发生异常", e);
        }

        InterviewQuestionVO vo = new InterviewQuestionVO();
        vo.setQuestionList(interviews);
        log.info("start total cost {}", System.currentTimeMillis() - start);
        return vo;

    }


    private static InterviewSubmitReq.Submit buildInterviewScore(InterviewSubmitReq.Submit submit) {
        long start = System.currentTimeMillis();
        log.info("开始调用大模型评分接口，题目信息：{}", JSON.toJSONString(submit));

        JSONObject jsonData = new JSONObject();
        jsonData.put("model", "deepseek-r1-distill-llama-70b");

        JSONObject input = new JSONObject();
        JSONObject message2 = new JSONObject();
        message2.put("role", "user");

        String keyword = String.format("题目:%s,用户答案:%s", submit.getSubjectName(), submit.getUserAnswer());
        String prompt = String.format(
                "根据题目和用户答案 %s ;根据用户回答与正确答案的关联度的客观地打一个分数并给出参考答案，打分标准为：0分很差，1分较差，2分一般，3分较好，4分很好，5分完美，请严格打分，并按照数据结构{\"userScore\":\"用户分数\",\"subjectAnswer\":\"参考答案\"}返回JSON数据（只返回JSON）",
                keyword
        );
        message2.put("content", prompt);
        input.put("messages", new JSONObject[]{message2});
        jsonData.put("input", input);
        jsonData.put("parameters", new JSONObject());

        Map<String, String> headerMap = new HashMap<>();
        headerMap.put("Authorization", "Bearer " + apiKey);
        headerMap.put("Content-Type", "application/json");

        String url = "https://dashscope.aliyuncs.com/api/v1/services/aigc/text-generation/generation";
        String body = HttpUtils.executePost(url, jsonData.toJSONString(), headerMap);

        try {
            if (body == null || body.trim().isEmpty()) {
                throw new RuntimeException("大模型接口返回为空");
            }

            JSONObject json = JSONObject.parseObject(body);

            // ✅ 正确的路径：output → choices[0] → message → content
            JSONObject output = json.getJSONObject("output");
            if (output == null || !output.containsKey("choices")) {
                throw new RuntimeException("返回体中不包含 output.choices 字段：" + body);
            }

            JSONObject choice = output.getJSONArray("choices").getJSONObject(0);
            JSONObject message = choice.getJSONObject("message");
            String content = message.getString("content");

            log.info("deepseek 模型原始 content: {}", content);

            // 提取 JSON 内容
            String jsonStr;
            int jsonStart = content.lastIndexOf("```json");
            int jsonEnd = content.lastIndexOf("```");

            if (jsonStart != -1 && jsonEnd != -1 && jsonEnd > jsonStart) {
                jsonStr = content.substring(jsonStart + 7, jsonEnd).trim();
            } else {
                jsonStr = content.trim(); // fallback: 直接用文本
            }

            InterviewSubmitReq.Submit result = JSONObject.parseObject(jsonStr, InterviewSubmitReq.Submit.class);
            result.setLabelName(submit.getLabelName());
            result.setSubjectName(submit.getSubjectName());
            result.setUserAnswer(submit.getUserAnswer());

            log.info("✅ 成功解析评分对象：{}", JSON.toJSONString(result));
            log.info("buildInterviewScore 总耗时：{}ms", System.currentTimeMillis() - start);
            return result;

        } catch (Exception e) {
            log.error("❌ deepseek 模型评分解析失败，错误信息：{}", e.getMessage(), e);
            submit.setSubjectAnswer("获取解析失败");
            submit.setUserScore(0.0);
            return submit;
        }
    }





    private static InterviewQuestionVO.Interview buildInterview(String keyword) {
        long start = System.currentTimeMillis();
        JSONObject jsonData = new JSONObject();
        jsonData.put("model", "deepseek-r1-distill-llama-70b");

        // 构造 prompt
        JSONObject input = new JSONObject();
        JSONObject message = new JSONObject();
        message.put("role", "user");

        String prompt = String.format(
                "根据以下关键字生成1份标签和面试题（你生成的面试题应该侧重概念性而不是实际场景题，不要涉及应用等问题，" +
                        "面试题需要是一个和关键词强相关的一个细分知识点）并按照数据结构{\"labelName\":\"分类名称\",\"subjectName\":\"题目\"}返回JSON数据，" +
                        "不要多返回其他内容，严格按照格式，一次返回一个题目，回答中文。关键词：%s", keyword);

        log.info("请求 prompt 内容：{}", prompt);
        message.put("content", prompt);
        input.put("messages", new JSONObject[]{message});
        jsonData.put("input", input);
        jsonData.put("parameters", new JSONObject());

        // header 设置
        Map<String, String> headerMap = new HashMap<>();
        headerMap.put("Authorization", "Bearer " + apiKey);
        headerMap.put("Content-Type", "application/json");

        String url = "https://dashscope.aliyuncs.com/api/v1/services/aigc/text-generation/generation";
        String body = HttpUtils.executePost(url, jsonData.toJSONString(), headerMap);

        try {
            if (body == null) throw new IllegalStateException("deepseek 接口返回为空");

            JSONObject root = JSONObject.parseObject(body);
            JSONObject output = root.getJSONObject("output");
            if (output == null) throw new IllegalStateException("返回中未包含 output");

            JSONArray choices = output.getJSONArray("choices");
            if (choices == null || choices.isEmpty()) throw new IllegalStateException("返回中未包含 choices");

            JSONObject contentMsg = choices.getJSONObject(0).getJSONObject("message");
            String content = contentMsg.getString("content");

            log.info("deepseek content 原始返回: {}", content);

            // 提取 JSON 数据（兼容 markdown 格式）
            String jsonStr;
            int jsonStart = content.lastIndexOf("```json");
            int jsonEnd = content.lastIndexOf("```");

            if (jsonStart != -1 && jsonEnd != -1 && jsonEnd > jsonStart) {
                jsonStr = content.substring(jsonStart + 7, jsonEnd).trim();
            } else {
                jsonStr = content.trim();
            }

            InterviewQuestionVO.Interview interview = JSONObject.parseObject(jsonStr, InterviewQuestionVO.Interview.class);
            log.info("✅ 成功解析面试题：{}", JSON.toJSONString(interview));
            return interview;

        } catch (Exception e) {
            log.error("❌ 解析 deepseek 返回值失败：{}", e.getMessage(), e);
            InterviewQuestionVO.Interview fallback = new InterviewQuestionVO.Interview();
            fallback.setLabelName("默认分类");
            fallback.setSubjectName("未成功生成面试题，请稍后再试");
            return fallback;
        } finally {
            log.info("buildInterview 耗时：{}ms", System.currentTimeMillis() - start);
        }
    }


    private InterviewSubmitReq.Submit fallbackSubmit(InterviewSubmitReq.Submit s) {
        InterviewSubmitReq.Submit fallback = new InterviewSubmitReq.Submit();
        fallback.setLabelName(s.getLabelName());
        fallback.setSubjectName(s.getSubjectName());
        fallback.setUserAnswer(s.getUserAnswer());
        fallback.setSubjectAnswer("评分失败，已使用默认值");
        fallback.setUserScore(0.0);
        return fallback;
    }



}

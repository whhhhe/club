package com.jingdianjichi.circle.server.controller;

import com.alibaba.fastjson.JSON;
import com.google.common.base.Preconditions;
import com.jingdianjichi.circle.api.common.PageResult;
import com.jingdianjichi.circle.api.common.Result;
import com.jingdianjichi.circle.api.req.GetShareMessageReq;
import com.jingdianjichi.circle.api.vo.ShareMessageVO;
import com.jingdianjichi.circle.server.service.ShareMessageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * <p>
 * 动态信息 前端控制器
 * </p>
 *
 * @author ChickenWing
 * @since 2024/05/16
 */
@Slf4j
@RestController
@RequestMapping("/circle/share/message")
public class ShareMessageController {

    @Resource
    private ShareMessageService shareMessageService;

    /**
     * 分页查询消息
     */
    @GetMapping(value = "/unRead")
    public Result<Boolean> unRead() {
        try {
            return Result.ok(shareMessageService.unRead());
        } catch (Exception e) {
            log.error("消息异常！错误原因{}", e.getMessage(), e);
            return Result.fail("消息异常！");
        }
    }

    /**
     * 分页查询消息
     */
    @PostMapping(value = "/getMessages")
    public Result<PageResult<ShareMessageVO>> getMessages(@RequestBody GetShareMessageReq req) {
        try {
            if (log.isInfoEnabled()) {
                log.info("getMessage消息入参{}", JSON.toJSONString(req));
            }
            Preconditions.checkArgument(!Objects.isNull(req), "参数不能为空！");
            PageResult<ShareMessageVO> result = shareMessageService.getMessages(req);
            if (log.isInfoEnabled()) {
                log.info("消息出参{}", JSON.toJSONString(result));
            }
            return Result.ok(result);
        } catch (IllegalArgumentException e) {
            log.error("参数异常！错误原因{}", e.getMessage(), e);
            return Result.fail(e.getMessage());
        } catch (Exception e) {
            log.error("消息异常！错误原因{}", e.getMessage(), e);
            return Result.fail("消息异常！");
        }
    }

    @GetMapping("/queryUserNames")
    public Result<Map<String, String>> queryUserNames(@RequestParam("username") List<String> username){
        try {
            if (log.isInfoEnabled()) {
                log.info("queryUserNames消息入参{}", JSON.toJSONString(username));
            }
            Preconditions.checkArgument(!Objects.isNull(username), "参数不能为空！");
           Map<String, String> result = shareMessageService.queryUserNames(username);
            if (log.isInfoEnabled()) {
                log.info("消息出参{}", JSON.toJSONString(result));
            }
            return Result.ok(result);
        } catch (Exception e) {
            log.error("消息异常！错误原因{}", e.getMessage(), e);
            return Result.fail("消息异常！");
        }
    }

    @PostMapping("markRead")
    public Result markRead(@RequestParam("messageId") Long id){
        try {
            if (log.isInfoEnabled()) {
                log.info("queryUserNames消息入参{}", id);
            }
            Preconditions.checkArgument(id !=null, "参数不能为空！");
             shareMessageService.markRead(id);
            return Result.ok();
        } catch (Exception e) {
            log.error("已读异常！错误原因{}", e.getMessage(), e);
            return Result.fail("已读异常！");
        }
    }

    @GetMapping("unreadCount")
    public Result<Integer> unreadCount(@RequestParam("userId") String username){
        try {
            if (log.isInfoEnabled()) {
                log.info("queryUserNames消息入参{}", username);
            }
            Preconditions.checkNotNull(username, "username为空！");
            Integer count = shareMessageService.unreadCount(username);
            return Result.ok(count);
        } catch (Exception e) {
            log.error("获取未读消息数量异常！错误原因{}", e.getMessage(), e);
            return Result.fail("获取未读消息数量异常！");
        }
    }
}

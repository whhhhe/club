package com.jingdianjichi.circle.server.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.base.Preconditions;
import com.jingdianjichi.circle.api.common.Result;
import com.jingdianjichi.circle.api.enums.IsDeletedFlagEnum;
import com.jingdianjichi.circle.api.req.GetShareCommentReq;
import com.jingdianjichi.circle.api.req.RemoveShareCommentReq;
import com.jingdianjichi.circle.api.req.SaveShareCommentReplyReq;
import com.jingdianjichi.circle.api.vo.ShareCommentReplyVO;
import com.jingdianjichi.circle.api.vo.ShareMomentVO;
import com.jingdianjichi.circle.server.entity.po.ShareCommentReply;
import com.jingdianjichi.circle.server.entity.po.ShareMoment;
import com.jingdianjichi.circle.server.sensitive.WordFilter;
import com.jingdianjichi.circle.server.service.ShareCommentReplyService;
import com.jingdianjichi.circle.server.service.ShareMessageService;
import com.jingdianjichi.circle.server.service.ShareMomentService;
import com.jingdianjichi.circle.server.util.LoginUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 回复及评论 前端控制器
 * </p>
 *
 * @author ChickenWing
 * @since 2024/05/16
 */
@Slf4j
@RestController
@RequestMapping("/circle/share/comment")
public class ShareCommentController {

    @Resource
    private ShareMomentService shareMomentService;
    @Resource
    private ShareCommentReplyService shareCommentReplyService;
    @Resource
    private WordFilter wordFilter;
    @Resource
    private ShareMessageService shareMessageService;

    /**
     * 发布内容
     */
    @PostMapping(value = "/save")
    public Result<Long> save(@RequestBody SaveShareCommentReplyReq req) {
        try {
            if (log.isInfoEnabled()) {
                log.info("发布内容入参{}", JSON.toJSONString(req));
            }
            Preconditions.checkArgument(Objects.nonNull(req), "参数不能为空！");
            Preconditions.checkArgument(Objects.nonNull(req.getReplyType()), "类型不能为空！");
            Preconditions.checkArgument(Objects.nonNull(req.getMomentId()), "内容ID不能为空！");
            ShareMoment moment = shareMomentService.getById(req.getMomentId());
            Preconditions.checkArgument((Objects.nonNull(moment) && moment.getIsDeleted() != IsDeletedFlagEnum.DELETED.getCode()), "非法内容！");
            Preconditions.checkArgument((Objects.nonNull(req.getContent()) || Objects.nonNull(req.getPicUrlList())), "内容不能为空！");
            String content = req.getContent();
            wordFilter.check(content);
            Long id = shareCommentReplyService.saveComment(req);

            if (req.getReplyType() == 1) {
                shareMessageService.comment(LoginUtil.getLoginId(), moment.getCreatedBy(), moment.getId(), content, id);
            } else {
                LambdaQueryWrapper<ShareCommentReply> query = Wrappers.<ShareCommentReply>lambdaQuery()
                        .eq(ShareCommentReply::getId, req.getTargetId())
                        .select(ShareCommentReply::getCreatedBy);
                ShareCommentReply reply = shareCommentReplyService.getOne(query);
                shareMessageService.reply(LoginUtil.getLoginId(), reply.getCreatedBy(), moment.getId(), content, id);
            }
            return Result.ok(id);
        } catch (IllegalArgumentException e) {
            log.error("参数异常！错误原因{}", e.getMessage(), e);
            return Result.fail(e.getMessage());
        } catch (Exception e) {
            log.error("发布内容异常！错误原因{}", e.getMessage(), e);
            return Result.fail("发布内容异常！");
        }
    }


    /**
     * 删除鸡圈评论内容
     */
    @PostMapping(value = "/remove")
    public Result<Boolean> remove(@RequestBody RemoveShareCommentReq req) {
        try {
            if (log.isInfoEnabled()) {
                log.info("删除鸡圈评论内容入参{}", JSON.toJSONString(req));
            }
            Preconditions.checkArgument(Objects.nonNull(req), "参数不能为空！");
            Preconditions.checkArgument(Objects.nonNull(req.getReplyType()), "类型不能为空！");
            Preconditions.checkArgument(Objects.nonNull(req.getId()), "内容ID不能为空！");
            Boolean result = shareCommentReplyService.removeComment(req);
            if (log.isInfoEnabled()) {
                log.info("删除鸡圈评论内容{}", JSON.toJSONString(result));
            }
            return Result.ok(result);
        } catch (IllegalArgumentException e) {
            log.error("参数异常！错误原因{}", e.getMessage(), e);
            return Result.fail(e.getMessage());
        } catch (Exception e) {
            log.error("删除鸡圈评论内容异常！错误原因{}", e.getMessage(), e);
            return Result.fail("删除鸡圈评论内容异常！");
        }
    }

    /**
     * 查询该动态下的评论
     */
    @PostMapping(value = "/list")
    public Result<List<ShareCommentReplyVO>> list(@RequestBody GetShareCommentReq req) {
        try {
            if (log.isInfoEnabled()) {
                log.info("获取鸡圈评论内容入参{}", JSON.toJSONString(req));
            }
            Preconditions.checkArgument(Objects.nonNull(req), "参数不能为空！");
            Preconditions.checkArgument(Objects.nonNull(req.getId()), "内容ID不能为空！");
            List<ShareCommentReplyVO> result = shareCommentReplyService.listComment(req);
            if (log.isInfoEnabled()) {
                log.info("获取鸡圈评论内容{}", JSON.toJSONString(result));
            }
            return Result.ok(result);
        } catch (IllegalArgumentException e) {
            log.error("参数异常！错误原因{}", e.getMessage(), e);
            return Result.fail(e.getMessage());
        } catch (Exception e) {
            log.error("获取鸡圈评论内容异常！错误原因{}", e.getMessage(), e);
            return Result.fail("获取鸡圈评论内容异常！");
        }
    }

    @GetMapping("getDetail")
    public Result<List<ShareCommentReplyVO>> getDetail(@RequestParam("commentIds") List<Long> ids){
        try {
            if (log.isInfoEnabled()) {
                log.info("获取指定评论/回复内容入参{}", ids);
            }
            Preconditions.checkNotNull(ids, "id为空！");
            if(ids.isEmpty()) return null;
            List<ShareCommentReplyVO> detail = shareCommentReplyService.getDetail(ids);
            return Result.ok(detail);
        } catch (Exception e) {
            log.error("获取指定评论/回复内容异常！错误原因{}", e.getMessage());
            return Result.fail("获取指定评论/回复内容异常！");
        }
    }
}

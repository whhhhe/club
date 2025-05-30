package com.jingdianjichi.circle.server.controller;

import com.alibaba.fastjson.JSON;
import com.google.common.base.Preconditions;
import com.jingdianjichi.circle.api.common.PageResult;
import com.jingdianjichi.circle.api.common.Result;
import com.jingdianjichi.circle.api.req.GetShareMomentReq;
import com.jingdianjichi.circle.api.req.RemoveShareMomentReq;
import com.jingdianjichi.circle.api.req.SaveMomentCircleReq;
import com.jingdianjichi.circle.api.vo.ShareMomentVO;
import com.jingdianjichi.circle.server.entity.po.ShareCircle;
import com.jingdianjichi.circle.server.sensitive.WordFilter;
import com.jingdianjichi.circle.server.service.ShareCircleService;
import com.jingdianjichi.circle.server.service.ShareMomentService;
import com.sun.org.apache.xpath.internal.operations.Bool;
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
@RequestMapping("/circle/share/moment")
public class ShareMomentController {

    @Resource
    private ShareMomentService shareMomentService;
    @Resource
    private ShareCircleService shareCircleService;
    @Resource
    private WordFilter wordFilter;

    /**
     * 发布内容
     */
    @PostMapping(value = "/save")
    public Result<Boolean> save(@RequestBody SaveMomentCircleReq req) {
        try {
            if (log.isInfoEnabled()) {
                log.info("发布内容入参{}", JSON.toJSONString(req));
            }
            Preconditions.checkArgument(Objects.nonNull(req), "参数不能为空！");
            Preconditions.checkArgument(Objects.nonNull(req.getCircleId()), "圈子ID不能为空！");
            ShareCircle data = shareCircleService.getById(req.getCircleId());
            Preconditions.checkArgument((Objects.nonNull(data) && data.getParentId() != -1), "非法圈子ID！");
            Preconditions.checkArgument((Objects.nonNull(req.getContent()) || Objects.nonNull(req.getPicUrlList())), "鸡圈不能为空！");
            wordFilter.check(req.getContent());
            Boolean result = shareMomentService.saveMoment(req);
            if (log.isInfoEnabled()) {
                log.info("发布内容{}", JSON.toJSONString(result));
            }
            return Result.ok(result);
        } catch (IllegalArgumentException e) {
            log.error("参数异常！错误原因{}", e.getMessage(), e);
            return Result.fail(e.getMessage());
        } catch (Exception e) {
            log.error("发布内容异常！错误原因{}", e.getMessage(), e);
            return Result.fail("发布内容异常！");
        }
    }


    /**
     * 分页查询鸡圈内容
     */
    @PostMapping(value = "/getMoments")
    public Result<PageResult<ShareMomentVO>> getMoments(@RequestBody GetShareMomentReq req) {
        try {
            if (log.isInfoEnabled()) {
                log.info("鸡圈内容入参{}", JSON.toJSONString(req));
            }
            Preconditions.checkArgument(!Objects.isNull(req), "参数不能为空！");
            PageResult<ShareMomentVO> result = shareMomentService.getMoments(req);
            if (log.isInfoEnabled()) {
                log.info("鸡圈内容出参{}", JSON.toJSONString(result));
            }
            return Result.ok(result);
        } catch (IllegalArgumentException e) {
            log.error("参数异常！错误原因{}", e.getMessage(), e);
            return Result.fail(e.getMessage());
        } catch (Exception e) {
            log.error("鸡圈内容异常！错误原因{}", e.getMessage(), e);
            return Result.fail("鸡圈内容异常！");
        }
    }


    /**
     * 删除鸡圈内容
     */
    @PostMapping(value = "/remove")
    public Result<Boolean> remove(@RequestBody RemoveShareMomentReq req) {
        try {
            if (log.isInfoEnabled()) {
                log.info("删除鸡圈内容入参{}", JSON.toJSONString(req));
            }
            Preconditions.checkArgument(Objects.nonNull(req), "参数不能为空！");
            Preconditions.checkArgument(Objects.nonNull(req.getId()), "内容ID不能为空！");
            Boolean result = shareMomentService.removeMoment(req);
            if (log.isInfoEnabled()) {
                log.info("删除鸡圈内容{}", JSON.toJSONString(result));
            }
            return Result.ok(result);
        } catch (IllegalArgumentException e) {
            log.error("参数异常！错误原因{}", e.getMessage(), e);
            return Result.fail(e.getMessage());
        } catch (Exception e) {
            log.error("删除鸡圈内容异常！错误原因{}", e.getMessage(), e);
            return Result.fail("删除鸡圈内容异常！");
        }
    }

    @GetMapping("getDetail")
    public Result<List<ShareMomentVO>> getDetail(@RequestParam("ids") List<Long> ids){
        try {
            if (log.isInfoEnabled()) {
                log.info("获取指定帖子内容入参{}", ids);
            }
            Preconditions.checkNotNull(ids, "id为空！");
            if(ids.isEmpty()) return null;
            List<ShareMomentVO> detail = shareMomentService.getDetail(ids);
            return Result.ok(detail);
        } catch (Exception e) {
            log.error("获取指定帖子内容异常！错误原因{}", e.getMessage());
            return Result.fail("获取指定帖子内容异常！");
        }
    }
}

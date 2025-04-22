package com.jingdianjichi.circle.server.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jingdianjichi.circle.api.common.PageInfo;
import com.jingdianjichi.circle.api.common.PageResult;
import com.jingdianjichi.circle.api.enums.IsDeletedFlagEnum;
import com.jingdianjichi.circle.api.req.GetShareMessageReq;
import com.jingdianjichi.circle.api.vo.ShareMessageVO;
import com.jingdianjichi.circle.server.dao.ShareMessageMapper;
import com.jingdianjichi.circle.server.entity.dto.UserInfo;
import com.jingdianjichi.circle.server.entity.po.ShareMessage;
import com.jingdianjichi.circle.server.rpc.UserRpc;
import com.jingdianjichi.circle.server.service.ShareMessageService;
import com.jingdianjichi.circle.server.util.LoginUtil;
import com.jingdianjichi.circle.server.websocket.ChickenSocket;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 * 消息表 服务实现类
 * </p>
 *
 * @author ChickenWing
 * @since 2024/05/18
 */
@Service
@Slf4j
public class ShareMessageServiceImpl extends ServiceImpl<ShareMessageMapper, ShareMessage> implements ShareMessageService {

    @Resource
    private ChickenSocket chickenSocket;
    @Resource
    private UserRpc userRpc;

    @Resource
    private ShareMessageMapper shareMessageMapper;

    @Override
    public PageResult<ShareMessageVO> getMessages(GetShareMessageReq req) {

        LambdaQueryWrapper<ShareMessage> query = Wrappers.<ShareMessage>lambdaQuery()
                .eq(ShareMessage::getToId, LoginUtil.getLoginId())
                .ne(ShareMessage::getFromId, LoginUtil.getLoginId()) // 💡 不查自己发给自己的消息
                .eq(req.getIsRead() != null, ShareMessage::getIsRead, req.getIsRead())
                .eq(ShareMessage::getIsDeleted, IsDeletedFlagEnum.UN_DELETED.getCode())
                .orderByDesc(ShareMessage::getId);

        PageInfo pageInfo = req.getPageInfo();
        Page<ShareMessage> page = new Page<>(pageInfo.getPageNo(), pageInfo.getPageSize());
        Page<ShareMessage> pageRes = super.page(page, query);
        PageResult<ShareMessageVO> result = new PageResult<>();
        List<ShareMessage> records = pageRes.getRecords();
//        if (CollectionUtils.isNotEmpty(records)) {
//            List<Long> ids = records.stream().map(ShareMessage::getId).collect(Collectors.toList());
//            LambdaUpdateWrapper<ShareMessage> update = Wrappers.<ShareMessage>lambdaUpdate().set(ShareMessage::getIsRead, 1).in(ShareMessage::getId, ids);
//            super.update(update);
//        }
        List<ShareMessageVO> list = records.stream().map(item -> {
            ShareMessageVO vo = new ShareMessageVO();
            vo.setId(item.getId());
            vo.setIdRead(item.getIsRead());
            vo.setContent(JSON.parseObject(item.getContent()));
            vo.setCreatedTime(item.getCreatedTime());
            return vo;
        }).collect(Collectors.toList());
        log.info("List:{}", list);
        result.setRecords(list);
        result.setTotal((int) pageRes.getTotal());
        result.setPageSize(pageInfo.getPageSize());
        result.setPageNo(pageInfo.getPageNo());
        log.info("Result:{}", result);
        return result;
    }

    @Override
    public void comment(String fromId, String toId, Long targetId, String content, Long commentId) {

        JSONObject message = new JSONObject();
        // 1=评论 2=回复
        message.put("msgType", "COMMENT");
        message.put("userId", fromId);
        message.put("msg", " 评论:");
        message.put("commentId", commentId);
        message.put("targetId", targetId);
        ShareMessage shareMessage = new ShareMessage();
        shareMessage.setFromId(fromId);
        shareMessage.setToId(toId);
        shareMessage.setContent(message.toJSONString());
        shareMessage.setIsRead(2);
        shareMessage.setCreatedBy(fromId);
        shareMessage.setCreatedTime(new Date());
        shareMessage.setIsDeleted(IsDeletedFlagEnum.UN_DELETED.getCode());
        ChickenSocket socket = chickenSocket.getChickenSocket(toId);
        if (Objects.nonNull(socket)) {
            chickenSocket.sendMessage(shareMessage.getContent(), socket.getSession());
        }
        super.save(shareMessage);

    }

    @Override
    public void reply(String fromId, String toId, Long targetId, String content, Long commentId) {

        JSONObject message = new JSONObject();
        // 1=评论 2=回复
        message.put("msgType", "COMMENT_REPLY");
        message.put("userId", fromId);
        message.put("msg", " 回复: ");
        message.put("commentId", commentId);
        message.put("targetId", targetId);
        ShareMessage shareMessage = new ShareMessage();
        shareMessage.setFromId(fromId);
        shareMessage.setToId(toId);
        shareMessage.setContent(message.toJSONString());
        shareMessage.setIsRead(2);
        shareMessage.setCreatedBy(fromId);
        shareMessage.setCreatedTime(new Date());
        shareMessage.setIsDeleted(IsDeletedFlagEnum.UN_DELETED.getCode());
        ChickenSocket socket = chickenSocket.getChickenSocket(toId);
        if (Objects.nonNull(socket)) {
            chickenSocket.sendMessage(shareMessage.getContent(), socket.getSession());
        }
        super.save(shareMessage);

    }

    @Override
    public Boolean unRead() {
        LambdaQueryWrapper<ShareMessage> query = Wrappers.<ShareMessage>lambdaQuery()
                .eq(ShareMessage::getToId, LoginUtil.getLoginId())
                .eq(ShareMessage::getIsRead, 2)
                .eq(ShareMessage::getIsDeleted, IsDeletedFlagEnum.UN_DELETED.getCode());
        return super.count(query) > 0;
    }

    @Override
    public Map<String, String> queryUserNames(List<String> username) {
        Map<String, UserInfo> stringUserInfoMap = userRpc.batchGetUserInfo(username);
        Map<String, String> res = new HashMap<>();
        for(Map.Entry<String, UserInfo> entry : stringUserInfoMap.entrySet()){
            res.put(entry.getKey(), entry.getValue().getNickName());
        }
        return res;
    }

    @Override
    public void markRead(Long id) {
        LambdaUpdateWrapper<ShareMessage> updateWrapper = Wrappers.<ShareMessage>lambdaUpdate()
                .eq(ShareMessage::getId, id)
                .set(ShareMessage::getIsRead, 1);
        update(updateWrapper);
    }

    @Override
    public Integer unreadCount(String username) {
        QueryWrapper<ShareMessage> wrapper = new QueryWrapper<>();
        wrapper.eq("is_read", 2) // 未读
                .eq("to_id", username) // 消息接收者是当前用户
                .ne("from_id", username) // 发送者不是当前用户（排除自己发给自己的）
                .eq("is_deleted", 0);

        return shareMessageMapper.selectCount(wrapper);
    }

}

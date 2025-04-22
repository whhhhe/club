package com.jingdianjichi.circle.server.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.jingdianjichi.circle.api.common.PageResult;
import com.jingdianjichi.circle.api.req.GetShareMessageReq;
import com.jingdianjichi.circle.api.vo.ShareMessageVO;
import com.jingdianjichi.circle.server.entity.po.ShareMessage;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 消息表 服务类
 * </p>
 *
 * @author ChickenWing
 * @since 2024/05/18
 */
public interface ShareMessageService extends IService<ShareMessage> {

    PageResult<ShareMessageVO> getMessages(GetShareMessageReq req);

    void comment(String fromId, String toId, Long targetId, String content, Long commentId);

    void reply(String fromId, String toId, Long targetId, String content, Long commentId);

    Boolean unRead();

    Map<String, String> queryUserNames(List<String> username);

    void markRead(Long id);

    Integer unreadCount(String username);
}

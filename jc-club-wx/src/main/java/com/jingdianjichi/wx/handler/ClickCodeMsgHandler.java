package com.jingdianjichi.wx.handler;

import com.jingdianjichi.wx.redis.RedisUtil;
import com.jingdianjichi.wx.utils.CodeCreator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
public class ClickCodeMsgHandler implements WxChatMsgHandler{
    private static final String LOGIN_PREFIX = "loginCode";
    private static final String SEND_CODE = "SEND_CODE";
    @Resource
    private RedisUtil redisUtil;
    @Override
    public WxChatMsgTypeEnum getMsgType() {
        return WxChatMsgTypeEnum.CLICK;
    }

    @Override
    public String dealMsg(Map<String, String> messageMap) {
        log.info("接收到用户点击按钮事件");
        String fromUserName = messageMap.get("FromUserName");
        String toUserName = messageMap.get("ToUserName");
        String eventKey = messageMap.get("EventKey");
        if(eventKey.equals(SEND_CODE)){
            String num = CodeCreator.getCode();
            String numKey = redisUtil.buildKey(LOGIN_PREFIX, String.valueOf(num));
            redisUtil.setNx(numKey, fromUserName, 5L, TimeUnit.MINUTES);
            String numContent = "您当前的验证码是：" + num + "！ 5分钟内有效";
            String replyContent = "<xml>\n" +
                    "  <ToUserName><![CDATA[" + fromUserName + "]]></ToUserName>\n" +
                    "  <FromUserName><![CDATA[" + toUserName + "]]></FromUserName>\n" +
                    "  <CreateTime>12345678</CreateTime>\n" +
                    "  <MsgType><![CDATA[text]]></MsgType>\n" +
                    "  <Content><![CDATA[" + numContent + "]]></Content>\n" +
                    "</xml>";

            return replyContent;
        }else{
            String replyContent = "<xml>\n" +
                    "  <ToUserName><![CDATA[" + fromUserName + "]]></ToUserName>\n" +
                    "  <FromUserName><![CDATA[" + toUserName + "]]></FromUserName>\n" +
                    "  <CreateTime>12345678</CreateTime>\n" +
                    "  <MsgType><![CDATA[text]]></MsgType>\n" +
                    "  <Content><![CDATA[" + "敬请期待..." + "]]></Content>\n" +
                    "</xml>";
            return replyContent;
        }

    }
}

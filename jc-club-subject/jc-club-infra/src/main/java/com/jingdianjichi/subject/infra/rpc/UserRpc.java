package com.jingdianjichi.subject.infra.rpc;

import com.jingdianjichi.auth.api.UserFeignService;
import com.jingdianjichi.auth.entity.AuthUserDTO;
import com.jingdianjichi.auth.entity.Result;
import com.jingdianjichi.subject.infra.entity.UserInfo;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component
public class UserRpc {

    @Resource
    private UserFeignService userFeignService;

    public UserInfo getUserInfo(String userName) {
        AuthUserDTO authUserDTO = new AuthUserDTO();
        authUserDTO.setUserName(userName);
        Result<AuthUserDTO> result = userFeignService.getUserInfo(authUserDTO);
        UserInfo userInfo = new UserInfo();
        if (!result.getSuccess()) {
            return userInfo;
        }
        AuthUserDTO data = result.getData();
        userInfo.setUserName(data.getUserName());
        userInfo.setNickName(data.getNickName());
        userInfo.setAvatar(data.getAvatar());
        return userInfo;
    }


    public Long getRoleIdByUserId(String userId){
        Result<Long> res =  userFeignService.getRoleIdByUserId(userId);
        return res.getData();
    }
}

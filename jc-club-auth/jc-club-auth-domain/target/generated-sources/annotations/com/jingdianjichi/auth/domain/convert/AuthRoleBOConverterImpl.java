package com.jingdianjichi.auth.domain.convert;

import com.jingdianjichi.auth.domain.entity.AuthRoleBO;
import com.jingdianjichi.auth.infra.basic.entity.AuthRole;
import javax.annotation.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-05-02T12:22:52+0800",
    comments = "version: 1.4.2.Final, compiler: javac, environment: Java 1.8.0_392 (Amazon.com Inc.)"
)
public class AuthRoleBOConverterImpl implements AuthRoleBOConverter {

    @Override
    public AuthRole convertBOToEntity(AuthRoleBO authRoleBO) {
        if ( authRoleBO == null ) {
            return null;
        }

        AuthRole authRole = new AuthRole();

        authRole.setId( authRoleBO.getId() );
        authRole.setRoleName( authRoleBO.getRoleName() );
        authRole.setRoleKey( authRoleBO.getRoleKey() );

        return authRole;
    }
}

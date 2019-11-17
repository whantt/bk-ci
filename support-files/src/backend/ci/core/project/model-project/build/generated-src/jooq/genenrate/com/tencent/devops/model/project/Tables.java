/*
 * This file is generated by jOOQ.
*/
package com.tencent.devops.model.project;


import com.tencent.devops.model.project.tables.TActivity;
import com.tencent.devops.model.project.tables.TFavorite;
import com.tencent.devops.model.project.tables.TGrayTest;
import com.tencent.devops.model.project.tables.TMessageCodeDetail;
import com.tencent.devops.model.project.tables.TProject;
import com.tencent.devops.model.project.tables.TProjectLabel;
import com.tencent.devops.model.project.tables.TProjectLabelRel;
import com.tencent.devops.model.project.tables.TService;
import com.tencent.devops.model.project.tables.TServiceType;
import com.tencent.devops.model.project.tables.TUser;
import com.tencent.devops.model.project.tables.TUserDailyFirstAndLastLogin;
import com.tencent.devops.model.project.tables.TUserDailyLogin;


/**
 * Convenience access to all tables in devops_project
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class Tables {

    /**
     * The table <code>devops_project.T_ACTIVITY</code>.
     */
    public static final TActivity T_ACTIVITY = com.tencent.devops.model.project.tables.TActivity.T_ACTIVITY;

    /**
     * The table <code>devops_project.t_favorite</code>.
     */
    public static final TFavorite T_FAVORITE = com.tencent.devops.model.project.tables.TFavorite.T_FAVORITE;

    /**
     * The table <code>devops_project.t_gray_test</code>.
     */
    public static final TGrayTest T_GRAY_TEST = com.tencent.devops.model.project.tables.TGrayTest.T_GRAY_TEST;

    /**
     * code码详情表
     */
    public static final TMessageCodeDetail T_MESSAGE_CODE_DETAIL = com.tencent.devops.model.project.tables.TMessageCodeDetail.T_MESSAGE_CODE_DETAIL;

    /**
     * The table <code>devops_project.t_project</code>.
     */
    public static final TProject T_PROJECT = com.tencent.devops.model.project.tables.TProject.T_PROJECT;

    /**
     * 项目标签信息表
     */
    public static final TProjectLabel T_PROJECT_LABEL = com.tencent.devops.model.project.tables.TProjectLabel.T_PROJECT_LABEL;

    /**
     * 项目与标签关联关系表
     */
    public static final TProjectLabelRel T_PROJECT_LABEL_REL = com.tencent.devops.model.project.tables.TProjectLabelRel.T_PROJECT_LABEL_REL;

    /**
     * The table <code>devops_project.t_service</code>.
     */
    public static final TService T_SERVICE = com.tencent.devops.model.project.tables.TService.T_SERVICE;

    /**
     * The table <code>devops_project.t_service_type</code>.
     */
    public static final TServiceType T_SERVICE_TYPE = com.tencent.devops.model.project.tables.TServiceType.T_SERVICE_TYPE;

    /**
     * The table <code>devops_project.T_USER</code>.
     */
    public static final TUser T_USER = com.tencent.devops.model.project.tables.TUser.T_USER;

    /**
     * The table <code>devops_project.T_USER_DAILY_FIRST_AND_LAST_LOGIN</code>.
     */
    public static final TUserDailyFirstAndLastLogin T_USER_DAILY_FIRST_AND_LAST_LOGIN = com.tencent.devops.model.project.tables.TUserDailyFirstAndLastLogin.T_USER_DAILY_FIRST_AND_LAST_LOGIN;

    /**
     * The table <code>devops_project.T_USER_DAILY_LOGIN</code>.
     */
    public static final TUserDailyLogin T_USER_DAILY_LOGIN = com.tencent.devops.model.project.tables.TUserDailyLogin.T_USER_DAILY_LOGIN;
}
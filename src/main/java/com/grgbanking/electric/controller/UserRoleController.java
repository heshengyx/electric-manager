package com.grgbanking.electric.controller;

import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grgbanking.electric.data.UserRoleData;
import com.grgbanking.electric.entity.UserRole;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.UserRoleQueryParam;
import com.grgbanking.electric.service.IUserRoleService;


@Controller
@RequestMapping("/manager/userRole")
public class UserRoleController extends BaseController {
    
    private final static Logger LOGGER = LoggerFactory
            .getLogger(UserRoleController.class);

    @Autowired
    private IUserRoleService userRoleService;
    
    @RequestMapping("")
    public String page() {
        return "userRole";
    }
    
    @RequestMapping("/list")
    public String list() {
        return "userRoleList";
    }
    
    @RequestMapping("/query")
    @ResponseBody
    public Object query(UserRoleQueryParam param) {
        return userRoleService.query(param);
    }
    
    @RequestMapping("/queryAll")
    @ResponseBody
    public Object queryAll(UserRoleQueryParam param) {
        return userRoleService.queryAll(param);
    }
    
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public Object saveOrUpdate(UserRole UserRole) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            UserRole.setCreateBy(user.getAccount());
            UserRole.setUpdateBy(user.getAccount());
            userRoleService.saveOrUpdate(UserRole);
            jMessage.setStatus(Boolean.TRUE);
        } catch (Exception e) {
            LOGGER.error("保存数据失败", e);
            jMessage.setStatus(Boolean.FALSE);
            if (e instanceof DataAccessResourceFailureException) {
                jMessage.setMessage(e.getMessage());
            } else {
                jMessage.setMessage("系统异常");
            }
        }
        return jMessage;
    }
    
    @RequestMapping("/saveBatch")
    @ResponseBody
    public Object saveBatch(UserRoleData data) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            data.setCreateBy(user.getAccount());
            userRoleService.saveBatchData(data);
            jMessage.setStatus(Boolean.TRUE);
        } catch (Exception e) {
            LOGGER.error("保存数据失败", e);
            jMessage.setStatus(Boolean.FALSE);
            if (e instanceof DataAccessResourceFailureException) {
                jMessage.setMessage(e.getMessage());
            } else {
                jMessage.setMessage("系统异常");
            }
        }
        return jMessage;
    }
    
    @RequestMapping("/deleteBatch")
    @ResponseBody
    public Object deleteBatch(String ids) {
        JSONMessage jMessage = new JSONMessage();
        try {
            userRoleService.deleteByIds(Arrays.asList(StringUtils
                    .commaDelimitedListToStringArray(ids)));
            jMessage.setStatus(Boolean.TRUE);
        } catch (Exception e) {
            LOGGER.error("删除数据失败", e);
            jMessage.setStatus(Boolean.FALSE);
            if (e instanceof DataAccessResourceFailureException) {
                jMessage.setMessage(e.getMessage());
            } else {
                jMessage.setMessage("系统异常");
            }
        }
        return jMessage;
    }
    
    @RequestMapping("/getById")
    @ResponseBody
    public Object getById(String id) {
        JSONMessage jMessage = new JSONMessage();
        try {
            UserRole data = userRoleService.getById(id);
            jMessage.setStatus(Boolean.TRUE);
            jMessage.setData(data);
        } catch (Exception e) {
            LOGGER.error("获取数据失败", e);
            jMessage.setStatus(Boolean.FALSE);
            if (e instanceof DataAccessResourceFailureException) {
                jMessage.setMessage(e.getMessage());
            } else {
                jMessage.setMessage("系统异常");
            }
        }
        return jMessage;
    }
}

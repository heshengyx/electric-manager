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

import com.grgbanking.electric.data.RolePermissionData;
import com.grgbanking.electric.entity.RolePermission;
import com.grgbanking.electric.entity.User;
import com.grgbanking.electric.json.JSONMessage;
import com.grgbanking.electric.param.RolePermissionQueryParam;
import com.grgbanking.electric.service.IRolePermissionService;


@Controller
@RequestMapping("/manager/rolePermission")
public class RolePermissionController extends BaseController {
    
    private final static Logger LOGGER = LoggerFactory
            .getLogger(RolePermissionController.class);

    @Autowired
    private IRolePermissionService rolePermissionService;
    
    @RequestMapping("")
    public String page() {
        return "rolePermission";
    }
    
    @RequestMapping("/list")
    public String list() {
        return "rolePermissionList";
    }
    
    @RequestMapping("/query")
    @ResponseBody
    public Object query(RolePermissionQueryParam param) {
        return rolePermissionService.query(param);
    }
    
    @RequestMapping("/queryAll")
    @ResponseBody
    public Object queryAll(RolePermissionQueryParam param) {
        return rolePermissionService.queryAll(param);
    }
    
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public Object saveOrUpdate(RolePermission RolePermission) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            RolePermission.setCreateBy(user.getAccount());
            RolePermission.setUpdateBy(user.getAccount());
            rolePermissionService.saveOrUpdate(RolePermission);
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
    public Object saveBatch(RolePermissionData data) {
        User user = getCurrentUser();
        JSONMessage jMessage = new JSONMessage();
        try {
            data.setCreateBy(user.getAccount());
            rolePermissionService.saveBatchData(data);
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
            rolePermissionService.deleteByIds(Arrays.asList(StringUtils
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
            RolePermission data = rolePermissionService.getById(id);
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

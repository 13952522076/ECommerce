/*
 * Copyright 2012-2014 sammyun.com.cn. All rights reserved.
 * Support: http://www.sammyun.com.cn
 * License: http://www.sammyun.com.cn/license
 */
package com.sammyun.controller.console;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sammyun.entity.Admin;
import com.sammyun.service.AdminService;

/**
 * Controller - 个人资料
 * 
 * @author Sencloud Team
 * @version 3.0
 */
@Controller("adminProfileController")
@RequestMapping("/console/profile")
public class ProfileController extends BaseController
{

    @Resource(name = "adminServiceImpl")
    private AdminService adminService;

    /**
     * 验证当前密码
     */
    @RequestMapping(value = "/check_current_password", method = RequestMethod.GET)
    public @ResponseBody
    boolean checkCurrentPassword(String currentPassword)
    {
        if (StringUtils.isEmpty(currentPassword))
        {
            return false;
        }
        Admin admin = adminService.getCurrent();
        if (StringUtils.equals(DigestUtils.md5Hex(currentPassword), admin.getPassword()))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    /**
     * 编辑
     */
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String edit(ModelMap model)
    {
        model.addAttribute("admin", adminService.getCurrent());
        return "/console/profile/edit";
    }

    /**
     * 更新
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(String currentPassword,String iconPhoto, String password, String email, RedirectAttributes redirectAttributes)
    {
        if (!isValid(Admin.class, "email", email))
        {
            return ERROR_VIEW;
        }
        Admin pAdmin = adminService.getCurrent();
        if (StringUtils.isNotEmpty(currentPassword) && StringUtils.isNotEmpty(password))
        {
            if (!isValid(Admin.class, "password", password))
            {
                return ERROR_VIEW;
            }
            if (!StringUtils.equals(DigestUtils.md5Hex(currentPassword), pAdmin.getPassword()))
            {
                return ERROR_VIEW;
            }
            pAdmin.setPassword(DigestUtils.md5Hex(password));
        }
        pAdmin.setEmail(email);
        pAdmin.setIconPhoto(iconPhoto);
        adminService.update(pAdmin);
        addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
        return "redirect:edit.ct";
    }

}

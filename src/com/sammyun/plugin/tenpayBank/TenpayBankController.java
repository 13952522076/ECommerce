/*
 * Copyright 2012-2014 sammyun.com.cn. All rights reserved.
 * Support: http://www.sammyun.com.cn
 * License: http://www.sammyun.com.cn/license
 */
package com.sammyun.plugin.tenpayBank;

import java.math.BigDecimal;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sammyun.Message;
import com.sammyun.controller.console.BaseController;
import com.sammyun.entity.PluginConfig;
import com.sammyun.plugin.PaymentPlugin;
import com.sammyun.plugin.PaymentPlugin.FeeType;
import com.sammyun.service.PluginConfigService;

/**
 * Controller - 财付通(网银直连)
 * 
 * @author Sencloud Team
 * @version 3.0
 */
@Controller("adminTenpayBankController")
@RequestMapping("/console/payment_plugin/tenpay_bank")
public class TenpayBankController extends BaseController
{

    @Resource(name = "tenpayBankPlugin")
    private TenpayBankPlugin tenpayBankPlugin;

    @Resource(name = "pluginConfigServiceImpl")
    private PluginConfigService pluginConfigService;

    /**
     * 安装
     */
    @RequestMapping(value = "/install", method = RequestMethod.POST)
    public @ResponseBody
    Message install()
    {
        if (!tenpayBankPlugin.getIsInstalled())
        {
            PluginConfig pluginConfig = new PluginConfig();
            pluginConfig.setPluginId(tenpayBankPlugin.getId());
            pluginConfig.setIsEnabled(false);
            pluginConfigService.save(pluginConfig);
        }
        return SUCCESS_MESSAGE;
    }

    /**
     * 卸载
     */
    @RequestMapping(value = "/uninstall", method = RequestMethod.POST)
    public @ResponseBody
    Message uninstall()
    {
        if (tenpayBankPlugin.getIsInstalled())
        {
            PluginConfig pluginConfig = tenpayBankPlugin.getPluginConfig();
            pluginConfigService.delete(pluginConfig);
        }
        return SUCCESS_MESSAGE;
    }

    /**
     * 设置
     */
    @RequestMapping(value = "/setting", method = RequestMethod.GET)
    public String setting(ModelMap model)
    {
        PluginConfig pluginConfig = tenpayBankPlugin.getPluginConfig();
        model.addAttribute("feeTypes", FeeType.values());
        model.addAttribute("pluginConfig", pluginConfig);
        model.addAttribute("menuId", PaymentPlugin.class.getSimpleName());
        return "/com/sammyun/plugin/tenpayBank/setting";
    }

    /**
     * 更新
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(ModelMap model,String paymentName, String partner, String key, FeeType feeType, BigDecimal fee, String logo,
            String description, @RequestParam(defaultValue = "false") Boolean isEnabled, Integer order,
            RedirectAttributes redirectAttributes)
    {
        PluginConfig pluginConfig = tenpayBankPlugin.getPluginConfig();
        pluginConfig.setAttribute(PaymentPlugin.PAYMENT_NAME_ATTRIBUTE_NAME, paymentName);
        pluginConfig.setAttribute("partner", partner);
        pluginConfig.setAttribute("key", key);
        pluginConfig.setAttribute(PaymentPlugin.FEE_TYPE_ATTRIBUTE_NAME, feeType.toString());
        pluginConfig.setAttribute(PaymentPlugin.FEE_ATTRIBUTE_NAME, fee.toString());
        pluginConfig.setAttribute(PaymentPlugin.LOGO_ATTRIBUTE_NAME, logo);
        pluginConfig.setAttribute(PaymentPlugin.DESCRIPTION_ATTRIBUTE_NAME, description);
        pluginConfig.setIsEnabled(isEnabled);
        pluginConfig.setOrder(order);
        model.addAttribute("menuId", PaymentPlugin.class.getSimpleName());
        pluginConfigService.update(pluginConfig);
        addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
        return "redirect:/console/payment_plugin/list.ct";
    }

}

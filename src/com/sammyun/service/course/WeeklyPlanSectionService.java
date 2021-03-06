package com.sammyun.service.course;

import java.util.List;

import com.sammyun.Order;
import com.sammyun.entity.course.SchoolYearMng;
import com.sammyun.entity.course.WeeklyPlanSection;
import com.sammyun.entity.dict.DictClass;
import com.sammyun.entity.dict.DictSchool;
import com.sammyun.service.BaseService;

/**
 * Service - 周计划段
 * 
 * @version [版本号, Apr 13, 2015]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
public interface WeeklyPlanSectionService extends BaseService<WeeklyPlanSection, Long>
{

    /**
     * 根据班级和校历查询周计划列表 <功能详细描述>
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    List<WeeklyPlanSection> findByClassAndSchoolYear(DictSchool dictSchool,SchoolYearMng schoolYearMng, DictClass dictClass,
            List<Order> orders);
    
    /**
     * 根据学校找到当前学校的周计划
     * @param dictSchool
     * @return
     * @see [类、类#方法、类#成员]
     */
    List<WeeklyPlanSection> findBySchool(DictSchool dictSchool);
    
    /**
     * 根据班级找到当前学校的周计划
     * <功能详细描述>
     * @param dictClass
     * @return
     * @see [类、类#方法、类#成员]
     */
    List<WeeklyPlanSection> findByClass(DictClass dictClass);
    
    /**
     * 根据校历找到当前学校的周计划
     * <功能详细描述>
     * @param schoolYearMng
     * @return
     * @see [类、类#方法、类#成员]
     */
    List<WeeklyPlanSection> findBySchoolYearMng(SchoolYearMng schoolYearMng);
    
    /**
     * Job定时器判断是否为当前时间，
     * <功能详细描述>
     * @see [类、类#方法、类#成员]
     */
    void changeIsCurrent();
    
}

package com.sammyun.dao.parenting;

import java.util.List;

import com.sammyun.Page;
import com.sammyun.Pageable;
import com.sammyun.dao.BaseDao;
import com.sammyun.entity.dict.DictSchool;
import com.sammyun.entity.news.News;
import com.sammyun.entity.news.NewsCategory;
import com.sammyun.entity.parenting.Parenting;
import com.sammyun.entity.parenting.ParentingCategory;

/**
 * Parenting * Dao - 育儿模块
 * 
 * @author Sencloud Team
 * @version 3.0
 */
public interface ParentingDao extends BaseDao<Parenting, Long> {
    
    /**
     * 根据新闻类别查询
     */
  //  public Page<News> findBySchool(NewsCategory newsCategory,Integer status,Pageable pageable);
    /**
     * 根据类别，学校查询出当前类别的置顶数
     * @param parentingCategory
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Long findIsTopCountByCategory(ParentingCategory parentingCategory,DictSchool dictSchool);
    
    /**
     * 查询出当前学校的置顶数
     * 
     * @param dictSchool
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Long findIsTopCount();
    
    /**
     * 根据学校查询出置顶的新闻
     * 
     * @param dictSchool
     * @return
     * @see [类、类#方法、类#成员]
     */
    public List<Parenting> findBySchool(DictSchool dictSchool,Boolean isTop,Integer status,Integer categoryDefFlag,Integer categoryStatus);

    /**
     * 根据分类查询出分类下的非置顶育儿新闻
     * 分类为未删除且上架
     * @param parentingCategory
     * @param status
     * @param isTop
     * @param pageable
     * @return
     * @see [类、类#方法、类#成员]
     */
    public Page<Parenting> findByCategory(ParentingCategory parentingCategory,Boolean isTop,Integer status,Pageable pageable);

    /**
     * 根据分类查找相关的育儿新闻
     * <功能详细描述>
     * @param parentingCategory
     * @return
     * @see [类、类#方法、类#成员]
     */
    public  List<Parenting> findByCategory(ParentingCategory parentingCategory,Boolean isTop);
}

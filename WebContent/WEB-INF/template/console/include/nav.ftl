[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!--  导航 -->
<style type="text/css">
	.fa-li-width:{
		width:20px;
	}
</style>
<script type="text/javascript">
	function changeNavHeight(){
		var height = $("#page-wrapper").height();
		var navHeight = $("#leftSideNavbar").height();
		//alert(height);
		if(height!=null&&navHeight!=null){
			if(height>navHeight){
				$("#leftSideNavbar").height(height);
			}
		}
	}
	$().ready(function() {
		changeNavHeight();
	});	
	$(window).resize(function(){
	  	changeNavHeight();
 	});
 	window.onload = function (){ 
 		changeNavHeight();
 	}
</script>
<nav id="leftSideNavbar" class="navbar-default navbar-static-side navbar-background" role="navigation" style="overflow-y: visible;">
    <div class="sidebar-collapse">
        <ul class="nav" id="side-menu">
            <li class="nav-header" style="width:200px;">
                <div class="dropdown profile-element" style="margin-left: 20px;"> 
                	<span>
                    	<img alt="image" class="img-circle" src="
                    	[#if Session["iconPhoto"]??]
                    	${Session['iconPhoto']}
                    	[#else]
                    	${base}/resources/console/images/userAvatar.jpg
                    	[/#if]
                    	" width="70px" height="70px"/>
                 	</span>
                    <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                        <span class="clear"> 
                            <span class="block m-t-xs"> 
                                <strong class="font-bold"></strong>
                            </span>  
                            <span class="text-muted text-xs block">
                            	${Session["schoolName"]} <br>  
								${Session["realName"]}  
                                <b class="caret"></b>
                            </span>
                        </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight m-t-xs">
                        <li>
                            <a href="${base}/console/profile/edit.ct" >${message("console.main.personalData")}</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="${base}/console/logout.jsp">[${message("console.main.logout")}]</a>
                        </li>
                    </ul>
                </div>
                <div class="logo-element">
                    ${message("console.common.title")}
                </div>
            </li>
            <!-- start 老师/家长管理 -->
           	<!--
            <li name="menu">
               [#list ["console:member","console:memberPatriarch"] as permission]
                   [@shiro.hasPermission name = permission]
                    <a href="index.html">
                       <i class="fa fa-user-plus"></i> 
                       <span class="nav-label">${message("console.main.memberNav")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                    [#break /]
					[/@shiro.hasPermission]
                [/#list]
                
                <ul class="nav nav-second-level">
                    [@shiro.hasPermission name="console:member"]
                        <li id="menu.Member">
                          <a href="${base}/console/member/list.ct?memberType=teacher" >${message("console.main.member")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    
                </ul>
            </li>
            -->
            <!-- end 老师/家长管理 -->
            <!--start 校园管理 -->
            <li name="menu">
               [#list ["console:dictSchool","console:dictGrade","console:dictClass","console:teacher","console:patriarch","console:dictStudent"] as permission]
                   [@shiro.hasPermission name = permission]
                    <a href="index.html">
                       <i class="fa fa-university fa-li-width"></i> 
                       <span class="nav-label">${message("console.main.schoolNav")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                    [#break /]
					[/@shiro.hasPermission]
                [/#list]
                
                <ul class="nav nav-second-level">
                    <!-- start 学校管理 -->
					[@shiro.hasPermission name="console:dictSchool"]
						<li id="menu.DictSchool">
							<a href="${base}/console/dict_school/list.ct" >${message("console.main.dictSchool")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 学校管理 -->
					
					<!-- start 年级管理 -->
					[@shiro.hasPermission name="console:dictGrade"]
						<li id="menu.DictGrade">
							<a href="${base}/console/dict_grade/list.ct" >${message("年级管理")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 年级管理 -->
					
					<!-- start 班级管理 -->
					[@shiro.hasPermission name="console:dictClass"]
						<li id="menu.DictClass">
							<a href="${base}/console/dict_class/list.ct" >${message("console.main.dictClass")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 班级管理 -->
					<!-- start教师管理 -->
					[@shiro.hasPermission name="console:teacher"]
                        <li id="menu.Member">
                          <a href="${base}/console/teacher/list.ct?memberType=teacher" >${message("console.main.member")}</a>
                        </li>
                    [/@shiro.hasPermission]
					<!-- end  教师管理 -->
					<!--start家长管理 -->
					[@shiro.hasPermission name="console:patriarch"]
                        <li id="menu.MemberPatriarch">
                          <a href="${base}/console/member/list.ct?memberType=patriarch" >${message("console.main.memberPatriarch")}</a>
                        </li>
                    [/@shiro.hasPermission]
					<!-- end  家长管理 -->
					<!-- start 学生管理 -->
					[@shiro.hasPermission name="console:dictStudent"]
						<li id="menu.DictStudent">
							<a href="${base}/console/dict_student/list.ct" >${message("console.main.dictStudent")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 学生管理 -->
                </ul>
            </li>
            <!-- end 校园管理 -->
            
            <!--start 培训管理 -->
            <li name="menu">
               [#list ["console:consultingManagement","console:appPushMsg"] as permission]
                   [@shiro.hasPermission name = permission]
                    <a href="index.html">
                       <i class="fa fa-building fa-li-width"></i> 
                       <span class="nav-label">${message("console.main.xstPraining")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                    [#break /]
					[/@shiro.hasPermission]
                [/#list]
                
                <ul class="nav nav-second-level">
                    <!-- start 咨询管理 -->
					[@shiro.hasPermission name="console:consultingManagement"]
						<li id="menu.ConsultationStudent">
							<a href="${base}/console/consultingManagement/list.ct" >${message("console.main.consultingManagement")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 咨询管理 -->
				 	<!-- start 图文消息 -->
					[@shiro.hasPermission name="console:appPushMsg"]
						<li id="menu.AppPushMsg">
							<a href="${base}/console/AppPushMsg/list.ct" >${message("console.main.AppPushMsg")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 图文消息 -->
                </ul>
            </li>
            <!-- end 培训管理 -->
            
            
            <!--start 课程表管理 -->
            <li name="menu">
               [#list ["console:curriculumSchedule","console:courseName","console:schoolYearMng","console:qualityCourse"] as permission]
                   [@shiro.hasPermission name = permission]
                    <a href="index.html">
                       <i class="fa fa-calendar fa-li-width"></i> 
                       <span class="nav-label">${message("console.main.curriculumScheduleNav")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                    [#break /]
					[/@shiro.hasPermission]
                [/#list]
                
                <ul class="nav nav-second-level">
                    <!-- start 周计划管理 -->
					[@shiro.hasPermission name="console:weeklyPlanSection"]
						<li id="menu.WeeklyPlanSection">
							<a href="${base}/console/weekly_plan_section/list.ct" >${message("console.main.weeklyPlanSection")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 周计划管理 -->
					
					<!-- start 精品课程 -->
					[@shiro.hasPermission name="console:qualityCourse"]
						<li id="menu.QualityCourse">
							<a href="${base}/console/quality_course/list.ct" >${message("console.main.qualityCourse")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 精品课程 -->
					
					
                
                    <!-- start 课程表管理 -->
					[@shiro.hasPermission name="console:curriculumSchedule"]
						<li id="menu.CurriculumSchedule">
							<a href="${base}/console/curriculum_schedule/list.ct" >${message("console.main.curriculumSchedule")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 课程表管理 -->
					
					<!-- start 课程管理 -->
					[@shiro.hasPermission name="console:courseName"]
						<!--<li id="menu.CourseName">
							<a href="${base}/console/course_name/list.ct" >${message("console.main.courseName")}</a>
						</li>-->
					[/@shiro.hasPermission]
					<!-- end 课程管理 -->
					
					<!-- start 教学年管理 -->
					[@shiro.hasPermission name="console:schoolYearMng"]
						<li id="menu.SchoolYearMng">
							<a href="${base}/console/school_year_mng/list.ct" >${message("console.main.schoolYearMng")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 教学年管理 -->
                </ul>
            </li>
            <!-- end 校园管理 -->
            
            
            <!-- start考勤管理 -->
            <li name="menu">
                [#list ["console:attendance","console:askLeave","console:attendanceEquipment","console:schoolHours"] as permission]
                   [@shiro.hasPermission name = permission]
                    <a href="#">
                       <i class="glyphicon glyphicon-list-alt fa-li-width"></i>
                       <span class="nav-label">${message("console.main.attendanceGroup")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                    [#break /]
					[/@shiro.hasPermission]
                [/#list]
                 <ul class="nav nav-second-level">
                    [@shiro.hasPermission name="console:attendance"]
                        <li id="menu.Attendance">
                            <a href="${base}/console/attendance/list.ct">${message("console.main.attendance")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:askLeave"]
                        <li id="menu.AskLeave">
                            <a href="${base}/console/askLeave/list.ct">${message("console.main.askLeave")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:teacherAskLeave"]
                        <li id="menu.TeacherAskLeave">
                            <a href="${base}/console/teacherAskLeave/list.ct">${message("教师请假列表")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:attendanceEquipment"]
                        <li id="menu.AttendanceEquipment">
                            <a href="${base}/console/attendance_equipment/list.ct">${message("console.main.attendanceEquipment")}</a>
                        </li>
                    [/@shiro.hasPermission]
                 	[@shiro.hasPermission name="console:workSetting"]
                        <li id="menu.WorkSetting">
                            <a href="${base}/console/workSetting/list.ct">${message("班次管理")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:workScheduling"]
                        <li id="menu.WorkScheduling">
                            <a href="${base}/console/workScheduling/list.ct">${message("排班管理")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:teacherAttendance"]
                        <li id="menu.TeacherAttendance">
                            <a href="${base}/console/teacherAttendance/list.ct">${message("教师考勤")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:attendanceStatistics"]
                        <li id="menu.AttendanceStatistics">
                            <a href="${base}/console/attendance_statistics/list.ct">${message("console.main.attendanceStatistics")}</a>
                        </li>
                    [/@shiro.hasPermission]
                   [@shiro.hasPermission name="console:schoolHours"] 
                        <li id="menu.SchoolHours">
                            <a href="${base}/console/school_hours/list.ct">${message("校园上学放学时间管理")}</a>
                        </li>
                   [/@shiro.hasPermission] 
                    
                </ul>
            </li>
            <!-- end考勤管理 -->
            
            <!-- start评价管理 -->
             <li name="menu">
                 [#list ["console:meritTemplate","console:overallMerit"] as permission]
                   [@shiro.hasPermission name = permission] 
                    <a  href="index.html">
                       <i class="fa fa-star fa-li-width"></i>
                       <span class="nav-label">${message("console.main.appraisal")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                   [#break /]
					[/@shiro.hasPermission]
                [/#list]
                 <ul class="nav nav-second-level">
                     [@shiro.hasPermission name="console:meritTemplate"] 
                        <li id="menu.MeritTemplate">
                            <a href="${base}/console/merit_template/list.ct">${message("console.role.meritTemplate")}</a>
                        </li>
                    [/@shiro.hasPermission] 
                            [@shiro.hasPermission name="console:overallMerit"] 
                        <li id="menu.OverallMerit">
                            <a href="${base}/console/overall_merit/list.ct">${message("console.role.overallMerit")}</a>
                        </li>
                   [/@shiro.hasPermission] 
                </ul>
            </li>
            <!-- end评价管理 -->
            
            <!-- start食谱管理 -->
            <li name="menu">
                [#list ["console:recipes"] as permission]
                   [@shiro.hasPermission name = permission]
                    <a  href="index.html">
                       <i class="fa fa-heart fa-li-width"></i>
                       <span class="nav-label">${message("console.main.RecipeManagement")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                    [#break /]
					[/@shiro.hasPermission]
                [/#list]
                 <ul class="nav nav-second-level">
                    [@shiro.hasPermission name="console:recipes"]
                        <li id="menu.Recipe">
                            <a href="${base}/console/recipe/list.ct">${message("console.main.Recipe")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    <!--
                    [@shiro.hasPermission name="console:recipesSection"]
                        <li id="menu.RecipeSection">
                            <a href="${base}/console/recipe_section/list.ct">${message("console.main.RecipeSectionManager")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    -->
                    <!--
                    [@shiro.hasPermission name="console:recipesWeek"]
                        <li id="menu.RecipesWeek">
                            <a href="${base}/console/recipesWeek/list.ct">${message("console.main.RecipeWeekManager")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    -->
                </ul>
            </li>
             <!-- end食谱管理 -->
             
             <!-- start圈子管理-->
             <li name="menu">
                 [#list ["console:growthDiary","console:diaryTag","console:diaryPicture"] as permission]
                   [@shiro.hasPermission name = permission] 
                    <a  href="index.html">
                       <i class="fa fa-area-chart fa-li-width"></i>
                       <span class="nav-label">${message("圈子管理")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                   [#break /]
					[/@shiro.hasPermission]
                [/#list]
                 <ul class="nav nav-second-level">
                     [@shiro.hasPermission name="console:growthDiary"] 
                        <li id="menu.GrowthDiary">
                            <a href="${base}/console/growthDiary/list.ct">${message("圈子管理")}</a>
                        </li>
                    [/@shiro.hasPermission] 
                    [@shiro.hasPermission name="console:diaryTag"] 
                        <li id="menu.DiaryTag">
                            <a href="${base}/console/diaryTag/list.ct">${message("圈子标签管理")}</a>
                        </li>
                   	[/@shiro.hasPermission] 
                    [@shiro.hasPermission name="console:diaryPicture"] 
                        <li id="menu.DiaryPicture">
                            <a href="${base}/console/diaryPicture/list.ct">${message("圈子图片管理")}</a>
                        </li>
                   [/@shiro.hasPermission] 
                </ul>
            </li>
             <!-- end  圈子管理-->
             
             <!-- start  内容管理 -->
             <li name="menu">
                [#list ["console:news", "console:announcement","console:profile","console:campusviewImg","console:poster","console:parenting"] as permission]
                   [@shiro.hasPermission name = permission]
                        <a  href="index.html">
                           <i class="fa fa-edit fa-li-width"></i>
                           <span class="nav-label">${message("console.main.contentGroup")}</span>
                           <span class="fa arrow"></span>
                        </a>
                    [#break /]
					[/@shiro.hasPermission]
                 [/#list]
                <ul class="nav nav-second-level">
                    [@shiro.hasPermission name="console:poster"]
                        <li id="menu.Poster">
                            <a href="${base}/console/poster/list.ct" >${message("console.main.poster")}</a>
                        </li>
                    [/@shiro.hasPermission]
                   [@shiro.hasPermission name="console:news"]
                        <li id="menu.News">
                            <a href="${base}/console/news/list.ct" >${message("console.main.news")}</a>
                        </li>
                   [/@shiro.hasPermission]
                   [@shiro.hasPermission name="console:parenting"]
                        <li id="menu.Parenting">
                            <a href="${base}/console/parenting/list.ct" >${message("育儿中心")}</a>
                        </li>
                   [/@shiro.hasPermission]
                   [@shiro.hasPermission name="console:announcement"]
                        <li id="menu.Announcement">
                            <a href="${base}/console/announcement/list.ct" >${message("console.main.announcement")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:profile"]
                        <li id="menu.Profile">
                            <a href="${base}/console/campus_profile/edit.ct" >${message("console.main.profile")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:campusviewImg"]
                        <li id="menu.CampusviewImg">
                            <a href="${base}/console/campusview_img/list.ct" >${message("console.main.campusviewImg")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:classAlbumImage"]
                        <li id="menu.ClassAlbumImage">
                            <a href="${base}/console/classAlbumImage/list.ct" >${message("班级相册")}</a>
                        </li>
                    [/@shiro.hasPermission]
                </ul>
            </li>
         	<!-- end 内容管理 -->
            
            <!-- start营销管理 
            <li name="menu">
                [#list ["console:seo", "console:sitemap"] as permission]
                   [@shiro.hasPermission name = permission]
                        <a  href="index.html">
                           <i class="fa fa-bar-chart-o"></i>
                           <span class="nav-label">${message("console.main.marketingGroup")}</span>
                           <span class="fa arrow"></span>
                        </a>
                    [#break /]
					[/@shiro.hasPermission]
                 [/#list]
                <ul class="nav nav-second-level">
                   [@shiro.hasPermission name="console:seo"]
                        <li id="menu.Seo">
                            <a href="${base}/console/seo/list.ct" >${message("console.main.seo")}</a>
                        </li>
                   [/@shiro.hasPermission]
                   [@shiro.hasPermission name="console:sitemap"]
                        <li id="menu.Sitemap">
                            <a href="${base}/console/sitemap/build.ct" >${message("console.main.sitemap")}</a>
                        </li>
                    [/@shiro.hasPermission]
                </ul>
            </li>-->
            <!-- end营销管理 -->
         	<!-- start反馈管理 -->
            <li name="menu">
                [#list ["console:systemSuggest"] as permission]
                   [@shiro.hasPermission name = permission]
                    <a  href="index.html">
                       <i class="fa fa-envelope-o fa-li-width"></i>
                       <span class="nav-label">${message("反馈管理")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                    [#break /]
					[/@shiro.hasPermission]
                [/#list]
                 <ul class="nav nav-second-level">
                    [@shiro.hasPermission name="console:systemSuggest"]
                        <li id="menu.SystemSuggest">
                            <a href="${base}/console/systemSuggest/list.ct">${message("意见反馈")}</a>
                        </li>
                    [/@shiro.hasPermission]
                </ul>
            </li>
         	<!-- end反馈管理 -->
         	<!-- start  应用管理 -->
             <li name="menu">
                [#list ["console:app", "console:appRole","console:appCategory","console:appClientVersion","console:appPoster"] as permission]
                   [@shiro.hasPermission name = permission]
                        <a  href="index.html">
                           <i class="fa fa-skyatlas fa-li-width"></i>
                           <span class="nav-label">${message("应用市场")}</span>
                           <span class="fa arrow"></span>
                        </a>
                    [#break /]
					[/@shiro.hasPermission]
                 [/#list]
                <ul class="nav nav-second-level">
                    [@shiro.hasPermission name="console:app"]
                        <li id="menu.App">
                            <a href="${base}/console/app/list.ct" >${message("console.main.app")}</a>
                        </li>
                    [/@shiro.hasPermission]
                   [@shiro.hasPermission name="console:appRole"]
                        <li id="menu.AppRole">
                            <a href="${base}/console/app_role/list.ct" >${message("console.main.appRole")}</a>
                        </li>
                   [/@shiro.hasPermission]
                   [@shiro.hasPermission name="console:appCategory"]
                        <li id="menu.AppCategory">
                            <a href="${base}/console/app_category/list.ct" >${message("console.main.appCategory")}</a>
                        </li>
                   [/@shiro.hasPermission]
                   [@shiro.hasPermission name="console:appClientVersion"]
                        <li id="menu.AppClientVersion">
                            <a href="${base}/console/app_client_version/list.ct" >${message("console.main.appClientVersion")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:appPoster"]
                        <li id="menu.AppPoster">
                            <a href="${base}/console/app_poster/list.ct" >${message("console.main.appPoster")}</a>
                        </li>
                    [/@shiro.hasPermission]
                </ul>
            </li>
         	<!-- end 应用管理 -->
         	<!-- start 广告管理-->
         	<li name="menu">
                [#list ["console:ad","console:adCategory"] as permission]
                   [@shiro.hasPermission name = permission]
                        <a  href="index.html">
                           <i class="fa fa-link fa-li-width"></i>
                           <span class="nav-label">${message("广告管理")}</span>
                           <span class="fa arrow"></span>
                        </a>
                    [#break /]
					[/@shiro.hasPermission]
                 [/#list]
                <ul class="nav nav-second-level">
                    [@shiro.hasPermission name="console:ad"]
                        <li id="menu.Ad">
                            <a href="${base}/console/ad/list.ct" >${message("广告管理")}</a>
                        </li>
                    [/@shiro.hasPermission]
                    [@shiro.hasPermission name="console:adCategory"]
                        <li id="menu.AdCategory">
                            <a href="${base}/console/adCategory/list.ct" >${message("广告类别")}</a>
                        </li>
                    [/@shiro.hasPermission]
                </ul>
            </li>
         	<!-- end   广告管理-->
         	 <!--start 营销管理 -->
            <li name="menu">
               [#list ["console:coupon","console:couponCode","console:giftItem","console:promotion"] as permission]
                   [@shiro.hasPermission name = permission]
                    <a href="index.html">
                       <i class="fa fa-bar-chart-o fa-li-width"></i> 
                       <span class="nav-label">${message("营销管理")}</span> 
                       <span class="fa arrow"></span>
                    </a>
                    [#break /]
					[/@shiro.hasPermission]
                [/#list]
                
                <ul class="nav nav-second-level">
                    <!-- start 优惠券管理 -->
					[@shiro.hasPermission name="console:coupon"]
						<li id="menu.Coupon">
							<a href="${base}/console/coupon/list.ct" >${message("优惠券")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 优惠券管理 -->
					
					<!-- start 优惠券码 -->
					[@shiro.hasPermission name="console:couponCode"]
						<li id="menu.CouponCode">
							<a href="${base}/console/coupon_code/list.ct" >${message("优惠券码")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 优惠券码 -->
                
                    <!-- start 赠品项 -->
					[@shiro.hasPermission name="console:giftItem"]
						<li id="menu.GiftItem">
							<a href="${base}/console/giftItem/list.ct" >${message("赠品项")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 赠品项 -->
					
					<!-- start 促销管理 -->
					[@shiro.hasPermission name="console:promotion"]
					    <li id="menu.Promotion">
							<a href="${base}/console/promotion/list.ct" >${message("促销管理")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 促销管理 -->
					
					<!-- start 营销模板管理 -->
					[@shiro.hasPermission name="console:promotionTemplate"]
					    <li id="menu.PromotionTemplate">
							<a href="${base}/console/promotionTemplate/list.ct" >${message("营销模板管理")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 营销模板管理 -->
					<!-- start 会员等级 -->
					[@shiro.hasPermission name="console:memberRank"]
					    <li id="menu.MemberRank">
							<a href="${base}/console/memberRank/list.ct" >${message("会员等级")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 会员等级 -->
					<!-- start 积分来源 -->
					[@shiro.hasPermission name="console:pointBill"]
					    <li id="menu.PointBill">
							<a href="${base}/console/pointBill/list.ct" >${message("积分来源")}</a>
						</li>
					[/@shiro.hasPermission]
					<!-- end 积分来源 -->
                </ul>
            </li>
            <!-- end 营销管理 -->
            <!-- start 系统设置 -->
            <li name="menu">
               [#list ["console:setting", "console:area", "console:paymentPlugin", "console:storagePlugin", "console:admin", "console:role", "console:log"] as permission]
                    [@shiro.hasPermission name = permission]
                        <a href="index.html">
                        	<i class="fa fa-desktop fa-li-width"></i> 
                        	<span class="nav-label">${message("console.main.systemGroup")}</span>  
                            <span class="fa arrow"></span>
                        </a>
                        [#break /]
					[/@shiro.hasPermission]
               [/#list]
                <ul class="nav nav-second-level" style="  opacity: 1;background-color: #95CEE8;">
                    [@shiro.hasPermission name="console:setting"]
						<li id="menu.Setting">
							<a href="${base}/console/setting/edit.ct" >${message("console.main.setting")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:systemDict"]
						<li id="menu.SystemDict">
							<a href="${base}/console/systemDict/list.ct" >${message("系统字典")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:area"]
						<li id="menu.Area">
							<a href="${base}/console/area/list.ct" >${message("console.main.area")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:paymentPlugin"]
						<li id="menu.PaymentPlugin">
							<a href="${base}/console/payment_plugin/list.ct" >${message("console.main.paymentPlugin")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:storagePlugin"]
						<li id="menu.StoragePlugin">
							<a href="${base}/console/storage_plugin/list.ct" >${message("console.main.storagePlugin")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:messagePushPlugin"]
						<li id="menu.MessagePushPlugin">
							<a href="${base}/console/message_push_plugin/list.ct" >${message("console.main.messagePushPlugin")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:pointPlugin"]
						<li id="menu.PointPlugin">
							<a href="${base}/console/point_plugin/list.ct" >${message("console.main.pointPlugin")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:admin"]
						<li id="menu.Admin">
							<a href="${base}/console/admin/list.ct" >${message("console.main.admin")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:role"]
						<li id="menu.Role">
							<a href="${base}/console/role/list.ct" >${message("console.main.role")}</a>
						</li>
					[/@shiro.hasPermission]
					[@shiro.hasPermission name="console:log"]
						<li id="menu.Log">
							<a href="${base}/console/log/list.ct" >${message("console.main.log")}</a>
						</li>
					[/@shiro.hasPermission]
                </ul>
            </li>
            <!-- end 系统设置 -->
           
            <li><div class="for-nav-bottom-rainbow"></div></li>
        </ul>
    </div>
    <!-- <div class="for-nav-bottom-rainbow"></div>
    <div class="nav-bottom-rainbow"></div> -->
</nav>
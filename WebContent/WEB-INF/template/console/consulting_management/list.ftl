<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.recipe.list")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/enumAndDateHelper.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/attendance.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/recipe.js"></script>
</head>
    <body>
        <div id="wrapper">
            <!-- start 导航 -->
            [#include "/console/include/nav.ftl" /]
            <!-- end 导航 -->
            <div id="page-wrapper" class="gray-bg dashbard-1">
                <!-- start 头部 -->
                [#include "/console/include/header.ftl" /]
                <!-- end 头部-->
                <!-- start 头部面包屑区域 -->
                <div class="row wrapper border-bottom white-bg page-heading">
                    <div class="col-lg-10">
                        <h2>${message("console.consultingManagement.list")}</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="${base}/console/common/main.ct"> ${message("console.path.index")}</a>
                            </li>
                            <li>
                                <strong>
                                    ${message("console.consultingManagement.list")}
                                </strong>
                            </li>
                        </ol>
                    </div>
                    <div class="col-lg-2">
                    </div>
                </div>
                <!-- end 头部面包屑区域 -->
                <!-- start 中间内容部分 -->
                <div class="wrapper wrapper-content animated fadeIn">
                <form id="listForm" action="list.ct" method="get">
	             	<!-- start  -->
	             	<div class="row">
	           	 		<div class="col-lg-12">
	                    	<div class="ibox float-e-margins">
	                            <div class="ibox-content">
	                                <div class="row">
	                                    <div class="col-sm-6 m-b-xs">
		                                    <div class="btn-group">
		                                       	[@shiro.hasPermission name = "console:addConsultingManagement"]
		                                        <a href="add.ct" class="btn btn-primary">
													<span class="addIcon">&nbsp;</span>${message("console.common.add")}
												</a>
											   	[/@shiro.hasPermission]
		                                        [@shiro.hasPermission name = "console:deleteConsultingManagement"]
													<a href="javascript:;" id="deleteButton" class="btn btn-primary disabled">
														<span class="deleteIcon">&nbsp;</span>${message("console.common.delete")}
													</a>
												[/@shiro.hasPermission]
												<a href="javascript:;" id="refreshButton" class="btn btn-primary">
													<span class="refreshIcon">&nbsp;</span>${message("console.common.refresh")}
												</a>
												<div class="btn-group">	
			                                        <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle" aria-expanded="false">${message("console.page.pageSize")} <span class="caret"></span>
			                                        </button>
			                                        <ul class="dropdown-menu" id="pageSizeOption">
														<li>
															<a href="javascript:;"[#if page.pageSize == 10] class="current"[/#if] val="10">10</a>
														</li>
														<li>
															<a href="javascript:;"[#if page.pageSize == 20] class="current"[/#if] val="20">20</a>
														</li>
														<li>
															<a href="javascript:;"[#if page.pageSize == 50] class="current"[/#if] val="50">50</a>
														</li>
														<li>
															<a href="javascript:;"[#if page.pageSize == 100] class="current"[/#if] val="100">100</a>
														</li>
													</ul>
		                                       </div>
											</div>
	                                    </div>
	                                </div>
	                                <div class="table-responsive">
	                                     <div class="table-responsive">
		                                     <table id="listTable" class="table table-striped">
													<tr>
														<th class="check">
															<input type="checkbox" id="selectAll" />
														</th>
														<th>
														    <span>${message("ConsultingManagement.phone")}</span>
														</th>
														<th>
														    <span>${message("ConsultingManagement.name")}</span>
														</th>
														<th>
														    <span>${message("ConsultingManagement.dictSchool")}</span>
														</th>
														<th>
														    <span>${message("ConsultingManagement.member")}</span>
														</th>
														<th>
														    <span>${message("ConsultingManagement.coupon")}</span>
														</th>
														<th>
															<span>${message("console.common.handle")}</span>
														</th>
													</tr>
													[#list page.content as consultationStudent]
														<tr>
															<td>
																<input type="checkbox" name="ids" value="${consultationStudent.id}" />
															</td>
															<td>
																${consultationStudent.phone}
															</td>
															<td>
															    ${consultationStudent.name}
															</td>
															<td>
															    ${consultationStudent.dictSchool.name}
															</td>
															<td>
															    ${consultationStudent.member.realName}
															</td>
															<td>
															    ${consultationStudent.coupon.name}
															</td>
															<td>
															[@shiro.hasPermission name = "console:editConsultingManagement"]
																<a href="edit.ct?id=${consultationStudent.id}">[${message("console.common.edit")}]</a>
															[/@shiro.hasPermission]
															</td>
														</tr>
													[/#list]
												</table>
												[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
													[#include "/console/include/pagination.ftl"]
												[/@pagination]
		                                </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	             	<!-- end  -->
             	</form>
                </div>
                <!-- end 中间内容部分 -->
                [#include "/console/include/footer.ftl" /]
            </div>
        </div>
        
    </body>

</html>
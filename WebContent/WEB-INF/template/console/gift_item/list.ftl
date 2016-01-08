<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.giftItem.list")}</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]
	
});

</script>
</head>
<body>
<div id="wrapper">
	  <!-- start  导航 -->
       [#include "/console/include/nav.ftl" /]
       <!-- end 导航-->
	
	   <div id="page-wrapper" class="gray-bg dashbard-1">
		   <!-- start 头部 -->
	       [#include "/console/include/header.ftl" /]
	       <!-- end 头部-->
	       
	       <!-- start 头部面包屑区域 -->
	       <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2>${message("console.giftItem.list")} </h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                            <strong>${message("console.giftItem.list")}  <span>(${message("console.page.total", page.total)})</span></strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">

                </div>
            </div>
	       	<!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
				<!-- start  赠品列表管理 -->
				<form id="listForm" action="list.ct" method="get">
					<div class="row">
						<div class="col-lg-12">
	                        <div class="ibox float-e-margins">
	                            <div class="ibox-content">
	                                <div class="row">
	                                    <div class="col-sm-12 m-b-xs">
											<div class="btn-group">
		                                        [@shiro.hasPermission name = "console:addGiftItem"]
													<a href="add.ct" class="btn btn-primary">
														<span class="addIcon">&nbsp;</span>${message("console.common.add")}
													</a>
												[/@shiro.hasPermission]
												[@shiro.hasPermission name = "console:offlineGiftItem"]
													<a href="javascript:;" id="deleteButton" class="btn btn-primary disabled">
														<span class="deleteIcon">&nbsp;</span>${message("console.common.offShelves")}
													</a>
												[/@shiro.hasPermission]
												<a href="javascript:;" id="refreshButton"  class="btn btn-primary">
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
											<div class="input-group pull-right">
											<form action="list.ct" method="get">
												<input type="text" name="giftName" value="${giftName}" class="input-sm form-control" style="width:100px;margin-top: 12px;" placeholder="搜索赠品名称">
												<input type="submit" class="btn btn-primary" value="搜索"/>
											</form>
											</div>
	                                    </div>
	                                </div>
	                                <div class="table-responsive">
	                                     <table id="listTable" class="table table-striped">
											<tr>
												<th class="check">
													<input type="checkbox" id="selectAll" />
												</th>
												<th>
													<a href="javascript:;" class="sort" name="name">${message("GiftItem.giftName")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="image">${message("GiftItem.image")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="price">${message("GiftItem.price")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="point">${message("GiftItem.point")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="isOnline">${message("GiftItem.isOnline")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="decription">${message("GiftItem.decription")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="quantity">${message("GiftItem.quantity")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="maxExchangeNum">${message("GiftItem.maxExchangeNum")}</a>
												</th>
												<th>
													<span>${message("console.common.handle")}</span>
												</th>
											</tr>
											[#list page.content as giftItem]
												<tr>
													<td>
														<input type="checkbox" name="ids" value="${giftItem.id}" />
													</td>
													<td>
														<span title="${giftItem.giftName}">
															${abbreviate(giftItem.giftName, 10, "...")}
														</span>
													</td>
													<td>
														<img class="img_plus" src="${giftItem.image}" height="50" width="50" />
													</td>
													<td>
														${giftItem.price}
													</td>
													<td>
														${giftItem.point}
													</td>
													<td>
													    [#if giftItem.isOnline]
													    	已上架
														[#else]
															未上架
														[/#if]
													</td>
													<td>
														<span title="${giftItem.decription}">
															${abbreviate(giftItem.decription, 25, "...")}
														</span>
													</td>
													<td>
														${giftItem.quantity}
													</td>
													<td>
														${giftItem.maxExchangeNum}
													</td>
													<td>
													[@shiro.hasPermission name = "console:editGiftItem"]
														<a href="edit.ct?id=${giftItem.id}">[${message("console.common.edit")}]</a>
													[/@shiro.hasPermission]
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
                </form>
	             <!-- end 赠品列表-->
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
</body>
</html>
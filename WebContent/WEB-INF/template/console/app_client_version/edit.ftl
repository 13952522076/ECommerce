<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.appClientVersion.edit")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<style type="text/css">
table th {
  width: 150px;
  line-height: 25px;
  padding: 5px 10px 5px 0px;
  font-weight: normal;
  white-space: nowrap;
}
</style>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");

	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			operatingSystem:{
				required: true
			},
			typeOfUpgrade: {
				required: true
			},
			versionName:{
				required: true,
				maxlength:100
			},
			description: {
				required: true,
				maxlength:500
			},
			urlDownload:{
				required: true,
				maxlength:100
			},
			fileSize: {
				required: true,
				maxlength:100,
				pattern:/^\d+(\.\d+){0,1}[KMGkmg]$/
			},
			versionNumber:{
				required: true,
				maxlength:100,
				pattern:/^\d+(\.\d+){2}$/
			}
		},
		messages: {
		}
	});
	
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
					<h2> ${message("console.appClientVersion.edit")} </h2>
	                <ol class="breadcrumb">
						<li>
						    <!--首页-->
							<a href="${base}/console/common/index.ct">${message("console.path.index")}</a> 
	                    </li>
	                    <li>
	                        <strong>${message("console.appClientVersion.edit")}</strong>
	                    </li>
					</ol>
	            </div>
	            <div class="col-lg-2">
	
	            </div>
	        </div>
	       	<!-- end 头部面包屑区域 -->	
			<!-- start 中间内容部分 -->
			<div class="wrapper wrapper-content animated fadeIn">
				 <form id="inputForm" action="update.ct" method="post">
				 	 <input type="hidden" value="${appClientVersion.id}" name="id"/>
				 	 <input type="hidden" name="flagPublish" value="${appClientVersion.flagPublish?string('true','false')}" />
		             <div class="row">
	                    <div class="col-lg-12">
	                        <div class="ibox float-e-margins">
	                            <div class="ibox-content" style="width:70%;margin:0 auto;">
	                                <div class="row">
	                                    <div class="col-sm-4 m-b-xs">
											
	                                    </div>
	                                </div>
	                                <div class="table-responsive">
	                                     <table class="table table-striped">
	                                        <tr>
												<th>
													<span class="requiredField">*</span>${message("AppClientVersion.operatingSystem")}:
												</th>
												<td>
													<select name="operatingSystem" class="form-control">
														<option value="">${message("console.common.select")}</option>
														<option value="android" [#if appClientVersion.operatingSystem=="android"]selected[/#if]>android</option>
														<option value="ios" [#if appClientVersion.operatingSystem=="ios"]selected[/#if]>iphone</option>
														<option value="attendance" [#if appClientVersion.operatingSystem=="attendance"]selected[/#if]>考勤机</option>
													</select>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("AppClientVersion.typeOfUpgrade")}:
												</th>
												<td>
													<select name="typeOfUpgrade" class="form-control">
														<option value="">${message("console.common.select")}</option>
														<option value="noneed"[#if appClientVersion.typeOfUpgrade=="noneed"]selected[/#if]>无需升级</option>
														<option value="optional" [#if appClientVersion.typeOfUpgrade=="optional"]selected[/#if]>可选升级</option>
														<option value="forced" [#if appClientVersion.typeOfUpgrade=="forced"]selected[/#if]>强制升级</option>
													</select>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("AppClientVersion.versionName")}:
												</th>
												<td>
													<input type="text" name="versionName" class="form-control" value="${appClientVersion.versionName}" />
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("AppClientVersion.description")}:
												</th>
												<td>
													<textarea name="description" id="description" style="width:100%;height:100px;">${appClientVersion.description}</textarea>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("AppClientVersion.urlDownload")}:
												</th>
												<td>
													<input type="text" name="urlDownload" class="form-control"  value="${appClientVersion.urlDownload}"/>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("AppClientVersion.versionNumber")}:
												</th>
												<td style="text-align: left;">
													<input type="text" name="versionNumber" class="form-control" value="${appClientVersion.versionNumber}"/>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("AppClientVersion.fileSize")}:
												</th>
												<td>
													<input type="text" name="fileSize" class="form-control" value="${appClientVersion.fileSize}"/>
												</td>
											</tr>
										</table>
										<table class="input">
											<tr>
												<th>
													&nbsp;
												</th>
												<td>
													<input type="submit" class="btn  btn-primary" value="${message("console.common.submit")}" />
													<input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='list.ct'" />
												</td>
											</tr>
										</table>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </form>
			</div>
			<!-- end 中间内容部分 -->
		   	[#include "/console/include/footer.ftl" /]
		</div>
	</div>
</body>
</html>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.plugin.messagePushPlugin.setting")} - 小书僮™智慧幼教管理平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $browserButton = $("#browserButton");
	var $selEnevConf=$("#selEnevConf");
	var $environmentConf=$("#environmentConf");
	
	[@flash_message /]
	
	$browserButton.browser();
	
	// 表单验证
	$inputForm.validate({
		errorClass: "fieldError",
		ignoreTitle: true,
		rules: {
			accessID: "required",
			secretKey: "required",
			validTime: {
			      required: true,
			      digits:true
			},
			environmentConf:"required",
			order: "digits"
		}
	});
	
    $environmentConf.val($selEnevConf.val());
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
                    <h2>${message("console.plugin.messagePushPlugin.setting")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                            <strong>${message("console.plugin.messagePushPlugin.setting")}</strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">

                </div>
            </div>
	       <!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
	             <!-- start 新增管理员-->
	            <form id="inputForm" action="update.ct" method="post">
		             <div class="row">
	                    <div class="col-lg-12">
	                        <div class="ibox float-e-margins">
	                            <div class="ibox-content" style="width:70%;margin:0 auto;">
	                                <div class="row">
	                                    <div class="col-sm-4 m-b-xs">
	                                    </div>
	                                </div>
	                                <div class="table-responsive">
	                                     <table id="listTable" class="table table-striped">
												<tr>
													<th>
														<span class="requiredField">*</span>${message("MessagePushPlugin.accessID")}:
													</th>
													<td>
														<input type="text" name="accessID" class="form-control" value="${pluginConfig.attributes['accessID']}" maxlength="200" />
													</td>
												</tr>
												<tr>
													<th>
														<span class="requiredField">*</span>${message("MessagePushPlugin.secretKey")}:
													</th>
													<td>
														<input type="text" name="secretKey" class="form-control" value="${pluginConfig.attributes['secretKey']}" maxlength="200" />
													</td>
												</tr>
												<tr>
													<th>
														<span class="requiredField">*</span>${message("MessagePushPlugin.validTime")}:
													</th>
													<td>
														<input type="text" name="validTime" class="form-control" value="${pluginConfig.attributes['validTime']}" maxlength="200" />
													</td>
												</tr>
												<tr>
													<th>
														<span class="requiredField">*</span>${message("MessagePushPlugin.environmentConf")}:
													</th>
													<td>
													    <input id="selEnevConf" type="hidden" value="${pluginConfig.attributes['environmentConf']}"/>
														<select id="environmentConf" name="environmentConf" class="form-control valid">
															<option value="">${message("console.common.select")}</option>
															<option value="IOSENV_PROD">XingeApp.IOSENV_PROD</option>
															<option value="IOSENV_DEV">XingeApp.IOSENV_DEV</option>
														</select>
													</td>
												</tr>
												<tr>
													<th>
														${message("MessagePushPlugin.description")}:
													</th>
													<td>
														<textarea name="description" class="form-control">${pluginConfig.attributes['description']?html}</textarea>
													</td>
												</tr>
												<tr>
													<th>
														${message("console.common.order")}:
													</th>
													<td>
														<input type="text" name="order" class="form-control" value="${pluginConfig.order}" maxlength="9" />
													</td>
												</tr>
												<tr>
													<th>
														${message("PaymentPlugin.isEnabled")}:
													</th>
													<td>
														<label>
															<input type="checkbox" name="isEnabled" value="true"[#if pluginConfig.isEnabled] checked[/#if] />
														</label>
													</td>
												</tr>
												<tr>
													<th>
														&nbsp;
													</th>
													<td>
														<input type="submit" class="btn  btn-primary" value="${message("console.common.submit")}" />
														<input type="button"  class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='../list.ct'" />
													</td>
												</tr>
										</table>
									</form>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </form>
	             <!-- end 新增管理员-->
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
</body>
</html>
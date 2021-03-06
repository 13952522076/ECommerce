<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("编辑应用")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/editor/kindeditor.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<link href="${base}/resources/console/css/plugins/chosen/chosen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/js/plugins/chosen/chosen.jquery.js"></script>
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js"></script>
<!-- Fancy box -->
<link href="${base}/resources/console/js/plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
<script src="${base}/resources/console/js/plugins/fancybox/jquery.fancybox.js"></script>
<style type="text/css">
.roles label {
	width: 150px;
	display: block;
	float: left;
	padding-right: 6px;
}
table th {
  width: 150px;
  line-height: 25px;
  padding: 5px 10px 5px 0px;
  font-weight: normal;
  white-space: nowrap;
}
.itemList-upload{
	left:650px;
	top:45px;
	width:111px;
	padding:8px;
	border-radius:2px;
	border:1px solid #D6D6D6;
}
.newsPreview{
	width:93px;
	height:93px;
}
.imgShowBox{
	position:relative;
}
#buttonTd a{
	margin-right:15px;
}
.radioTD input{
	margin-right:5px;
}
.radioTD label{
	margin-right:10px;
}
.left{
	float:left;
	width:35%;
}
.right{
	margin-left:37%;
}
.screenshotName{
	width:96px;
	overflow: hidden;
	font-size: 11px;
	height: 20px;
}
</style>
<script type="text/javascript">
var flag=0;
$().ready(function() {
	var selectImageNum = ${app.appScreenshots?size};//全局变量
	var selectPromotionNum=${app.promotionCovers?size};//全局变量

	var $inputForm = $("#inputForm");
	
	[@flash_message /]
	
	$("#changeOrder").hide();
	// 表单验证
	$inputForm.validate({
		rules: {
			appName:{
				required:true,
				maxlength:20
			},
			appDescription:{
				required:true,
				maxlength:1000
			},
			operatingSystem:"required",
			runType:"required",
			logoAppImg:"required",
			openUrl:{
				required:true
			},
			[#if app.operatingSystem == "hybird" || app.operatingSystem == "hbuilder"]
				appAttachment:"required",
			[/#if]
			
			installUrl:"required",
			appSize:{
				required:true,
				maxlength:10,
				pattern:/^\d+(\.\d+){0,1}[KMGkmg]$/
			},
			versionName:{
				required:true,
				maxlength:50
			},
			versionCode:{
				required:true,
				maxlength:10,
				pattern:/^\d+(\.\d+){0,3}$/
			},
			appCode:{
				required:true,
				maxlength:100,
				remote: {
					url: "check_app_code.ct?previousAppCode=${app.appCode?url}",
					cache: false
				},
				pattern:/^[A-Za-z.\d]*$/
			},
			appCategoryId:"required",
			//appScreenshotsNum:{
			//	required:true,
			//}
		},
		messages: {
			appScreenshotsNum:{
				required:"请上传截图",
			},
			appCode: {
				pattern: "${message("console.app.appCodeIllegalPattern")}",
				remote: "${message("console.app.appCodeExist")}"
			}
		},
		submitHandler: function(form) {
		    var isMaxCount=true;
		    var submitOk=true;
			if($("#isTruePromotion").prop("checked")){
				if(selectPromotionNum <= 0){
				    submitOk=false;
					$.message("warn", "请上传截图！");
				}
			}else{
				if(selectImageNum <= 0){
				    submitOk=false;
					$.message("warn", "请上传截图！");
				}
			}
		    [#if app.isOnline == true]
				if(flag == 1){
		    	$.ajax({
                   type: "GET",
                   url: "checkLimitedCountEdit.ct",
                   data: {
                          operatingSystem: "${app.operatingSystem}",
                          id:${app.id},
                          appCode:"${app.appCode}"
                   },
                   dataType: "json",
                   async: false,
                   success: function(returnValue) {
                       if (returnValue) {
                                    $.message("warn", "促销应用数量已经达到上限！");
                                    isMaxCount=false;
                                    return false;
                                }
                        },
                   });	
			}
			[/#if]
             if(isMaxCount && submitOk){
             	form.submit();
             }
		  }
	});
	
	<!--start上传应用图标插件 -->
 	var $logoAppImgUpload = $("#logoAppImgUpload");
	var $logoAppImgView = $("#logoAppImgView");
	var $delLogoAppImg = $("#delLogoAppImg");
	var $logoAppImg = $("#logoAppImg");
    $logoAppImgUpload.uploadify({  
        'successTimeout' : 50000,
        'height'        : 27,   
        'width'         : 80,    
        'buttonText'    : '浏览',  
        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
        'uploader'      : '${base}/console/file/upload.ct?fileType=image',  
        'auto'          : true,
        'multi'          : true, //是否支持多文件上传  
	    'simUploadLimit' : 1, //一次同步上传的文件数目     
	    'fileSizeLimit' : 20, //设置单个文件大小限制     
	    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
	    'fileObjName'    :  'file',
	    'fileTypeDesc'  :  '*.png',//图片选择描述  
        'fileTypeExts'  :  '*.png',//允许的格式      
        'formData'      : {
        		'token' : getCookie("token"),
        		'imageWidth':'98',
        		'imageHeight':'98'
         },
        //上传成功  
        'onUploadSuccess' : function(file, data, response) {  
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            var sizeErrorMessageType = dataJson['sizeErrorMessage']['type'];//图片文件上传尺寸返回信息类型
            var sizeErrorMessageContent = dataJson['sizeErrorMessage']['content'];//图片文件上传尺寸返回信息内容
            if(messageType == 'success'){
            	if(sizeErrorMessageType == 'success'){
            		$logoAppImgView.attr("src",contentImgFileUrl);
		            $logoAppImg.val(contentImgFileUrl);
		            $delLogoAppImg.css('display','inline'); 
            	}
            	else{
            		$.message("warn", sizeErrorMessageContent);
            	}
            }else{
                $.message("warn", messageContent);
            }
        },
	    onComplete: function (event, queueID, fileObj, response, data) {
	           
	    },  
	    onError: function(event, queueID, fileObj) {     
	        alert("文件:" + fileObj.name + "上传失败");     
	    },
	    onSelect: function(file){
	        //alert("文件:" + file.name);
	    }
    });
	<!--end上传应用图标插件 -->
	
	<!-- start删除应用图标插件-->
	// 删除封面图片
	$delLogoAppImg.on("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.dialog.deleteConfirm")}",
			onOk: function() {
			    $logoAppImgView.attr("src","${base}/resources/console/images/appIconUpload.png");
	            $logoAppImg.val("");
	            $delLogoAppImg.css('display','none'); 
			}
		});
	});
	<!-- end删除应用图标插件-->
	
	var fileSizeLimit=50;
	if($("#isTruePromotion").attr("checked")=='checked'){
		$("#changeOrder").show();
		fileSizeLimit=10;
		$("#imgShowBox5").hide();
		$("#imgShowBox2").show();
		flag=1;
	}else{
	    $("#imgShowBox5").show();
		$("#imgShowBox2").hide();
	};
	
	/** 5个应用截图上传*/
	[#list 1..5 as index]
		// 上传
		$("#appScreenshotUpload${index}").uploadify({  
	        'successTimeout' : 50000,
	        'height'        : 27,   
	        'width'         : 80,    
	        'buttonText'    : '浏览',  
	        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
	        'uploader'      : '${base}/console/file/upload.ct?fileType=image',  
	        'auto'          : true,
	        'multi'          : true, //是否支持多文件上传  
		    'simUploadLimit' : 1, //一次同步上传的文件数目     
		    'fileSizeLimit'  :50, //设置单个文件大小限制     
		    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
		    'fileObjName'    :  'file',
		    'fileTypeDesc'  :  '*.jpg;*.png',//图片选择描述  
	        'fileTypeExts'  :  '*.jpg;*.png',//允许的格式      
	        'formData'      : {
	        		'token' : getCookie("token"),
	        			'imageWidth':'320',
	        		    'imageHeight':'480'
	         },
	        //上传成功  
	        'onUploadSuccess' : function(file, data, response) {  
	        	var index = "${index}";
	            var dataJson = JSON.parse(data);
	            var contentImgFileUrl = dataJson['url'];
	            var messageContent = dataJson['message']['content'];
	            var messageType = dataJson['message']['type'];
	            var sizeErrorMessageType = dataJson['sizeErrorMessage']['type'];//图片文件上传尺寸返回信息类型
	            var sizeErrorMessageContent = dataJson['sizeErrorMessage']['content'];//图片文件上传尺寸返回信息内容
	            if(messageType == 'success'){
	            	if(sizeErrorMessageType == 'success'){
	            		$("#screenshotUrl"+index).val(contentImgFileUrl);
			            $("#screenshot"+index).val(file.name);
			            $("#appScreenshotView"+index).attr("src",contentImgFileUrl);
			            $("#delAppScreenshot"+index).css('display','inline');
			            $("#screenshotName"+index).html(file.name);
			            selectImageNum++;
			            $("#appScreenshotsNum").val(selectImageNum);
	            	}
	            	else{
	            		$.message("warn", sizeErrorMessageContent);
	            	}
	            }else{
	                $.message("warn", messageContent);
	            }
	        },
		    onComplete: function (event, queueID, fileObj, response, data) {
		           
		    },  
		    onError: function(event, queueID, fileObj) {     
		        alert("文件:" + fileObj.name + "上传失败");     
		    }
	    });
	    
	    // 删除上传
		$("#delAppScreenshot${index}").on("click", function() {
			var $this = $(this);
			$.dialog({
				type: "warn",
				content: "${message("admin.dialog.deleteConfirm")}",
				onOk: function() {
				    $("#appScreenshotView${index}").attr("src","${base}/resources/console/images/appScreenshotUpload.png");
		            $("#screenshotUrl${index}").val("");
		            $("#screenshot${index}").val("");
		            $("#delAppScreenshot${index}").css('display','none'); 
		            $("#screenshotName${index}").html("");
		            selectImageNum--;
		            $("#appScreenshotsNum").val(selectImageNum);
		            if(selectImageNum == 0){
		            	$("#appScreenshotsNum").val("");
		            }
				}
			});
		});
	[/#list]
	
	/** 2个应用截图上传*/
	[#list 6..7 as index]
		// 上传
		$("#appScreenshotUpload${index}").uploadify({  
	        'successTimeout' : 50000,
	        'height'        : 27,   
	        'width'         : 80,    
	        'buttonText'    : '浏览',  
	        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
	        'uploader'      : '${base}/console/file/upload.ct?fileType=image',  
	        'auto'          : true,
	        'multi'          : true, //是否支持多文件上传  
		    'simUploadLimit' : 1, //一次同步上传的文件数目     
		    'fileSizeLimit'  :10, //设置单个文件大小限制     
		    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
		    'fileObjName'    :  'file',
		    'fileTypeDesc'  :  '*.jpg;*.png',//图片选择描述  
	        'fileTypeExts'  :  '*.jpg;*.png',//允许的格式      
	        'formData'      : {
	        		'token' : getCookie("token")
	         },
	        //上传成功  
	        'onUploadSuccess' : function(file, data, response) {  
	        	var index = "${index}";
	            var dataJson = JSON.parse(data);
	            var contentImgFileUrl = dataJson['url'];
	            var messageContent = dataJson['message']['content'];
	            var messageType = dataJson['message']['type'];
	            var sizeErrorMessageType = dataJson['sizeErrorMessage']['type'];//图片文件上传尺寸返回信息类型
	            var sizeErrorMessageContent = dataJson['sizeErrorMessage']['content'];//图片文件上传尺寸返回信息内容
	            if(messageType == 'success'){
	            	if(sizeErrorMessageType == 'success'){
	            		$("#screenshotUrl"+index).val(contentImgFileUrl);
			            $("#screenshot"+index).val(file.name);
			            $("#appScreenshotView"+index).attr("src",contentImgFileUrl);
			            $("#delAppScreenshot"+index).css('display','inline');
			            $("#screenshotName"+index).html(file.name);
			            selectPromotionNum++;
			            $("#promotionCoversNum").val(selectPromotionNum);
	            	}
	            	else{
	            		$.message("warn", sizeErrorMessageContent);
	            	}
	            }else{
	                $.message("warn", messageContent);
	            }
	        },
		    onComplete: function (event, queueID, fileObj, response, data) {
		           
		    },  
		    onError: function(event, queueID, fileObj) {     
		        alert("文件:" + fileObj.name + "上传失败");     
		    }
	    });
	    
	    // 删除上传
		$("#delAppScreenshot${index}").on("click", function() {
			var $this = $(this);
			$.dialog({
				type: "warn",
				content: "${message("admin.dialog.deleteConfirm")}",
				onOk: function() {
				    $("#appScreenshotView${index}").attr("src","${base}/resources/console/images/appScreenshotUpload.png");
		            $("#screenshotUrl${index}").val("");
		            $("#screenshot${index}").val("");
		            $("#delAppScreenshot${index}").css('display','none'); 
		            $("#screenshotName${index}").html("");
		            selectPromotionNum--;
		            $("#promotionCoversNum").val(selectPromotionNum);
		            if(selectPromotionNum == 0){
		            	$("#promotionCoversNum").val("");
		            }
				}
			});
		});
	[/#list]
	
	<!-- start 上传应用 -->
	$("#appUpload").uploadify({
		'successTimeout' : 50000,
        'height'        : 34,   
        'width'         : 120, 
      	'buttonText'    : '选择上传',  
      	'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
      	'uploader'      : '${base}/console/file/upload.ct?fileType=file',  
      	'auto'          : true,
      	'multi'         : false, //是否支持多文件上传 
      	'simUploadLimit': 1, //一次同步上传的文件数目
      	'queueSizeLimit' : 1, //队列中同时存在的文件个数限制  
      	'fileObjName'    :  'file', 
      	'fileTypeDesc'  :  '*.zip',//选择描述  
        'fileTypeExts'  :  '*.zip',//允许的格式  
        'formData'      : {
        		'token' : getCookie("token"),
		},
		//上传成功  
        'onUploadSuccess' : function(file, data, response) { 
        	 var dataJson = JSON.parse(data);
        	 var appURL = dataJson['url'];
        	 var appFileName = file.name;
        	 var messageType = dataJson['message']['type'];
        	 var messageContent = dataJson['message']['content'];
        	 if(messageType == 'success'){
        	 	$("#appUpload").attr("display","none");
        	 	$("#appAttachment").val(appURL);
        	 	$("#appFileName").html(appFileName);
        	 }else{
        	 	$.message("warn", messageContent);
        	 }
        	 
        },
        onComplete: function (event, queueID, fileObj, response, data) {
	           
	    },  
	    onError: function(event, queueID, fileObj) {     
	        alert("文件:" + fileObj.name + "上传失败");     
	    },
	    onSelect: function(file){
	        //alert("文件:" + file.name);
	    }
	});
	<!-- end   上传应用 -->
	
	$(".isPromotionApp").click(function() {
		if( $(this).val() == "true"){
			$("#appScreen").show(100);
		}else{
			$("#appScreen").hidden(100);
		}
	})
	
	$("#changeOrder").click(function(){
		var temp=$("#appScreenshotView6").attr("src");
		var tempUrl=$("#screenshotUrl6").attr("value");
		var tempName=$("#screenshot6").attr("value");
		var tempVal=$("#screenshotName6").text();
		
		$("#appScreenshotView6").attr("src",$("#appScreenshotView7").attr("src"));
		$("#appScreenshotView7").attr("src",temp);
		
		$("#screenshotUrl6").attr("value",$("#screenshotUrl7").attr("value"));
		$("#screenshotUrl7").attr("value",tempUrl);
		
		$("#screenshot6").attr("value",$("#screenshot7").attr("value"));
		$("#screenshot7").attr("value",tempName);
		
		$("#screenshotName6").text($("#screenshotName7").text());
		$("#screenshotName7").text(tempVal);
	})
});

function deleteCampusviewImageAttach(obj){
	var $this = $(obj);
	$.dialog({
		type: "warn",
		content: "${message("admin.dialog.deleteConfirm")}",
		onOk: function() {
			$this.prev().closest("a").remove();
			$this.closest("a").remove();
		}
	});
}

/* 下架应用 */
function unShelve(appId,type){
	var isPromotionApp=false;  
	if(flag == 1){
		isPromotionApp=true;
	}
	var shelveMessage ="<h3>确认下架该应用？</h3>";
	if(type =="up"){
		shelveMessage ="<h3>确认上架该应用？</h3>";
	}
	layer.confirm(shelveMessage, {
		title:false,
		closeBtn: false,
	    btn: ['确定','取消'], //按钮
	    shade: false //不显示遮罩
	}, function(){
		//左边按钮的响应事件
		$.ajax({
			type:"GET",
			url:"unShelve.ct",
			data:{
				id:appId,
				type:type,
				isPromotionApp:isPromotionApp,
				operatingSystem:$("#operatingSystem").val()
			},
			dataType:"json",
			success:function(appName){
			    if(appName == ""){
			    	$.message("warn","上架促销应用已经达到上限！");
			    	return false;
			    }else{
			    	var message =   "应用 "+appName+" 已";
					if(type =="up"){
						message+="上架";
						$("#shelve").html('<a onclick="unShelve(${app.id},\'down\')" class="btn btn-success">下架</a>');
					}else{
						message+="下架";
						$("#shelve").html('<a onclick="unShelve(${app.id},\'up\')" class="btn btn-success">上架</a>');
					}
					layer.msg(message, {
					 	icon: 1,
					 	time:1200
				 	});
				 	location.reload();
			    }
			},
		});
	   
	}, function(){
		//右边按钮的响应事件
	    layer.close();
	});
	
}

<!--删除上传的app文件-->
function deleteAppFile(){
	$.dialog({
			type: "warn",
			content: message("console.dialog.deleteConfirm"),
			ok: message("console.dialog.ok"),
			cancel: message("console.dialog.cancel"),
			onOk: function() {
					$("#appAttachment").val("");
 					$("#appFileName").html("");
			}
	});
}

<!--显示应用截图-->
function showScreens(obj){
	if(obj == 'true'){
		$("#tipInfo").html("单张图片不超过10K");
		$("#changeOrder").show();
		$("#imgShowBox5").hide();
		$("#imgShowBox2").show();
		flag=1;
	}else{
		$("#tipInfo").html("应用截图320*480.jpg\png格式，单张图片不超过50K");
		$("#changeOrder").hide();
		$("#imgShowBox2").hide();
		$("#imgShowBox5").show();
		flag=0;
	}
}
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
                    <h2> ${message("应用管理")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/app/list.ct">${message("应用管理")}</a>
                        </li>
                        <li>
                            <strong>${message("编辑应用")}</strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">

                </div>
            </div>
	       <!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
	             <!-- start -->
	             <form id="inputForm" action="update.ct" method="post">
	             	<input type="hidden" name="id" value="${app.id}">
		             <div class="row">
	                    <div class="col-lg-12">
	                        <div class="ibox float-e-margins">
	                            <div class="ibox-content" style="margin:0 auto;">
	                                <div class="row">
	                                    <div class="col-sm-4 m-b-xs">
											
	                                    </div>
	                                </div>
	                                <div class="table-responsive">
	                                     <table class="table table-striped">
	                                     	[#list ["console:appShelve","console:appCredential","console:appUpgrade","console:appVersionList","console:appAuthorization"] as permission]
	                                     	[@shiro.hasPermission name = permission]
	                                     	<tr>
												<td id="buttonTd"  colspan="3">
													[@shiro.hasPermission name="console:appShelve"]
													<span id="shelve"><a onclick="unShelve(${app.id},[#if app.isOnline==true]'down'[#else]'up'[/#if])" class="btn btn-success">[#if app.isOnline==true]下架[#else]上架[/#if]</a></span>
													[/@shiro.hasPermission]
													[#if app.isOnline]
														[@shiro.hasPermission name="console:appCredential"]
														<a href="credential.ct?id=${app.id}" class="btn btn-success">API授权</a>
														[/@shiro.hasPermission]
														[@shiro.hasPermission name="console:appUpgrade"]
														<a href="upgrade.ct?id=${app.id}" class="btn btn-success">升级</a>
														[/@shiro.hasPermission]
														[@shiro.hasPermission name="console:appVersionList"]
														<a href="appVersionList.ct?id=${app.id}" class="btn btn-success">版本回退</a>
														[/@shiro.hasPermission]
														[@shiro.hasPermission name="console:appAuthorization"]
														<a href="authorization.ct?id=${app.id}" class="btn btn-success">应用授权</a>
														[/@shiro.hasPermission]
													[/#if]
												</td>
											</tr>
											[#break /]
											[/@shiro.hasPermission]
                							[/#list]
	                                        <tr>
												<th>
													<span class="requiredField">*</span>${message("应用名称")}:
												</th>
												<td colspan="2">
													<div class="left">
														<input type="text" name="appName" class="form-control" value="${app.appName}"/>
													</div>
													<div class="right">
														<label>应用名称不超过20个字符</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("应用简介")}:
												</th>
												<td style="width:60%;">
													<textarea name="appDescription" class="form-control" style="height: 80px;">${app.appDescription}</textarea>
												</td>
												<td>
													<label>应用简介字符不超过1000个字符</label>
												</td>
											</tr>
											<tr>
												<th>
													${message("应用促销")}:
												</th>
												<td>
													<div style="float: left;">
													     <label class="radio-inline">
							                                <input type="radio" class="checkbox checkbox-inline" id="isTruePromotion" onclick="showScreens('true')" name="isPromotionApp" value="true" [#if limiteCount == true] disabled="disabled" [/#if] [#if app.isPromotionApp == true] checked="checked" [/#if]>
							                                ${message("是")}
							                             </label>
							                              <label class="radio-inline">
							                                <input type="radio" class="checkbox checkbox-inline" id="isFalsePromotion" onclick="showScreens('false')" name="isPromotionApp" value="false" [#if app.isPromotionApp == false] checked="checked" [/#if]>
							                                ${message("否")}
							                             </label>
							                        </div>
												</td>
											</tr>
											<tr id="imgShowBox5">
												<th>
													<span class="requiredField">*</span>${message("应用截图")}:
												</th>
												<td colspan="2">
													<div style="width:600px;height:40px;">
														<label>应用截图320*480.jpg\png格式，单张图片不超过50K</label>
														<input type="hidden" id="appScreenshotsNum" name="appScreenshotsNum" value="${app.appScreenshots?size}"/>
													</div>
													<div class="itemList-upload" style="float:left;">
														<div class="imgShowBox">
															[#if app.appScreenshots?? && app.appScreenshots[0]??]
																<img src="${app.appScreenshots[0].screenshotUrl}" alt="" id="appScreenshotView1" class="appScreenshotView" style="width:96px;;height:144px;">
															[#else]
																<img src="${base}/resources/console/images/appScreenshotUpload.png" alt="" id="appScreenshotView1" class="appScreenshotView" style="width:96px;;height:144px;">
															[/#if]	
															<div id="screenshotName1" class="screenshotName">${app.appScreenshots[0].screenshot}</div>
															<a href="javascript:;" title="删除图片" class="delImg" id="delAppScreenshot1" [#if app.appScreenshots[0].screenshotUrl]style="display:block;"[/#if]>×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="appScreenshotUpload1" />
															<input type="hidden" id="screenshotUrl1" name="appScreenshots[0].screenshotUrl" value="${app.appScreenshots[0].screenshotUrl}"/>
															<input type="hidden" id="screenshot1" name="appScreenshots[0].screenshot" value="${app.appScreenshots[0].screenshot}"/>
														</div>
													</div>
													<div class="itemList-upload" style="float:left;margin-left:15px;">
														<div class="imgShowBox">
															[#if app.appScreenshots?? && app.appScreenshots[1]??]
																<img src="${app.appScreenshots[1].screenshotUrl}" alt="" id="appScreenshotView2" class="appScreenshotView" style="width:96px;;height:144px;">
															[#else]
																<input type="hidden" name="validateScreen1" >
																<img src="${base}/resources/console/images/appScreenshotUpload.png" alt="" id="appScreenshotView2" class="appScreenshotView" style="width:96px;;height:144px;">
															[/#if]
															<div id="screenshotName2" class="screenshotName">${app.appScreenshots[1].screenshot}</div>
															<a href="javascript:;" title="删除图片" class="delImg" id="delAppScreenshot2" [#if app.appScreenshots[1].screenshotUrl]style="display:block;"[/#if]>×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="appScreenshotUpload2" />
															<input type="hidden" id="screenshotUrl2" name="appScreenshots[1].screenshotUrl" value="${app.appScreenshots[1].screenshotUrl}"/>
															<input type="hidden" id="screenshot2" name="appScreenshots[1].screenshot" value="${app.appScreenshots[1].screenshot}"/>
														</div>
													</div>
													<div class="itemList-upload" style="float:left;margin-left:15px;">
														<div class="imgShowBox">
															[#if app.appScreenshots?? && app.appScreenshots[2]??]
																<img src="${app.appScreenshots[2].screenshotUrl}" alt="" id="appScreenshotView3" class="appScreenshotView" style="width:96px;;height:144px;">
															[#else]
																<img src="${base}/resources/console/images/appScreenshotUpload.png" alt="" id="appScreenshotView3" class="appScreenshotView" style="width:96px;;height:144px;">
															[/#if]
															<div id="screenshotName3" class="screenshotName">${app.appScreenshots[2].screenshot}</div>
															<a href="javascript:;" title="删除图片" class="delImg" id="delAppScreenshot3" [#if app.appScreenshots[2].screenshotUrl]style="display:block;"[/#if]>×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="appScreenshotUpload3" />
															<input type="hidden" id="screenshotUrl3" name="appScreenshots[2].screenshotUrl" value="${app.appScreenshots[2].screenshotUrl}"/>
															<input type="hidden" id="screenshot3" name="appScreenshots[2].screenshot" value="${app.appScreenshots[2].screenshot}"/>
														</div>
													</div>
													<div class="itemList-upload" style="float:left;margin-left:15px;" >
														<div class="imgShowBox">
															[#if app.appScreenshots?? && app.appScreenshots[3]??]
																<img src="${app.appScreenshots[3].screenshotUrl}" alt="" id="appScreenshotView4" class="appScreenshotView" style="width:96px;;height:144px;">
															[#else]
																<img src="${base}/resources/console/images/appScreenshotUpload.png" alt="" id="appScreenshotView4" class="appScreenshotView" style="width:96px;;height:144px;">
															[/#if]
															<div id="screenshotName4" class="screenshotName">${app.appScreenshots[3].screenshot}</div>
															<a href="javascript:;" title="删除图片" class="delImg" id="delAppScreenshot4" [#if app.appScreenshots[3].screenshotUrl]style="display:block;"[/#if]>×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="appScreenshotUpload4" />
															<input type="hidden" id="screenshotUrl4" name="appScreenshots[3].screenshotUrl" value="${app.appScreenshots[3].screenshotUrl}"/>
															<input type="hidden" id="screenshot4" name="appScreenshots[3].screenshot" value="${app.appScreenshots[3].screenshot}"/>
														</div>
													</div>
													<div class="itemList-upload" style="float:left;margin-left:15px;" >
														<div class="imgShowBox">
															[#if app.appScreenshots?? && app.appScreenshots[4]??]
																<img src="${app.appScreenshots[4].screenshotUrl}" alt="" id="appScreenshotView5" class="appScreenshotView" style="width:96px;;height:144px;">
															[#else]
																<img src="${base}/resources/console/images/appScreenshotUpload.png" alt="" id="appScreenshotView5" class="appScreenshotView" style="width:96px;;height:144px;">
															[/#if]
															<div id="screenshotName5" class="screenshotName">${app.appScreenshots[4].screenshot}</div>
															<a href="javascript:;" title="删除图片" class="delImg" id="delAppScreenshot5" [#if app.appScreenshots[4].screenshotUrl]style="display:block;"[/#if]>×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="appScreenshotUpload5" />
															<input type="hidden" id="screenshotUrl5" name="appScreenshots[4].screenshotUrl" value="${app.appScreenshots[4].screenshotUrl}"/>
															<input type="hidden" id="screenshot5" name="appScreenshots[4].screenshot" value="${app.appScreenshots[4].screenshot}"/>
														</div>
													</div>
												</td>
											</tr>
											<tr id="imgShowBox2">
												<th>
													<span class="requiredField">*</span>${message("应用截图")}:
												</th>
												<td colspan="2">
													<div style="width:600px;height:40px;">
														<label id="tipInfo">单张图片不超过10K</label>
														<input type="hidden" id="promotionCoversNum" name="appScreenshotsNum" value="${app.promotionCovers?size}"/>
													</div>
													<a href="javascript:void(0);" id="changeOrder">${message("切换顺序")}</a>
													<div class="itemList-upload" style="float:left;">
														<div class="imgShowBox">
															[#if app.promotionCovers?? && app.promotionCovers[0]??]
																<img src="${app.promotionCovers[0].coverUrl}" alt="" id="appScreenshotView6" class="appScreenshotView" style="width:96px;;height:144px;">
															[#else]
																<img src="${base}/resources/console/images/appScreenshotUpload.png" alt="" id="appScreenshotView6" class="appScreenshotView" style="width:96px;;height:144px;">
															[/#if]	
															<div id="screenshotName6" class="screenshotName">${app.promotionCovers[0].coverName}</div>
															<a href="javascript:;" title="删除图片" class="delImg" id="delAppScreenshot6" [#if app.promotionCovers[0].coverUrl]style="display:block;"[/#if]>×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="appScreenshotUpload6" />
															<input type="hidden" id="screenshotUrl6" name="promotionCovers[0].coverUrl" value="${app.promotionCovers[0].coverUrl}"/>
															<input type="hidden" id="screenshot6" name="promotionCovers[0].coverName" value="${app.promotionCovers[0].coverName}"/>
														</div>
													</div>
													<div class="itemList-upload" style="float:left;margin-left:15px;">
														<div class="imgShowBox">
															[#if app.promotionCovers?? && app.promotionCovers[1]??]
																<img src="${app.promotionCovers[1].coverUrl}" alt="" id="appScreenshotView7" class="appScreenshotView" style="width:96px;;height:144px;">
															[#else]
																<input type="hidden" name="validateScreen1" >
																<img src="${base}/resources/console/images/appScreenshotUpload.png" alt="" id="appScreenshotView7" class="appScreenshotView" style="width:96px;;height:144px;">
															[/#if]
															<div id="screenshotName7" class="screenshotName">${app.promotionCovers[1].coverName}</div>
															<a href="javascript:;" title="删除图片" class="delImg" id="delAppScreenshot7" [#if app.promotionCovers[1].coverUrl]style="display:block;"[/#if]>×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="appScreenshotUpload7" />
															<input type="hidden" id="screenshotUrl7" name="promotionCovers[1].coverUrl" value="${app.promotionCovers[1].coverUrl}"/>
															<input type="hidden" id="screenshot7" name="promotionCovers[1].coverName" value="${app.promotionCovers[1].coverName}"/>
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("操作系统")}:
												</th>
												<td class="radioTD" colspan="2">
													<input type="hidden" name="operatingSystem" id="operatingSystem" value="${app.operatingSystem}"/>
													<input type="radio" [#if app.operatingSystem == "android"]checked[/#if] disabled="disabled" value="android" id="operatingSystemandroid"><label for="operatingSystemandroid">android</label>
													<input type="radio" [#if app.operatingSystem == "ios"]checked[/#if] disabled="disabled" value="ios" id="operatingSystemios"><label for="operatingSystemios">ios</label>
													<input type="radio" [#if app.operatingSystem == "hybird"]checked[/#if] disabled="disabled" value="hybird" id="operatingSystemhybird"><label for="operatingSystemhybird">hybird</label>
													<input type="radio" [#if app.operatingSystem == "hbuilder"]checked[/#if] disabled="disabled" value="hbuilder" id="operatingSystemhbuilder"><label for="operatingSystemhbuilder">hbuilder</label>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("运行方式")}:
												</th>
												<td class="radioTD" colspan="2">
													<input type="radio" [#if app.runType == "build_in"]checked[/#if] value="build_in" id="operatingSystembuild_in" name="runType"><label for="operatingSystembuild_in">内嵌应用</label>
													<input type="radio" [#if app.runType == "thirdparty"]checked[/#if] value="thirdparty" id="operatingSystemthirdparty" name="runType"><label for="operatingSystemthirdparty">第三方</label>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("安装URL")}:
												</th>
												<td colspan="2">
													<div class="uploadContainer left" style="margin-left: 7px;">
														<input type="text" name="installUrl"  class="form-control" value="${app.installUrl}"/>
													</div>
													<div class="right">
														<label>第三方应用的下载地址</label>
													</div>
												</td>
											</tr>
											[#if app.operatingSystem == "hybird" || app.operatingSystem == "hbuilder"]
											<tr>
												<th>
													<span class="requiredField">*</span>${message("应用上传")}:
												</th>
												<td colspan="2">
													<div class="uploadContainer" >
														<div style="float:left;" style="width:150px;">
															<input type="file" id="appUpload" />
															<input type="hidden" name="appAttachment" id="appAttachment" value="${app.appAttachment}">
														</div>
														<div style="float:left;margin-left:10px;">
															<input type="button" class="btn btn-danger" value="删除" onclick="deleteAppFile()">
														</div>
														<div>
															<a href="${app.appAttachment}" class="btn btn-primary" style="margin-left: 4px;">
																<span class="refreshIcon">&nbsp;</span>下载源文件
															</a>
														</div>
														<div style="float:left;margin-left:10px;margin-top:10px;">
															<label>支持上传zip格式的压缩包</label>
														</div>
													</div>
												</td>
											</tr>
											[/#if]
											<tr>
												<th>
													<span class="requiredField">*</span>${message("应用图标")}:
												</th>
												<td colspan="2">
													<div class="itemList-upload" style="float:left;">
														<div class="imgShowBox">
															[#if app.logoAppImg??]
														        <img src="${app.logoAppImg}" alt="" id="logoAppImgView" class="logoAppImgView" >
														    [#else]
														        <img src="${base}/resources/console/images/appIconUpload.png" alt="" id="logoAppImgView" class="logoAppImgView" >
														    [/#if]
															
															<a href="javascript:;" title="删除图片" class="delImg" id="delLogoAppImg">×</a>
														</div>
														<div class="uploadContainer" style="margin-left: 7px;">
															<input type="file" id="logoAppImgUpload" />
															<input type="hidden" id="logoAppImg" name="logoAppImg" value="${app.logoAppImg}">
														</div>
													</div>
													<div style="margin-left:25%;">
														<label>支持大小为98*98px PNG图片，大小为不超过20K</label>
													</div>
												</td>
											</tr>
											
										 	<tr>
												<th>
													<span class="requiredField">*</span>${message("打开URL")}:
												</th>
												<td colspan="2" style="text-align: left;">
													<div class="left" style="width:40%;">
														<input type="text" name="openUrl" class="form-control" value="${app.openUrl}"/>
													</div>
													<div style="margin-left:42%;">
														<label>打开应用的URL地址</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("应用大小")}:
												</th>
												<td colspan="2">
													<div class="left">
														<input type="text" name="appSize" class="form-control" value="${app.appSize}"/>
													</div>
													<div class="right">
														<label>如：56K，9.2M</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("版本名称")}:
												</th>
												<td colspan="2">
													<div style="width:35%;">
														<input type="text" name="versionName" class="form-control" value="${app.versionName}"/>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("版本号")}:
												</th>
												<td colspan="2">
													<div class="left">
														<input type="text" name="versionCode" class="form-control" value="${app.versionCode}"/>
													</div>
													<div class="right">
														<label>如：1.0.1</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("应用标识")}:
												</th>
												<td colspan="2">
													<div class="left">
														<input type="text" name="appCode" class="form-control" value="${app.appCode}"/>
													</div>
													<div class="right">
														<label>英文名字，如：news,bus等</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													${message("关键词")}:
												</th>
												<td colspan="2">
													<div class="left">
														<input type="text" name="keyWord" class="form-control" value="${app.keyWord}"/>
													</div>
													<div class="right">
														<label>多个关键词请以中文逗号隔开</label>
													</div>
												</td>
											</tr>
											<tr>
												<th>
													<span class="requiredField">*</span>${message("应用分类")}:
												</th>
												<td colspan="2">
													<select name="appCategoryId" data-placeholder="请选择分类" class="chosen-select" style="width:200px;">
														<option></option>
														[#list appCategories as appCategory]
															<option value="${appCategory.id}" 
															[#if app.appCategory??]
																[#if app.appCategory.id == appCategory.id]selected="true"[/#if]
															[/#if]
															>${appCategory.name}</option>
														[/#list]
													</select>
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
	             <!-- end -->
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
 <script>
    $(document).ready(function () {
        $('.fancybox').fancybox({
            openEffect: 'none',
            closeEffect: 'none'
        });
    });
</script>
<script>
    var config = {
        '.chosen-select': {},
        '.chosen-select-deselect': {
            allow_single_deselect: true
        },
        '.chosen-select-no-single': {
            disable_search_threshold: 10
        },
        '.chosen-select-no-results': {
            no_results_text: '无选择项'
        },
        '.chosen-select-width': {
            width: "95%"
        }
    }
    for (var selector in config) {
        $(selector).chosen(config[selector]);
    }
</script>
</body>
</html>
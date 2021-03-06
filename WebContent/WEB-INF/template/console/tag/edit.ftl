<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("console.tag.edit")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
<link href="${base}/resources/console/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js?time=${.now?date}${.now?time}"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $browserButton = $("#browserButton");
	var $columnCoverImageUploadMO = $("#columnCoverImageUploadMO");
	var $showColumnCoverImageMO = $("#showColumnCoverImageMO");
	var $columnCoverImageUploadED = $("#columnCoverImageUploadED");
	var $showColumnCoverImageED = $("#showColumnCoverImageED");
	[@flash_message /]
	
	$browserButton.browser();
	
	// 表单验证
	$inputForm.validate({
		rules: {
			name: "required",
			order: "digits"
		}
	});
	//移动端封面图(MO):
	$columnCoverImageUploadMO.uploadify({  
        'successTimeout' : 50000,
        'height'        : 27,   
        'width'         : 80,    
        'buttonText'    : '浏览',  
        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
        'uploader'      : '${base}/console/file/upload.ct?fileType=image',  
        'auto'          : true,
        'multi'          : true, //是否支持多文件上传  
	    'simUploadLimit' : 1, //一次同步上传的文件数目     
	    'sizeLimit'      : 19871202, //设置单个文件大小限制     
	    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
	    'fileObjName'    :  'file',
	    'fileTypeDesc'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',       //图片选择描述  
        'fileTypeExts'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//允许的格式      
        'formData'      : {'token' : getCookie("token") },
        //上传成功  
        'onUploadSuccess' : function(file, data, response) {  
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            if(messageType == 'success'){
	            $showColumnCoverImageMO.attr("src",contentImgFileUrl);
	            $("#mobileCoverMO").val(contentImgFileUrl);
	             $showColumnCoverImageMO.show(100);

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
    
    	//移动端封面图(ED):
	$columnCoverImageUploadED.uploadify({  
        'successTimeout' : 50000,
        'height'        : 27,   
        'width'         : 80,    
        'buttonText'    : '浏览',  
        'swf'           : '${base}/resources/console/uploadify/uploadify.swf',  
        'uploader'      : '${base}/console/file/upload.ct?fileType=image',  
        'auto'          : true,
        'multi'          : true, //是否支持多文件上传  
	    'simUploadLimit' : 1, //一次同步上传的文件数目     
	    'sizeLimit'      : 19871202, //设置单个文件大小限制     
	    'queueSizeLimit' : 1, //队列中同时存在的文件个数限制
	    'fileObjName'    :  'file',
	    'fileTypeDesc'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',       //图片选择描述  
        'fileTypeExts'  :  '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//允许的格式      
        'formData'      : {'token' : getCookie("token") },
        //上传成功  
        'onUploadSuccess' : function(file, data, response) {  
            var dataJson = JSON.parse(data);
            var contentImgFileUrl = dataJson['url'];
            var messageContent = dataJson['message']['content'];
            var messageType = dataJson['message']['type'];
            if(messageType == 'success'){
	            $showColumnCoverImageED.attr("src",contentImgFileUrl);
	            $("#mobileCoverED").val(contentImgFileUrl);
	             $showColumnCoverImageED.show(100);

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
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/console/common/index.ct">${message("console.path.index")}</a> &raquo; ${message("console.tag.edit")}
	</div>
	<form id="inputForm" action="update.ct" method="post">
		<input type="hidden" name="id" value="${tag.id}" />
		<table class="input">
			<tr>
				<th>
					${message("Tag.type")}:
				</th>
				<td>
					${message("Tag.Type." + tag.type)}
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("Tag.name")}:
				</th>
				<td>
					<input type="text" name="name" class="text" value="${tag.name}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("Tag.icon")}:
				</th>
				<td>
					<input type="text" name="icon" class="text" value="${tag.icon}" maxlength="200" />
					<input type="button" id="browserButton" class="button" value="${message("console.browser.select")}" />
					[#if tag.icon??]
						<a href="${tag.icon}" target="_blank">${message("console.common.view")}</a>
					[/#if]
				</td>
			</tr>
			 <tr>
				<th>
					${message("console.mobile.mobileCover")}(MO):
				</th>
				<td>
					<input type="file" id="columnCoverImageUploadMO" />
					<img src="${tag.moMobileCover}" height="20%" id="showColumnCoverImageMO" />
				   <input type="hidden" name="moMobileCover"  class="text" id="mobileCoverMO" value ="${tag.moMobileCover}"/>
				</td>
			 </tr>
			 <tr>
				<th>
					${message("console.mobile.mobileCover")}(ED):
				</th>
				<td>
					<input type="file" id="columnCoverImageUploadED" />
					<img src="${tag.edMobileCover}" height="20%" id="showColumnCoverImageED" />
				   <input type="hidden" name="edMobileCover"  class="text" id="mobileCoverED" value ="${tag.edMobileCover}"/>
				</td>
			 </tr>
			<tr>
				<th>
					${message("Tag.memo")}:
				</th>
				<td colspan="4">
					<input type="text" name="memo" class="text" value="${tag.memo}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("console.common.order")}:
				</th>
				<td>
					<input type="text" name="order" class="text" value="${tag.order}" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("console.common.submit")}" />
					<input type="button" class="button" value="${message("console.common.back")}" onclick="location.href='list.ct'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
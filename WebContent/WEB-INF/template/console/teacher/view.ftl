<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("console.member.view")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
<link href="${base}/resources/console/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/console/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
</head>
<body>
	<div class="path">
		<a href="${base}/console/common/index.ct">${message("console.path.index")}</a> &raquo; ${message("console.member.view")}
	</div>
	<ul id="tab" class="tab">
		<li>
			<input type="button" value="${message("console.member.base")}" />
		</li>
		[#if memberAttributes?has_content]
			<li>
				<input type="button" value="${message("console.member.profile")}" />
			</li>
		[/#if]
	</ul>
	<table class="input tabContent">
		[#if member.isLocked]
			<tr>
				<th>
					${message("Member.lockedDate")}:
				</th>
				<td>
					${member.lockedDate?string("yyyy-MM-dd HH:mm:ss")}
				</td>
				<td colspan="2">
					&nbsp;
				</td>
			</tr>
		[/#if]
		<tr>
			<th>
				${message("Member.username")}:
			</th>
			<td>
				${member.username}
			</td>
			<th>
				${message("Member.email")}:
			</th>
			<td>
				${member.email}
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.name")}:
			</th>
			<td>
				${member.name}
			</td>
			<th>
				${message("Member.mobile")}:
			</th>
			<td>
				${member.mobile}
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.memberRank")}:
			</th>
			<td>
				${member.memberRank.name}
			</td>
			<th>
				${message("console.member.status")}:
			</th>
			<td>
				[#if !member.isEnabled]
					<span class="red">${message("console.member.disabled")}</span>
				[#elseif member.isLocked]
					<span class="red"> ${message("console.member.locked")} </span>
				[#else]
					<span class="green">${message("console.member.normal")}</span>
				[/#if]
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.point")}:
			</th>
			<td>
				${member.point}
			</td>
			<th>
				${message("console.member.reviewCount")}:
			</th>
			<td>
				${member.reviews?size}
			</td>
		</tr>
		<tr>
			<th>
				${message("console.member.consultationCount")}:
			</th>
			<td>
				${member.consultations?size}
			</td>
			<th>
				${message("console.member.favoriteProductCount")}:
			</th>
			<td>
				${member.favoriteProducts?size}
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.vipCode")}:
			</th>
			<td>
				${member.vipCode}
			</td>
			<th>
				${message("Member.vipNumber")}:
			</th>
			<td>
				${member.vipNumber}
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.balance")}:
			</th>
			<td>
				${currency(member.balance, true)}
				<a href="../deposit/list.ct?memberId=${member.id}">[${message("console.member.viewDeposit")}]</a>
			</td>
			<th>
				${message("Member.amount")}:
			</th>
			<td>
				${currency(member.amount, true)}
			</td>
		</tr>
		<tr>
			<th>
				${message("console.common.createDate")}:
			</th>
			<td>
				${member.createDate?string("yyyy-MM-dd HH:mm:ss")}
			</td>
			<th>
				${message("Member.loginDate")}:
			</th>
			<td>
				${(member.loginDate?string("yyyy-MM-dd HH:mm:ss"))!"-"}
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.registerIp")}:
			</th>
			<td>
				${member.registerIp}
			</td>
			<th>
				${message("Member.loginIp")}:
			</th>
			<td>
				${(member.loginIp)!"-"}
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.buyCount")}:
			</th>
			<td>
				${(member.buyCount)!"-"}
			</td>
			<th>
				${message("Member.totalConsumption")}:
			</th>
			<td>
				${currency(member.totalConsumption, true)}
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.refundsCount")}:
			</th>
			<td>
				${(member.refundsCount)!"-"}
			</td>
			<th>
				${message("Member.refundsAmount")}:
			</th>
			<td>
				${currency(member.refundsAmount, true)}
			</td>
		</tr>
		<tr>
			<th>
				${message("Member.lastPurchaseDate")}:
			</th>
			<td>
				${(member.lastPurchaseDate?string("yyyy-MM-dd HH:mm:ss"))!"-"}
			</td>
			<th>
				${message("Member.lastPurchaseAmount")}:
			</th>
			<td>
				${currency(member.lastPurchaseAmount, true)}
			</td>
		</tr>
	</table>
	[#if memberAttributes?has_content]
		<table class="input tabContent">
			[#list memberAttributes as memberAttribute]
				<tr>
					<th>
						${memberAttribute.name}:
					</th>
					<td>
						[#if memberAttribute.type == "name"]
							${member.name}
						[#elseif memberAttribute.type == "gender"]
							${message("Member.Gender." + member.gender)}
						[#elseif memberAttribute.type == "birth"]
							${member.birth}
						[#elseif memberAttribute.type == "area"]
							[#if member.area??]
								${member.area}
							[#else]
								${member.areaName}
							[/#if]
						[#elseif memberAttribute.type == "address"]
							${member.address}
						[#elseif memberAttribute.type == "zipCode"]
							${member.zipCode}
						[#elseif memberAttribute.type == "phone"]
							${member.phone}
						[#elseif memberAttribute.type == "mobile"]
							${member.mobile}
						[#elseif memberAttribute.type == "height"]
							${member.height}
						[#elseif memberAttribute.type == "weight"]
							${member.weight}
						[#elseif memberAttribute.type == "text"]
							${member.getAttributeValue(memberAttribute)}
						[#elseif memberAttribute.type == "select"]
							${member.getAttributeValue(memberAttribute)}
						[#elseif memberAttribute.type == "checkbox"]
							[#list member.getAttributeValue(memberAttribute) as option]
								${option}
							[/#list]
						[/#if]
					</td>
				</tr>
			[/#list]
		</table>
	[/#if]
	<table class="input">
		<tr>
			<th>
				&nbsp;
			</th>
			<td>
				<input type="button" class="button" value="${message("console.common.back")}" onclick="location.href='list.ct'" />
			</td>
		</tr>
	</table>
</body>
</html>
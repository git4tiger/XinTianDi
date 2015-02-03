<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%response.setHeader("Cache-Control","no-store");%>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<title>玉林 - 新天地</title>
<!--框架必需start-->
<script type="text/javascript" src="<%=path%>/libs/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/language/cn.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/framework.js"></script>
<link href="<%=path%>/libs/css/import_basic.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=path%>/" scrollerY="false"/>
<link rel="stylesheet" type="text/css" id="customSkin"/>
<!--框架必需end-->
<link rel="stylesheet" type="text/css" href="<%=path%>/libs/bigautocomplete/css/jquery.bigautocomplete.css"/>
<!-- 表单验证start -->
<script src="<%=path%>/libs/js/form/validationRule.js" type="text/javascript"></script>
<script src="<%=path%>/libs/js/form/validation.js" type="text/javascript"></script>
<!-- 表单验证end -->
<!-- 日期控件start -->
<script src="<%=path%>/libs/js/form/datePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 日期控件end -->
<!-- 自动补全start -->
<script type="text/javascript" src="<%=path%>/libs/bigautocomplete/js/jquery.bigautocomplete.js"></script>
<!-- 自动补全end -->
</head>
<body>
<form action="<%=path%>/plan/update.action" method="post" name="classesForm" failAlert="表单填写不正确，请按要求填写！" target="frmright">
<input type="hidden" name="deleteId" value="${plan.id}"/>
<div class="box1" panelWidth="780">
	<fieldset>
		<legend>&nbsp;</legend> 
		<table class="tableStyle" formMode="transparent" footer="normal">
			<tr>
				<td width="15%">客户：</td>
				<td width="35%">${plan.cust.name}</td>
				<td>提货日期：</td>
				<td><fmt:formatDate value="${plan.deliveryDate}" pattern="yyyy-MM-dd"/></td>

			</tr>
		</table>
	</fieldset> 
	<div class="height_15"></div>
	<fieldset> 
		<legend>&nbsp;</legend> 
		<table class="tableStyle" footer="normal">
			<tr>
                <td width="45%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="35%">&nbsp;</td>
                <td width="">&nbsp;</td>
            </tr>
		</table>
		<table id="targetTable" class="tableStyle" footer="normal">
			<c:forEach items="${plan.planItem}" var="pi">
				<tr>
	        		<td width="45%" align="center">${pi.good.name}--${pi.good.no}</td>
	              	<td width="10%" align="center">${pi.count}</td>
	             	<td width="35%" align="center">${pi.xmemo}</td>
	              	<td width="" align="center">&nbsp;</td>
	        	</tr>
			</c:forEach>
        </table>
	</fieldset> 
</div>
</form>
<br/>
<br/>
<hr/>
<br/>
<div>
	<center><span><button>打印</button></span></center>
</div>
</body>

</html>
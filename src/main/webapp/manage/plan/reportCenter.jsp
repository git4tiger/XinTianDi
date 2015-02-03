<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<!--框架必需start-->
<script type="text/javascript" src="<%=path%>/libs/js/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/libs/js/framework.js"></script>
<link href="<%=path%>/libs/css/import_basic.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=path%>/" scrollerY="false"/>
<link rel="stylesheet" type="text/css" id="customSkin"/>
<!--框架必需end-->

<!-- 日期选择框start -->
<script type="text/javascript" src="<%=path%>/libs/js/form/datePicker/WdatePicker.js"></script>
<!-- 日期选择框end -->

<!--数字分页start-->
<script type="text/javascript" src="<%=path%>/libs/js/nav/pageNumber.js"></script>
<!--数字分页end-->
<script type="text/javascript">
$(function(){

    top.Dialog.close()

})

</script>
</head>
<body>

<div class="box2" panelTitle="功能面板" roller="false">
<form id="planForm" action="<%=path%>/plan/reportSearch.action" method="post" name="classesForm">
	<table>
		<tr>
			<td>提货时间:从<input truetype="date" class="date" value="<fmt:formatDate value="${deliveryDateStart}" pattern="yyyy-MM-dd"/>" name="deliveryDateStart" type="text"/>&nbsp;&nbsp;到&nbsp;&nbsp;<input truetype="date" class="date" value="<fmt:formatDate value="${deliveryDateEnd}" pattern="yyyy-MM-dd"/>" name="deliveryDateEnd" type="text"/>  </td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>计划时间:从<input truetype="date" class="date" value="<fmt:formatDate value="${createDateStart}" pattern="yyyy-MM-dd"/>" name="createDateStart" type="text"/>&nbsp;&nbsp;到&nbsp;&nbsp;<input truetype="date" class="date" value="<fmt:formatDate value="${createDateEnd}" pattern="yyyy-MM-dd"/>" name="createDateEnd" type="text"/></td>
			<td><select><option>未发货</option><option>发货中</option><option>已发货</option></select></td>
			<td><button type="button" onclick="postData()"><span class="icon_find">查询</span></button></td>
			<td><button type="button" onclick="exportData()"><span class="icon_find">导出</span></button></td>
		</tr>
	</table>
</form>
</div>
<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
	<div class="center">
	<div class="left">
	<div class="right">
		<div class="padding_top5 padding_left10">
			<a href="javascript:;" onclick="addUser()"><span class="icon_add">呵呵</span></a>
			<div class="box_tool_line"></div>
			

		</div>
	</div>		
	</div>	
	</div>
	<div class="clear"></div>
</div> 
<div id="scrollContent" >
	<form action="../../userAction.do?method=getUsersBasic" method="post" id="usersForm">
	<table class="tableStyle" useClick="false"  useCheckBox="false" sortMode="false">
		<tr>
			<th width="25">序号</th>
			<th width="50"><span  id="span_userName">商品</span></th>
			<th width="50"><span  id="span_userName">数量</span></th>
			<th width="50"><span  id="span_userName">总计(${countPackage}包)</span></th>
		</tr>
		
		<c:forEach items="${list}" var="pr" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${pr.goodName}-${pr.goodNo}</td>
				<td>${pr.goodCount}</td>
		    </tr>
		</c:forEach>

	</table>
	</form>
</div>
<div style="height:35px;">
	<div class="float_left padding5">
		
	</div>
	<div class="float_right padding5">
		
	</div>
	<div class="clear"></div>
</div>
<script type="text/javascript">
var fixObjHeight=150;
function initComplete(){
	 $("#searchPanel").bind("stateChange",function(e,state){
		if(state=="hide"){
			fixObjHeight=90;
		}
		else if(state=="show"){
			fixObjHeight=150;
		}
		triggerCustomHeightSet();
	});
}
function customHeightSet(contentHeight){
	var windowWidth=document.documentElement.clientWidth;
	$("#scrollContent").height(contentHeight-fixObjHeight);
	$("#scrollContent").width(windowWidth-4);
}
///添加
	function addUser() {
	    var diag = new top.Dialog();
		diag.Title = "新增";
		diag.URL = "<%=path%>/manage/plan/add.jsp";
		diag.Width=700;
		diag.Height=600;
		diag.show();
	
		
	}
	
		//提交表单
	function postData(){
		var form = document.getElementById("planForm");
		form.submit();
	}
		
		
	function exportData(){
		var form = document.getElementById("planForm");
		form.action="<%=path%>/plan/exportExcel.action";
		form.submit();
	}
	//批量删除
	function deleteUser() {
		top.Dialog.alert("向后台发送ajax请求来批量删除。见JAVA版或.NET版演示。");
	}
	
	//导入
	function importUser() {
		top.Dialog.alert("见JAVA版或.NET版演示。");
	}
	//导出
	function exportUser() {
		top.Dialog.alert("见JAVA版或.NET版演示。");
	}
	
	//导出所有
	function exportUser2() {
		top.Dialog.alert("见JAVA版或.NET版演示。");
	}
	
	//查看
	function onView(){
		top.Dialog.open({URL:"../../sample/layout/user-management-content2.html",Title:"查看",Width:500,Height:330}); 
	}
	
	//修改
	function onEdit(){
		top.Dialog.alert("见JAVA版或.NET版演示。");
	}
	
	//删除
	function onDelete(){
		top.Dialog.confirm("确定要删除该记录吗？",function(){
		  	widow.location.href="<%=path%>/athlete/delete";
		});
	}
</script>
</body>

</html>
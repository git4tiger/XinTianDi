<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
    <form id="planForm" action="<%=path%>/plan/search.action" method="post" name="classesForm">
		<table>
			<tr>
				<td>姓名：<input name="custName" type="text" value="${custName}"/></td>
				<td>提货时间:<input truetype="date" class="date" value="<fmt:formatDate value="${deliveryDate}" pattern="yyyy-MM-dd"/>" type="text" name="deliveryDate"/></td>
				<td>
					<select name="status">
						<option value="">全部</option>
						<option value="待出库" <c:if test="${'待出库'==status}">selected="selected"</c:if>>待出库</option>
						<option value="已出库" <c:if test="${'已出库'==status}">selected="selected"</c:if>>已出库</option>
						
					</select>
				</td>
				<td><button type="button" onclick="postData()"><span class="icon_find">查询</span></button></td>
			</tr>
		</table>
	</form>
</div>



<div style="height:35px;">
	<div class="float_left padding5">
		<button style="padding-left: 5px; width: 66px;" class="button" onclick="addPlan()"><span style="cursor: default;" class="icon_page">新建</span></button>
		<button style="padding-left: 5px; width: 80px;" class="button" onclick="deleteUser()"><span style="cursor: default;" class="icon_recycle">批量删除</span></button>
		<button style="padding-left: 5px; width: 80px;" class="button" onclick="allOut()"><span style="cursor: default;" class="icon_mark">批量出库</span></button>

	</div>
	<div class="clear"></div>
</div>




<div id="scrollContent" >
	<form action="../../userAction.do?method=getUsersBasic" method="post" id="usersForm">
	<table id="checkboxTable" class="tableStyle"  useCheckBox="true" sortMode="true" mode="list">
		<tr>
			<th width="20">全选</th>
			<th width="25">序号</th>
			<th width="50"><span  id="span_userName">客户</span></th>
			<th width="50"><span  id="span_userName">商品</span></th>
			<th width="50"><span  id="span_userName">数量</span></th>
			<th width="50"><span  id="span_userName">备注</span></th>
			<th width="50"><span  id="span_userName">提货日期</span></th>
			<th width="50"><span  id="span_userName">状态</span></th>
			<th width="50"><span  id="span_userName">操作</span></th>
		</tr>
		
		
		<c:forEach items="${list}" var="plan" varStatus="status">
			<tr>
		        <td rowspan="${fn:length(plan.planItem)}"><input type="checkbox" name="deleteId" value="${plan.id}"/></td>
				<td rowspan="${fn:length(plan.planItem)}">${status.count}</td>
				<td rowspan="${fn:length(plan.planItem)}">
				<a onclick="printPlan(${plan.id})">${plan.cust.name}</a>
				
				</td>
				<td>${plan.planItem[0].good.name}--${plan.planItem[0].good.no}</td>
				<td>${plan.planItem[0].count}</td>
				<td>${plan.planItem[0].xmemo}</td>
				
				<td rowspan="${fn:length(plan.planItem)}"><fmt:formatDate value="${plan.deliveryDate}" pattern="yyyy年MM月dd日"/></td>
				<td rowspan="${fn:length(plan.planItem)}">
				<c:if test="${'待出库'==plan.status}"><font color="green">${plan.status}</font></c:if>
				<c:if test="${'已出库'==plan.status}"><font color="red">${plan.status}</font></c:if>
				</td>
				<td rowspan="${fn:length(plan.planItem)}">
				<span class="img_delete hand" title="删除"  onclick='top.Dialog.confirm("删除 __${plan.cust.name}__",function(){location="<%=path %>/plan/delete?deleteId=${plan.id}"});'></span>
				<span class="img_edit hand" title="修改"  onclick='editPlan(${plan.id});'></span>
				<span class="img_list hand" title="出库"  onclick='top.Dialog.confirm(" ${plan.cust.name}__出库",function(){location="<%=path %>/plan/updateToOut.action?deleteId=${plan.id}"});'></span>
				</td>
	    	</tr>
	    	<c:if test="${fn:length(plan.planItem)>1}">
	    		<c:forEach items="${plan.planItem}" var="pi" begin="1">
	    			<tr>
						<td>${pi.good.name}--${pi.good.no}</td>
						<td>${pi.count}</td>
						<td>${pi.xmemo}</td>
						
				    </tr>
	    		</c:forEach>
	    	</c:if> 
		</c:forEach>
		</table>
	</form>
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
	function addPlan() {
	    var diag = new top.Dialog();
		diag.Title = "新增";
		diag.URL = "<%=path%>/manage/plan/add.jsp";
		diag.Width=700;
		diag.Height=600;
		diag.show();
	
		
	}


///编辑
	function editPlan(id) {
	    var diag = new top.Dialog();
		diag.Title = "修改";
		diag.URL = "<%=path%>/plan/editPlan.action?deleteId="+id;
		diag.Width=700;
		diag.Height=600;
		diag.show();
	
		
	}


///打印
	function printPlan(id) {
	    var diag = new top.Dialog();
		diag.Title = "打印出库单";
		diag.URL = "<%=path%>/plan/printPlan.action?deleteId="+id;
		diag.Width=800;
		diag.Height=700;
		diag.show();
	}


		//提交表单
	function postData(){
		var form = document.getElementById("planForm");
		form.submit();
	}
	//批量删除
	function deleteUser() {
		
		top.Dialog.confirm("数据无法恢复,您确定要删除吗?",function(){
			var msg="";
	    	$("#checkboxTable").find("input[type=checkbox]").each(function(){
		        if($(this).attr("checked")){
		            msg=msg+","+$(this).val()
		        }
		    })
		    if(msg==""){
		        msg="无选择"
		    }
		    location="<%=path %>/plan/deleteAll.action?deleteIds="+msg
		})

	}
	//批量出库
	function allOut() {
		
		top.Dialog.confirm("全部出库吗?",function(){
			var msg="";
	    	$("#checkboxTable").find("input[type=checkbox]").each(function(){
		        if($(this).attr("checked")){
		            msg=msg+","+$(this).val()
		        }
		    })
		    if(msg==""){
		        msg="无选择"
		    }
		    location="<%=path %>/plan/updateAllToOut.action?deleteIds="+msg
		})

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
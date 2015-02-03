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
<link rel="stylesheet" type="text/css" href="<%=path%>/libs/bigautocomplete/css/jquery.bigautocomplete.css"/>
<!-- 日期选择框start -->
<script type="text/javascript" src="<%=path%>/libs/js/form/datePicker/WdatePicker.js"></script>
<!-- 日期选择框end -->

<!--数字分页start-->
<script type="text/javascript" src="<%=path%>/libs/js/nav/pageNumber.js"></script>
<!--数字分页end-->

<!-- 自动补全start -->
<script type="text/javascript" src="<%=path%>/libs/bigautocomplete/js/jquery.bigautocomplete.js"></script>
<!-- 自动补全end -->

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
			<td>片区:<input id="areaAutoComplete" name="area" type="text"/></td>
			<td>客户:<input id="custAutoComplete" name="cust" type="text"/></td>
			<td>商品:<input id="goodAutoComplete" name="good" type="text"/></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;<input truetype="date" class="date" value="" name="dateStart" type="text"/>&nbsp;&nbsp;到&nbsp;&nbsp;<input truetype="date" class="date" value="" name="dateEnd" type="text"/></td>
			<td><button type="button" onclick="exportData()"><span class="icon_find">导出</span></button></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr><td><h3>以下几个组合方式:</h3></td></tr>
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;1.一个时间</td></tr>
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;2.时间段</td></tr>
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;3.片区  - 时间段</td></tr>
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;4.客户  - 时间段</td></tr>
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;5.商品  - 时间段</td></tr>
	</table>
</form>
</div>
<script type="text/javascript">
$(function(){
    	var url_good = "<%=path%>/ajax/ajaxPlanGood";
    	var url_cust = "<%=path%>/ajax/ajaxPlanCust";
    	var url_area = "<%=path%>/ajax/ajaxPlanArea";
	    $("#goodAutoComplete").bigAutocomplete({url:url_good,
                                  callback:function(data){
                             	  }});
	    $("#custAutoComplete").bigAutocomplete({url:url_cust,
                                  callback:function(data){
                             	  }});
	    $("#areaAutoComplete").bigAutocomplete({url:url_area,
                                  callback:function(data){
                             	  }});
})
</script>
</body>
</html>
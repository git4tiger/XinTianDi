<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
<!-- 表单验证start -->

<script src="<%=path%>/libs/js/form/validationRule.js" type="text/javascript"></script>

<script src="<%=path%>/libs/js/form/validation.js" type="text/javascript"></script>

<!-- 表单验证end -->

</head>
<body><center>
    <form action="<%=path%>/area/save.action" method="post" name="classesForm" failAlert="表单填写不正确，请按要求填写！" target="frmright">
        <table>
            <tr>
                <td>名称</td>
                <td><input type="text" style="width: 200px; font-family: 微软雅黑; font-size: 14px;" value="" name="area.name" class="validate[required]" /></td>
            </tr>
            <tr>
                <td><input type="submit" value="保存"/></td>
                <td><input type="reset" value="重置"/></td>
            </tr>
        </table>
    </form>
    </center>
    <script>
	function closeWin(){
		top.Dialog.close()
	}
	</script>
</body>

</html>
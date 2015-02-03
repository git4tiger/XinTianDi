<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<form action="<%=path%>/plan/save.action" method="post" name="classesForm" failAlert="表单填写不正确，请按要求填写！" target="frmright">
<div class="box1" panelWidth="650">
	<fieldset> 
		<legend>基本信息</legend> 
		<table class="tableStyle" formMode="transparent" footer="normal">
			<tr>
				<td width="15%">客户：</td>
				<td width="35%"><input type="text" value="" id="custAutoComplete" name="custName"/><input type="hidden" id="custId" name="cust"/></td>
				<td width="15%">商品：</td>
				<td><input type="text" id="goodAutoComplete" style="width:200px;"/></td>
			</tr>
			<tr>
				<td>提货日期：</td>
				<td><input truetype="date" class="date" name="deliveryDate" type="text"/></td>
				<td>操作：</td>
				<td><button>保存</button></td>
			</tr>
		</table>
	</fieldset> 
	<div class="height_15"></div>
	<fieldset> 
		<legend>列表</legend> 
		<table class="tableStyle" footer="normal">
			<tr>
                <td width="25%">商品</td>
                <td width="25%">数量</td>
                <td width="35%">备注</td>
                <td width="">&nbsp;</td>
            </tr>
		</table>
		<table id="targetTable" class="tableStyle" footer="normal">
        	<tr>
        		<td width="25%"><input readonly="readonly" type="text" class="validate[required]" name="goodName"/><input type="hidden" name="good"/></td>
              	<td width="25%"><input type="text" class="validate[required]" name ="goodCount"/></td>
             	<td width="35%"><input type="text" name="goodXmemo" value="无"/></td>
              	<td width="">&nbsp;</td>
        	</tr>
        </table>
	</fieldset> 
</div>

<table width="300" id = "sourceTable" style="display:none;">
           <tr>
              <td width="25%"><input readonly="readonly" type="text" name="goodName"/><input type="hidden" name="good"/></td>
              <td width="25%"><input type="text" name ="goodCount"/></td>
              <td width="35%"><input type="text" name= "goodXmemo" value="."/></td>
              <td width=""><input type="button"  name = "deleteButton" value="删除" onclick="deleteRow(this,'targetTable')"/></td>
           </tr>
</table>
</form>

    
    <script>
    var insertFlag=false;
    $(function(){
    	var url_good = "<%=path%>/ajax/ajaxPlanGood";
    	var url_cust = "<%=path%>/ajax/ajaxPlanCust";
	    $("#goodAutoComplete").bigAutocomplete({url:url_good,
                                  callback:function(data){
	    							if(insertFlag){
	    								insertRow('targetTable','sourceTable');
	    							}else{
	    								insertFlag=true;
	    							}
	    							$("#targetTable tr:last input:eq(0)").val(data.title);
	    							$("#targetTable tr:last input:eq(1)").val(data.result);
	    							$("#goodAutoComplete").val("");
	    							$("#goodAutoComplete").focus()
                             	  }});
	    $("#custAutoComplete").bigAutocomplete({url:url_cust,
                                  callback:function(data){
	    							$("#custId").val(data.result);
                             	  }});
	})
	function closeWin(){
		top.Dialog.close()
	}
	function insertRow(targetTable,sourceTable){
      var oTBODY     = document.getElementById(targetTable).tBodies.item(0);
      var oTBODYData = document.getElementById(sourceTable).tBodies.item(0);
      var rowsCount = oTBODYData.rows.length;
      for(var i=0;i<rowsCount;i++){
        oTBODY.appendChild(oTBODYData.rows[i].cloneNode(true));
      }
    }

        
	function deleteRow(Field,targetTable){
	      var findex = getElementOrder(Field);
	      document.getElementById(targetTable).deleteRow(findex);
	}

              

	//  查询出将要删除的行所在的位置index
	
	function getElementOrder(field){
	    var i = 0;
	    var order = 0;
	    var elements = document.getElementsByName(field.name);
	    for(i=0;i<elements.length;i++){
	        order++;
	        if(elements[i]==field){
	            break;
	        }
	    }
	    return order;
	}
	</script>
</body>

</html>
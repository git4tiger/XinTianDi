package cn.yl.util;

public class Postfix {
	
	//删除文件后缀
    public static String delPostfix(String fileName){
    	StringBuffer pathStr=new StringBuffer(fileName);
    	String str=pathStr.reverse().toString();    	
    	int index=str.indexOf(".");	
    	return fileName.substring(0, fileName.length()-index-1);
    }
    
    //取得文件后缀
    public static String getPostfix(String fileName){
    	StringBuffer pathStr=new StringBuffer(fileName);
    	String strr=pathStr.reverse().toString();    	
    	int index=strr.indexOf(".");	
    	
    	String ext=fileName.substring(fileName.length()-index);
    	  String str="";
    	  if(ext.equalsIgnoreCase("xls"))
    	   str="xls"; 
    	  else if(ext.equalsIgnoreCase("xlsx"))
    	   str="xlsx";
    	  else if(ext.equalsIgnoreCase("jpg")){
    	   str="jpg";
    	  }
    	  else if(ext.equalsIgnoreCase("png")){
    	   str="png";
    	  }
    	  else if(ext.equalsIgnoreCase("gif")){
       	   str="gif";
       	  }
  
        return str;
    }
    
/*    public static void main(String args[]){
    	System.out.println(delPostfix("abcdfsssssssss.sssssss.sssss.fdfsdfdo.c"));
    	System.out.println(getPostfix("ab.c.D.dOC"));
    	
    	System.out.println(".");
    	
    }*/
}

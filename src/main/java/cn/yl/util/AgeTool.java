package cn.yl.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class AgeTool {
    public static int toAge(Date birthday){
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy");
    	String now=sdf.format(new Date());
    	String birthdayYear=sdf.format(birthday);
    	int a=Integer.parseInt(now);
    	int b=Integer.parseInt(birthdayYear);
    	
    	return a-b;
    }
}

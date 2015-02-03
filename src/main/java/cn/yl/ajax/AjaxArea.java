package cn.yl.ajax;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import cn.yl.bean.Area;
import cn.yl.web.action.BaseAction;

@Namespace("/base")
@Action
public class AjaxArea extends BaseAction<Area>{

	public void exetu() throws Exception{
		
		List<Area> list=service.find();
		StringBuffer sb=new StringBuffer();
		if(list!=null&&list.size()>0){
			sb.append("{\"list\":[");
			for(int i=0;i<list.size();i++){
				sb.append("{\"key\":\"").append(list.get(i).getName()+"\"").append(",\"value\":\"").append(list.get(i).getId()+"\"},");
			}
			sb.deleteCharAt(sb.length()-1);
			sb.append("]}");
		}
		HttpServletResponse rep=ServletActionContext.getResponse();
		rep.setContentType("text/html");
		rep.setCharacterEncoding("utf-8");
		PrintWriter pw=rep.getWriter();
		
		pw.write(sb.toString());
	}
}

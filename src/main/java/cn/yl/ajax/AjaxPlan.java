package cn.yl.ajax;

import java.io.PrintWriter;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import cn.yl.bean.Area;
import cn.yl.bean.Cust;
import cn.yl.bean.Good;
import cn.yl.service.AreaServiceI;
import cn.yl.service.CustServiceI;
import cn.yl.service.GoodServiceI;
import cn.yl.web.action.BaseAction;

@SuppressWarnings("serial")
@Controller("ajaxPlan")
@Scope("prototype")
public class AjaxPlan extends BaseAction<Good>{
	@Autowired
	private AreaServiceI areaService;
	@Autowired
	private GoodServiceI goodService;
	@Autowired
	private CustServiceI custService;
	private String keyword;
	  
	public void good() throws Exception{  
		//((TServiceI) service).methodName()
		List<Good> list=service.find();
		StringBuffer sb=new StringBuffer("{\"data\":[");
		for(int i=0;i<list.size();i++){
			Good g=list.get(i);
		
		
			sb.append("{\"title\":\"").append(g.getName()+"--"+g.getNo()+"\"")
			  .append(",\"result\":\"").append(g.getId()+"\"},");
		}
		if(list.size()>0){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("]}");
		
		HttpServletResponse rep=ServletActionContext.getResponse();
		rep.setContentType("text/html");
		rep.setCharacterEncoding("utf-8");
		PrintWriter pw=rep.getWriter();
		
		pw.write(sb.toString());
	}
	
	
	public void cust() throws Exception{
		
		List<Cust> list=custService.find("o.name like '"+keyword+"%'");
		StringBuffer sb=new StringBuffer("{\"data\":[");
		
		for(int i=0;i<list.size();i++){
			Cust c=list.get(i);
		
		
			sb.append("{\"title\":\"").append(c.getName()+"\"")
			  .append(",\"result\":\"").append(c.getId()+"\"},");
		}
		if(list.size()>0){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("]}");
		
		HttpServletResponse rep=ServletActionContext.getResponse();
		rep.setContentType("text/html");
		rep.setCharacterEncoding("utf-8");
		PrintWriter pw=rep.getWriter();
		
		pw.write(sb.toString());
	}

	
	public void area() throws Exception{
		
		List<Area> list=areaService.find("o.name like '"+keyword+"%'");
		StringBuffer sb=new StringBuffer("{\"data\":[");
		for(int i=0;i<list.size();i++){
			Area c=list.get(i);
		
		
			sb.append("{\"title\":\"").append(c.getName()+"\"")
			  .append(",\"result\":\"").append(c.getId()+"\"},");
		}
		if(list.size()>0){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("]}");
		
		HttpServletResponse rep=ServletActionContext.getResponse();
		rep.setContentType("text/html");
		rep.setCharacterEncoding("utf-8");
		PrintWriter pw=rep.getWriter();
		
		pw.write(sb.toString());
	}

	public String getKeyword() {
		return keyword;
	}


	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}

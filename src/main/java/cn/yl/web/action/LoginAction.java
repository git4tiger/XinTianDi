package cn.yl.web.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;


@Controller("loginAction")
@Scope("prototype")
@SuppressWarnings("serial")
public class LoginAction extends ActionSupport{

	  private String no;
	  private String password;
	  
	public String login(){
		
		if("admin".equals(no)&&"admin".equals(password)){
			ActionContext.getContext().getSession().put("user","admin");
			return "admin";
		}else{
			return "faile";
		}
		
		
	}
	public String logout(){
		ActionContext.getContext().getSession().clear();
		return SUCCESS;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}

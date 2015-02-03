package cn.yl.web.action;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import cn.yl.bean.Area;
import cn.yl.service.AreaServiceI;
import com.opensymphony.xwork2.ActionContext;

@Namespace("/base")
@Action
public class AreaManage extends BaseAction<Area>{
	
	/**
	 * 注入业务逻辑，使当前action调用service.xxx的时候，直接是调用基础业务逻辑
	 * 
	 * 如果想调用自己特有的服务方法时，请使用((TServiceI) service).methodName()这种形式强转类型调用
	 * 
	 * @param service
	 */
	@Autowired
	public void setService(AreaServiceI service) {
		this.service = service;
	}

    public String center(){
    	List<Area> areaList=service.find("");
    	ActionContext.getContext().put("areaList", areaList);
    	return "center";
    }

}

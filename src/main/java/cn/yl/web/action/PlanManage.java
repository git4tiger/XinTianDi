package cn.yl.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.yl.bean.Cust;
import cn.yl.bean.Good;
import cn.yl.bean.Plan;
import cn.yl.bean.PlanItem;
import cn.yl.bean.PlanReport;
import cn.yl.util.ExcelUtils;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
@Controller("planManage")
@Scope("prototype")
public class PlanManage extends BaseAction<Plan>{

	
	private Integer deleteId;
	private String deleteIds;
	private Integer cust;
	private Date deliveryDate;
	private Date deliveryDateStart;
	private Date deliveryDateEnd;
	private Date createDate;
	private Date createDateStart;
	private Date createDateEnd;
	private Integer[] good;
	private Integer[] goodCount;
	private String[] goodXmemo;
	private String custName;
	private String status;
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	private String fileName=ServletActionContext.getServletContext().getContextPath()+"export.xls";
	private File file=new File(fileName);

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public InputStream getInputStream() throws Exception {
		return new FileInputStream(new File(fileName));
	}


	
	/**
	 * 列表
	 * @return
	 */
	public String center() {
		LinkedHashMap<String, String> sortMap = new LinkedHashMap<String, String>();
		sortMap.put("createTime", "desc");
		List<Plan> list = service.find();
		ActionContext.getContext().put("list", list);
		return "center";
	}

	
	/**
	 * 列表查询
	 * @return
	 */
	public String search() {
		StringBuffer hql = new StringBuffer(" 1=1");
		Map<String,Object> param = new HashMap<String,Object>();
		if (deliveryDate != null) {
			hql.append(" and deliveryDate=?");
			param.put("deliveryDate", deliveryDate);
		}
		if (custName != null && !"".equals(custName)) {
			hql.append(" and cust.name like ?");
			param.put("cust.name", custName);
		}
		if (status != null && !"".equals(status)) {
			hql.append(" and status like ?");
			param.put("status", status);
		}

		LinkedHashMap<String, String> sortMap = new LinkedHashMap<String, String>();
		sortMap.put("createTime", "desc");
		List<Plan> list = service.find(hql.toString(), param);
		ActionContext.getContext().put("list", list);
		return "center";
	}

	
	/**
	 * 报表查询
	 * @return
	 */
	public String reportSearch() {
		StringBuffer sql = new StringBuffer(
				"select name as goodName,t_good.id as id,t_good.no as goodNo,goodCount from t_good,(select good_id as goodId,sum(count) as goodCount from t_plan_item where plan_id in(select id from t_plan where 1=1");

		if (deliveryDateStart != null && deliveryDateEnd == null) {
			sql.append(" and deliveryDate like '"
					+ sdf.format(deliveryDateStart) + "'");
		}
		if (deliveryDateStart != null && deliveryDateEnd != null) {
			sql.append(" and deliveryDate >=STR_TO_DATE('"
					+ sdf.format(deliveryDateStart)
					+ "','%Y-%m-%d') and deliveryDate<=STR_TO_DATE('"
					+ sdf.format(deliveryDateEnd) + "','%Y-%m-%d')");
		}

		if (createDateStart != null && createDateEnd == null) {
			sql.append(" and createTime like '" + sdf.format(createDateStart)
					+ "'");
		}
		if (createDateStart != null && createDateEnd != null) {
			sql.append(" and createTime >=STR_TO_DATE('"
					+ sdf.format(createDateStart)
					+ "','%Y-%m-%d') and createTime <=STR_TO_DATE('"
					+ sdf.format(createDateEnd) + "','%Y-%m-%d')");
		}

		sql
				.append(") group by good_id) as myview where t_good.id=myview.goodId");
		List<PlanReport> list = service.findBySql(sql.toString());

		int countPackage = 0;

		for (int i = 0; i < list.size(); i++) {
			countPackage += list.get(i).getGoodCount();
		}

		ActionContext.getContext().put("list", list);
		ActionContext.getContext().put("countPackage", countPackage);
		return "reportCenter";
	}

	
	
	/**
	 * 报表
	 * @return
	 */
	public String reportCenter() {

		List<PlanReport> list = service.findBySql("select name as goodName,t_good.id as id,t_good.no as goodNo,goodCount from t_good,(select good_id as goodId,sum(count) as goodCount from t_plan_item where plan_id in(select id from t_plan) group by good_id) as myview where t_good.id=myview.goodId");
		// where dayofyear(createtime)=dayofyear(now())
		int countPackage = 0;

		for (int i = 0; i < list.size(); i++) {
			countPackage += list.get(i).getGoodCount();
		}

		ActionContext.getContext().put("list", list);
		ActionContext.getContext().put("countPackage", countPackage);
		return "reportCenter";
	}

	/**
	 * 报表
	 * @return
	 */
	public String report() {
		return "report";
	}
	
	
	/**
	 * 保存
	 * @return
	 */
	public String saved() {

		Cust c = new Cust();
		c.setId(cust);
		Plan p = new Plan();
		p.setCreateTime(new Date());
		p.setCust(c);

		p.setDeliveryDate(deliveryDate);
		p.setStatus("待出库");
		service.save(p);

		for (int i = 0; i < good.length; i++) {
			if (good[i] == null) {
				continue;
			}
			Good g = new Good();
			g.setId(good[i]);
			PlanItem item = new PlanItem();
			item.setGood(g);
			item.setPlan(p);
			item.setCount(goodCount[i]);
			item.setCreateTime(new Date());
			item.setXmemo(goodXmemo[i]);
			service.save(item);
		}
		return "save";
	}

	
	/**
	 * 单条删除
	 * @return
	 */
	public String delete() {
		try {
			publicService.delete(PlanItem.class, " o.plan.id=?",
					new Object[] { deleteId });
			publicService.delete(Plan.class, deleteId);
		} catch (Exception e) {
			ActionContext.getContext().put("message", "无法删除,请联系管理员");
			return "deletefaile";
		}

		return "delete";
	}
	
	/**
	 * 批量删除
	 * @return
	 */
	public String deleteAll() {
		String[] ids=deleteIds.split(",");
		for(int i=0;i<ids.length;i++){
			if(ids[i]!=null&&!"".equals(ids[i])){
				try {
					deleteId=Integer.parseInt(ids[i]);
					publicService.delete(PlanItem.class, " o.plan.id=?",
							new Object[] { deleteId });
					publicService.delete(Plan.class, deleteId);
				} catch (Exception e) {
					ActionContext.getContext().put("message", "无法删除,请联系管理员");
					return "deletefaile";
				}
			}
		}
		return "delete";
	}
	
	
	/**
	 * 单条出库
	 * @return
	 */
	public String updateToOut() {
		try {
			Plan p=publicService.find(Plan.class, deleteId);
			p.setStatus("已出库");
			p.setDeliveryDate(new Date());
			publicService.update(p);
		} catch (Exception e) {
			ActionContext.getContext().put("message", "无法出库,请联系管理员");
			return "deletefaile";
		}
		return "delete";
	}
	
	
	/**
	 * 批量出库
	 * @return
	 */
	public String updateAllToOut() {
		String[] ids=deleteIds.split(",");
		for(int i=0;i<ids.length;i++){
			if(ids[i]!=null&&!"".equals(ids[i])){
				try {
					deleteId=Integer.parseInt(ids[i]);
					Plan p=publicService.find(Plan.class, deleteId);
					p.setStatus("已出库");
					p.setDeliveryDate(new Date());
					publicService.update(p);
				} catch (Exception e) {
					ActionContext.getContext().put("message", "无法删除,请联系管理员");
					return "deletefaile";
				}
			}
		}
		return "delete";
	}
	

	
	/**
	 * 导出Excel
	 * @return
	 * @throws Exception
	 */
	public String exportExcel() throws Exception {

		StringBuffer hql = new StringBuffer(" 1=1");
		ArrayList<Object> param = new ArrayList<Object>();
		if (deliveryDateStart != null && deliveryDateEnd == null) {
			hql.append(" and deliveryDate like ?");
			param.add(deliveryDateStart);
		}
		if (deliveryDateStart != null && deliveryDateEnd != null) {
			hql.append(" and deliveryDate >=? and deliveryDate<=?");
			param.add(deliveryDateStart);
			param.add(deliveryDateEnd);
		}

		if (createDateStart != null && createDateEnd == null) {
			hql.append(" and createTime like ?");
			param.add(createDateStart);
		}
		if (createDateStart != null && createDateEnd != null) {
			hql.append(" and createTime >=? and createTime <=?");
			param.add(createDateStart);
			param.add(createDateEnd);
		}

		LinkedHashMap<String, String> sortMap = new LinkedHashMap<String, String>();
		sortMap.put("deliveryDate", "asc");
		List<Plan> list = publicService.getScrollData(Plan.class, -1, -1,
				hql.toString(), param.toArray(), sortMap).getResultlist();

		ExcelUtils.export(list,file);
		return "excel";
	}

	
	public String editPlan(){
		Plan plan=publicService.find(Plan.class,deleteId);
		ActionContext.getContext().put("plan",plan);
		return "editPlan";
	}
	
	public String printPlan(){
		Plan plan=publicService.find(Plan.class,deleteId);
		ActionContext.getContext().put("plan",plan);
		return "printPlan";
	}
	
	
	public String update(){
		
		Plan oldPlan=publicService.find(Plan.class,deleteId);
		publicService.delete(PlanItem.class, " o.plan.id=?",new Object[] { deleteId });
		
		for (int i = 0; i < good.length; i++) {
			if (good[i] == null) {
				continue;
			}
			Good g = new Good();
			g.setId(good[i]);
			PlanItem item = new PlanItem();
			item.setGood(g);
			item.setPlan(oldPlan);
			item.setCount(goodCount[i]);
			item.setCreateTime(new Date());
			item.setXmemo(goodXmemo[i]);
			publicService.save(item);
		}
		
		
		oldPlan.setDeliveryDate(deliveryDate);
		
		publicService.update(oldPlan);
		
		return "update";
	}
	
	
	
	
	
	
	
	
	
	
	public PublicService getPublicService() {
		return publicService;
	}

	public void setPublicService(PublicService publicService) {
		this.publicService = publicService;
	}

	public Integer getDeleteId() {
		return deleteId;
	}

	public void setDeleteId(Integer deleteId) {
		this.deleteId = deleteId;
	}

	public Integer getCust() {
		return cust;
	}

	public void setCust(Integer cust) {
		this.cust = cust;
	}

	public Date getDeliveryDateStart() {
		return deliveryDateStart;
	}

	public void setDeliveryDateStart(Date deliveryDateStart) {
		this.deliveryDateStart = deliveryDateStart;
	}

	public Date getDeliveryDateEnd() {
		return deliveryDateEnd;
	}

	public void setDeliveryDateEnd(Date deliveryDateEnd) {
		this.deliveryDateEnd = deliveryDateEnd;
	}

	public Date getCreateDateStart() {
		return createDateStart;
	}

	public void setCreateDateStart(Date createDateStart) {
		this.createDateStart = createDateStart;
	}

	public Date getCreateDateEnd() {
		return createDateEnd;
	}

	public void setCreateDateEnd(Date createDateEnd) {
		this.createDateEnd = createDateEnd;
	}

	public Integer[] getGood() {
		return good;
	}

	public void setGood(Integer[] good) {
		this.good = good;
	}

	public Integer[] getGoodCount() {
		return goodCount;
	}

	public void setGoodCount(Integer[] goodCount) {
		this.goodCount = goodCount;
	}

	public String[] getGoodXmemo() {
		return goodXmemo;
	}

	public void setGoodXmemo(String[] goodXmemo) {
		this.goodXmemo = goodXmemo;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getFileName() {
		return fileName;
	}

	public String getDeleteIds() {
		return deleteIds;
	}

	public void setDeleteIds(String deleteIds) {
		this.deleteIds = deleteIds;
	}
	
	
}

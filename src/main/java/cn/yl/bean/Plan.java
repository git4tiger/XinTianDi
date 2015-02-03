package cn.yl.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@SuppressWarnings("serial")
@Entity
@Table(name="t_plan")
public class Plan extends Base{
	
	private Cust cust;
	private Date deliveryDate;//提货日期[1955-34-22]
	private String status;//状态[待发货,发货中,已发货]	
	private List<PlanItem> planItem=new ArrayList<PlanItem>();
	
	@ManyToOne(cascade=CascadeType.REFRESH)
	@JoinColumn(name="cust_id")
	public Cust getCust() {
		return cust;
	}
	public void setCust(Cust cust) {
		this.cust = cust;
	}
	
	
	@Temporal(TemporalType.DATE)
	public Date getDeliveryDate() {
		return deliveryDate;
	}
	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@OneToMany(mappedBy="plan")
	public List<PlanItem> getPlanItem() {
		return planItem;
	}
	public void setPlanItem(List<PlanItem> planItem) {
		this.planItem = planItem;
	}
	
}

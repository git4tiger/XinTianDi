package cn.yl.bean;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name="t_plan_item")
public class PlanItem extends Base{
	
	private Good good;
	private int count;
	private String xmemo;//
	private Plan plan;
	
	
	@ManyToOne(cascade=CascadeType.REFRESH)
	@JoinColumn(name="good_id")
	public Good getGood() {
		return good;
	}
	public void setGood(Good good) {
		this.good = good;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getXmemo() {
		return xmemo;
	}
	public void setXmemo(String xmemo) {
		this.xmemo = xmemo;
	}
	
	@ManyToOne(cascade=CascadeType.REFRESH)
	@JoinColumn(name="plan_id")
	public Plan getPlan() {
		return plan;
	}
	public void setPlan(Plan plan) {
		this.plan = plan;
	}
	
	
}

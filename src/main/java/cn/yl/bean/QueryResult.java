package cn.yl.bean;

import java.util.List;

public class QueryResult<T> {
	
	private List<T> resultlist;
	private Long totalrecard;
	private String where;
	
	
	
	public List<T> getResultlist() {
		return resultlist;
	}
	public void setResultlist(List<T> resultlist) {
		this.resultlist = resultlist;
	}
	public Long getTotalrecard() {
		return totalrecard;
	}
	public void setTotalrecard(Long totalrecard) {
		this.totalrecard = totalrecard;
	}
	public String getWhere() {
		return where;
	}
	public void setWhere(String where) {
		this.where = where;
	}
	

}

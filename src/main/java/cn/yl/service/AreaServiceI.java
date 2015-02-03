package cn.yl.service;

import java.util.List;

import cn.yl.bean.Area;


/**
 * 
 * @author 孙宇
 * 
 */
public interface AreaServiceI extends BaseServiceI<Area> {
	public List<Area> findD();
}

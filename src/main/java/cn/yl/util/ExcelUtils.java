package cn.yl.util;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import cn.yl.bean.Plan;
import cn.yl.bean.PlanItem;


public class ExcelUtils {
	
	
	public static void export(List<Plan> plans,File file) throws Exception{
	    SimpleDateFormat sdf=new SimpleDateFormat("MM月dd日");

	    if(file.exists()){
	    	file.delete();
	    }else{
	    	file.createNewFile();
	    }
		FileOutputStream out = new FileOutputStream(file);
		int total=0;
		Workbook wb = new HSSFWorkbook();
		Sheet s = wb.createSheet();
		Plan p=null;
		Row r=null;
		int rowIndex=0;
		r=s.createRow(rowIndex++);
		r.createCell(0).setCellValue("计划时间");
		r.createCell(1).setCellValue("提货时间");
		r.createCell(2).setCellValue("姓名");
		r.createCell(3).setCellValue("片区");
		r.createCell(4).setCellValue("商品名称");
		r.createCell(5).setCellValue("数量(包）");
		r.createCell(6).setCellValue("");
		r.createCell(7).setCellValue("备注");
		for(int i=0;i<plans.size();i++){
			p=plans.get(i);
			List<PlanItem> pItems=p.getPlanItem();
			r=s.createRow(rowIndex++);

			r.createCell(0).setCellValue(""+sdf.format(p.getCreateTime()));
			r.createCell(1).setCellValue(""+(p.getDeliveryDate()==null?"":sdf.format(p.getDeliveryDate())));
			r.createCell(2).setCellValue(""+p.getCust().getName());
			r.createCell(3).setCellValue(""+p.getCust().getArea().getName());
			r.createCell(4).setCellValue(""+pItems.get(0).getGood().getName()+"--"+pItems.get(0).getGood().getNo());
			r.createCell(5).setCellValue(pItems.get(0).getCount());
			r.createCell(7).setCellValue(""+(pItems.get(0).getXmemo().equals("无")?".":pItems.get(0).getXmemo()));
			total+=pItems.get(0).getCount();
			for(int j=1; j<pItems.size();j++){
				
				PlanItem pi=pItems.get(j);
				r=s.createRow(rowIndex++);

				r.createCell(4).setCellValue(""+pi.getGood().getName()+"--"+pi.getGood().getNo());
				r.createCell(5).setCellValue(pi.getCount());
				r.createCell(7).setCellValue(""+(pi.getXmemo().equals("无")?".":pi.getXmemo()));
				total+=pi.getCount();
			}
			
			
		}
		
		
		r=s.createRow(rowIndex+2);
		r.createCell(0).setCellValue("总计");
		r.createCell(5).setCellValue(total);
		
		
		wb.write(out);
		out.close();
	}
	
}

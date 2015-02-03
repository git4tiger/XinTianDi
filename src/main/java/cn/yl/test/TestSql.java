package cn.yl.test;

import java.sql.Connection;
import java.sql.DriverManager;

public class TestSql {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
	    Class.forName("com.mysql.jdbc.Driver"); //加载mysq驱动
		String url = "jdbc:mysql://182.92.111.168:3306/test?characterEncoding=utf8&autoReconnect = true";
		String user = "root";
		String password = "root";
		Connection conn = DriverManager.getConnection(url,user,password);
		System.out.println(conn);
	}

}

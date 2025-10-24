<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>

<%

	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

boolean connection = false;
Connection conn = null;
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@1.1.1.1:SIDname";
String USER_TYPE = "";

try {
	Class.forName(driver); 
	conn = DriverManager.getConnection(url, "highland", "leesgp6000");
	connection = true;
	//System.out.println("DB 立加 己傍");
} catch (Exception e) {
	connection = false;
	//System.out.println("DB立加角菩");
	out.println("fail");
	//e.printStackTrace();
} 
 //SQL 
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery("SELECT USER_TYPE from S_USER WHERE USER_ID = '" + id + "' AND USER_PASSWORD = '" + pwd + "'");
//  ResultSet rs = stmt.executeQuery("SELECT USER_TYPE from S_USER WHERE USER_ID = 'Admin' AND USER_PASSWORD = 'MzcwMA=='");
  ResultSetMetaData rsmd = rs.getMetaData();
	int columnCnt = rsmd.getColumnCount(); //

 int count = 0;

  while(rs.next())
  {
	  count++;
	  USER_TYPE = rs.getString(rsmd.getColumnName(1));
   //out.println(rs.getString(rsmd.getColumnName(1)));
  }
  if(count > 0) {
      out.println(USER_TYPE);
  } else {
	  out.println("fail");
  }
  try{
	  if(rs != null) 
		  rs.close();
	  if(stmt != null) 
		  stmt.close();
	  if(conn != null) 
		  conn.close();
	 }catch(SQLException se){
	//	 System.out.println("按眉 俊矾");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%
boolean connection = false;
Connection conn = null;
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@1.1.1.1:SIDname";
//String url = "jdbc:oracle:thin:@175.120.155.125:15212:highland";
request.setCharacterEncoding("euc-kr");

String qry_where = request.getParameter("data");

try {
	Class.forName(driver); 
	conn = DriverManager.getConnection(url, "DBuser", "DBpassword");
	//conn = DriverManager.getConnection(url, "h1020", "pwdh1020");		
	connection = true;
} catch (Exception e) {
	connection = false;
	out.println(e.getMessage().toString());
	e.printStackTrace();
} 
 //SQL 
  Statement stmt = conn.createStatement();
  //ResultSet rs = stmt.executeQuery("SELECT PACKER_CLIENT_CODE, PACKER_PRODUCT_CODE, PACKER_PRD_NAME, BRAND_CODE, BARCODEGOODS, BASEUNIT, ZEROPOINT, PARCKER_PRD_CODE_FROM, PACKER_PRD_CODE_TO, BARCODEGOODS_FROM, BARCODEGOODS_TO, WEIGHT_FROM, WEIGHT_TO, STATUS, REG_ID, REG_DATE, REG_TIME, MEMO FROM S_BARCODE_INFO");

	ResultSet rs = stmt.executeQuery("SELECT SBI.PACKER_CLIENT_CODE"
		+ ", SBI.PACKER_PRODUCT_CODE"
		+ ", SBI.PACKER_PRD_NAME"
		+ ", SBI.ITEMCODE"
		+ ", BI.ITEM_NAME_KR"
		+ ", SBI.BRAND_CODE"
		+ ", SBI.BARCODEGOODS"
		+ ", SBI.BASEUNIT"
		+ ", SBI.ZEROPOINT"
		+ ", SBI.PACKER_PRD_CODE_FROM"
		+ ", SBI.PACKER_PRD_CODE_TO"
		+ ",SBI.BARCODEGOODS_FROM"
		+ ", SBI.BARCODEGOODS_TO"
		+ ", SBI.WEIGHT_FROM"
		+ ", SBI.WEIGHT_TO"
		+ ", SBI.MAKINGDATE_FROM"
		+ ", SBI.MAKINGDATE_TO"
		+ ", SBI.BOXSERIAL_FROM"
		+ ", SBI.BOXSERIAL_TO"
		+ ", SBI.STATUS"
		+ ", SBI.REG_ID"
		+ ", SBI.REG_DATE"
		+ ", SBI.REG_TIME"
		+ ", SBI.MEMO"

		+ " FROM S_BARCODE_INFO SBI"
		+ " INNER JOIN B_ITEM BI ON SBI.ITEMCODE = BI.ITEM_CODE"
		+ qry_where
		+ " ORDER BY PACKER_PRODUCT_CODE ASC");
  
  ResultSetMetaData rsmd = rs.getMetaData();
	int columnCnt = rsmd.getColumnCount(); //컬럼

  
  while(rs.next())
  {
//   out.println(" <TD>" + rs.getInt("IH.GI_H_ID") + "</TD>");
  out.println(rs.getString(rsmd.getColumnName(1)) + "::" + rs.getString(rsmd.getColumnName(2)) + "::" + rs.getString(rsmd.getColumnName(3)) + "::"	
			+ rs.getString(rsmd.getColumnName(4)) + "::" + rs.getString(rsmd.getColumnName(5)) + "::" + rs.getString(rsmd.getColumnName(6)) + "::" 
			+ rs.getString(rsmd.getColumnName(7)) + "::" + rs.getString(rsmd.getColumnName(8)) + "::" + rs.getString(rsmd.getColumnName(9)) + "::" 
			+ rs.getString(rsmd.getColumnName(10)) + "::" + rs.getString(rsmd.getColumnName(11)) + "::" + rs.getString(rsmd.getColumnName(12)) + "::" 
			+  rs.getString(rsmd.getColumnName(13)) + "::" + rs.getString(rsmd.getColumnName(14)) + "::" + rs.getString(rsmd.getColumnName(15)) + "::" 
			+ rs.getString(rsmd.getColumnName(16)) + "::" + rs.getString(rsmd.getColumnName(17)) + "::" + rs.getString(rsmd.getColumnName(18)) + "::" 
			+ rs.getString(rsmd.getColumnName(19)) + "::" + rs.getString(rsmd.getColumnName(20)) + "::" + rs.getString(rsmd.getColumnName(21)) + "::" 
			+ rs.getString(rsmd.getColumnName(22)) + "::" + rs.getString(rsmd.getColumnName(23)) + "::" + rs.getString(rsmd.getColumnName(24)) + ";;");
  }

  try{
	  if(rs != null) 
		  rs.close();
	  if(stmt != null) 
		  stmt.close();
	  if(conn != null) 
		  conn.close();
	 }catch(SQLException se){
	//	 System.out.println("객체종료에러");
	}

%>

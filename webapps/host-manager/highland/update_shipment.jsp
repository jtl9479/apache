<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>

<%
boolean connection = false;
Connection conn = null;
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@1.1.1.1:SIDname";

request.setCharacterEncoding("euc-kr");

//String data = "test::test::test::test::KG::1::1::1::1::2";
//String[] arrData = data.split("::");

String data = request.getParameter("data");
String[] splitData = data.split("::");

SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMMdd");
  SimpleDateFormat timeformat = new SimpleDateFormat("HHmmss");

  long now = System.currentTimeMillis();
  Date datetime = new Date(now);
  String dateStr = dateformat.format(datetime);
  String timeStr = timeformat.format(datetime);

	String gi_d_id				= splitData[0];				// 출하번호
	String item_code				= splitData[1];				// 품목코드 정보
	String brand_code				= splitData[2];				// 브랜드코드 정보
	String reg_id				= splitData[3];				// 등록자 , 사용자 ID
try {
	Class.forName(driver); 
	conn = DriverManager.getConnection(url, "DBuser", "DBpassword");
	connection = true;
} catch (Exception e) {
	connection = false;
	out.println(e.getMessage().toString());
	e.printStackTrace();
} 

try {

 //SQL
 /*
  String qry = "INSERT INTO S_BARCODE_INFO(BARCODE_INFO_ID, PACKER_CLIENT_CODE, PACKER_PRODUCT_CODE, PACKER_PRD_NAME, BRAND_CODE, BARCODEGOODS, BASEUNIT, ZEROPOINT, PARCKER_PRD_CODE_FROM, PACKER_PRD_CODE_TO, BARCODEGOODS_FROM, BARCODEGOODS_TO, WEIGHT_FROM, WEIGHT_TO, STATUS, REG_ID, REG_DATE, REG_TIME) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
*/  


	String qry = "UPDATE W_GOODS_ID set CHECK_YN='Y', REG_ID = ?, REG_DATE = ?, REG_TIME = ? WHERE GI_D_ID=? AND ITEM_CODE=? AND BRAND_CODE=?";

	// 출고건 체크쿼리
  //String qry = "UPDATE W_GOODS_ID set CHECK_YN='Y', STATUS='20' WHERE GI_D_ID=? AND ITEM_CODE=? AND BRAND_CODE=?";

	// 출고건 체크쿼리
  //String qry = "UPDATE W_GOODS_ID set CHECK_YN=? WHERE GI_D_ID=? AND ITEM_CODE=? AND BRAND_CODE=?";

  PreparedStatement pstmt = conn.prepareStatement(qry);    

  pstmt.setString(1, splitData[3]);
  pstmt.setString(2, dateStr);
  pstmt.setString(3, timeStr);
  pstmt.setInt(4, Integer.parseInt(splitData[0]));
  pstmt.setString(5, splitData[1]);
  pstmt.setString(6, splitData[2]);


/*
  pstmt.setDouble(1, Double.parseDouble(gi_qty));
  pstmt.setInt(2, Integer.parseInt(packing_qty));
  pstmt.setString(3, check_yn);
  pstmt.setInt(4, Integer.parseInt(gi_d_id));
  pstmt.setString(5, item_code);
  pstmt.setString(6, brand_code);
*/
  pstmt.executeUpdate();
  conn.commit();

	if(pstmt != null) 
		pstmt.close();
	if(conn != null) 
		conn.close();
  out.println("s");
} catch (SQLException e) {
		out.println("f");
		out.println(e.getMessage().toString());
		conn.rollback();
		if(conn != null) 
		conn.close();
} catch (Exception ex) {
	out.println(ex.getMessage().toString());
	if(conn != null) 
		conn.close();

} 
	
	
%>

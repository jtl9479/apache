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

try {
	Class.forName(driver); 	
	conn = DriverManager.getConnection(url, "DBuser", "DBpassword");
	//conn = DriverManager.getConnection(url, "h1020", "pwdh1020");
	connection = true;
	//System.out.println("DB Á¢¼Ó¼º°ø");
} catch (Exception e) {
	connection = false;
	System.out.println("DB Á¢¼Ó½ÇÆÐ");
	out.println(e.getMessage().toString());
	e.printStackTrace();
} 
 //SQL 
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery("SELECT " 
								+ "GI_H_ID"
								+ ", GI_D_ID"
								+ ", EOI_ID"
								+ ", ITEM_CODE"
								+ ", ITEM_NAME"
								+ ", EMARTITEM_CODE"
								+ ", EMARTITEM"
								+ ", GI_REQ_PKG"
								+ ", GI_REQ_QTY"
								+ ", AMOUNT"
								+ ", GOODS_R_ID"
								+ ", GR_REF_NO"
								+ ", GI_REQ_DATE"
								+ ", BL_NO"
								+ ", BRAND_CODE"
								+ ", BRANDNAME"
								+ ", CLIENT_CODE"
								+ ", CLIENTNAME"
								+ ", CENTERNAME"
								+ ", ITEM_SPEC"
								+ ", CT_CODE"
								+ ", IMPORT_ID_NO"
								+ ", PACKER_CODE"
								+ ", PACKERNAME"
								+ ", PACKER_PRODUCT_CODE"
								+ ", BARCODE_TYPE"
								+ ", ITEM_TYPE"
								+ ", PACKWEIGHT"
								+ ", BARCODEGOODS"
								+ " FROM VW_PDA_WID_LIST ORDER BY EOI_ID ASC");
  
  ResultSetMetaData rsmd = rs.getMetaData();
	int columnCnt = rsmd.getColumnCount(); //ì»¬ëŸ¼????

  while(rs.next())
  {
   out.println(rs.getString("GI_H_ID") + "::" + rs.getString("GI_D_ID") + "::" + rs.getString("EOI_ID") + "::" + rs.getString("ITEM_CODE") + "::"
			+ rs.getString("ITEM_NAME") + "::" + rs.getString("EMARTITEM_CODE") + "::" + rs.getString("EMARTITEM") + "::" 
			+ rs.getString("GI_REQ_PKG") + "::" + rs.getString("GI_REQ_QTY") + "::" + rs.getString("AMOUNT") + "::" 
			+ rs.getString("GOODS_R_ID") + "::" + rs.getString("GR_REF_NO") + "::" + rs.getString("GI_REQ_DATE") + "::" + rs.getString("BL_NO") + "::"
			+ rs.getString("BRAND_CODE") + "::" + rs.getString("BRANDNAME") + "::" + rs.getString("CLIENT_CODE") + "::" 
			+ rs.getString("CLIENTNAME") + "::" + rs.getString("CENTERNAME") + "::" + rs.getString("ITEM_SPEC") + "::" 
			+ rs.getString("CT_CODE") + "::" + rs.getString("IMPORT_ID_NO") + "::" + rs.getString("PACKER_CODE") + "::" 
			+ rs.getString("PACKERNAME") + "::" + rs.getString("PACKER_PRODUCT_CODE") + "::" + rs.getString("BARCODE_TYPE") + "::" 
			+ rs.getString("ITEM_TYPE") + "::" + rs.getString("PACKWEIGHT") + "::" + rs.getString("BARCODEGOODS") + ";;");
//   out.println(rs.getString("DE_CLIENT(IH.CLIENT_CODE)") + "::" + rs.getString("DE_ITEM(ITEM_CODE)") + ";;");
//      out.println(rs.getString(rsmd.getColumnName(1)));
  }

	try{
	  if(rs != null) 
		  rs.close();
	  if(stmt != null) 
		  stmt.close();
	  if(conn != null) 
		  conn.close();
	 }catch(SQLException se){
	//	 System.out.println("?°ê²° ê°ì²´ ?«ê¸° ?„ë£Œ");
	}

%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
    /* connection pool방식 */
 	 Connection  conn=null;
     String sql = "select * from dept order by no";
     try{  
    	  //context.xml에서 db정보 얻기
    	  Context init = new InitialContext();
    	  DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
    	  conn = ds.getConnection();
    	 //connect얻어서 db쿼리 작업
    	  PreparedStatement pstmt = conn.prepareStatement(sql);
    	  ResultSet rs = pstmt.executeQuery();
    	  %><form action="deptEmpList.jsp">
    	  <fieldset>
    	  <legend>부서리스트</legend>
    	  <p>
    	   <label>부서 리스트</label>
    	    <select name="deptNo">
    	    <option value="00">선택</option>
    	  <%
    	  while(rs.next()){
    	  %>
    	   <option value=<%=rs.getInt(1)%>><%=rs.getInt(1)%>.<%=rs.getString(2)%><%=":"+rs.getString(3)%></option>
    	  <%	  
    	  }
    	  %>
    	   </select>
    	   </p>
    	   <p>
    	   <input type="submit" value="전송">
    	   </p>
    	   </fieldset>
    	   </form>
    	  <%
     }catch(Exception e){
    	 out.print(e.getMessage());
     }finally{
    	 conn.close();
     }
 %>
</body>
</html>
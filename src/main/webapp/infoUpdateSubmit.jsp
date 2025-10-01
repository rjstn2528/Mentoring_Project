<!-- 김진주 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="utils.*, java.sql.*, java.io.*, vo.MemberVO"%>
<%
    msg = "";
    String nextPage= "";

    String id = request.getParameter("id");
    String pw = request.getParameter("pw");   
    String name = request.getParameter("name");
    String addr = request.getParameter("addr");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String role = request.getParameter("role");
    String lang = request.getParameter("lang");  

    System.out.println("id : " + id);
    
    Connection conn = DBCPUtil.getConnection();
    PreparedStatement pstmt = null;
   	ResultSet rs = null;

    try{
        String sql = "UPDATE member_table SET pw = ?, name = ?, addr = ?, "; 
                   sql += "email =?, phone = ? , role = ?, lang = ? ";
                   sql += "WHERE id = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, pw);
        pstmt.setString(2, name);
        pstmt.setString(3, addr);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);
        pstmt.setString(6, role);
        pstmt.setString(7, lang);  
        pstmt.setString(8, id);     

        int result = pstmt.executeUpdate();

        if(result == 1){
            msg = "회원정보 수정 완료했습니다.";
            nextPage = "info.jsp"; 
        }else{
            msg = "회원정보 수정 실패했습니다.";
            nextPage = "infoUpdate.jsp";
        }

    }catch(Exception e){
        e.printStackTrace();
        msg = "회원정보 오류입니다.";
        nextPage = "infoUpdate.jsp";
    }finally{
        DBCPUtil.close(pstmt, conn);
    }
    
    try{
    	conn = DBCPUtil.getConnection();
    	pstmt = conn.prepareStatement(
    		"SELECT * FROM member_table WHERE id= ?"	
    	);
    	pstmt.setString(1, id);
    	rs = pstmt.executeQuery();
    	
    	if(rs.next()){
    		MemberVO m = new MemberVO(
    			rs.getInt(1),
    			rs.getString(2),
    			rs.getString(3),
    			rs.getString(4),
    			rs.getString(5),
    			rs.getString(6),
    			rs.getString(7),
    			rs.getString(8),
    			rs.getString(9)


    		);
    		session.setAttribute("login", m);
    	} // if rs.next()
    	
    }catch(Exception e){
    	e.printStackTrace();
    }finally{
    	DBCPUtil.close(rs, pstmt, conn);
    	session.setAttribute("msg", msg);
    }
%>

<script>
    location.replace('<%=nextPage%>');
</script>














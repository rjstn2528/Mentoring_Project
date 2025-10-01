<!-- 김진주 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, utils.*" %>    
<%@ page import="vo.MemberVO" %>

<%

	String id = request.getParameter("id"); 

	msg = "";

	String nextPage = "";
	

	Connection conn = DBCPUtil.getConnection();
	
	PreparedStatement pstmt = conn.prepareStatement(
		"SELECT * FROM member_table WHERE id = ?"		
	);

	ResultSet rs = null;
	
	try{
		
		pstmt.setString(1, id);

		
		rs = pstmt.executeQuery(); 
		
		if(rs.next()){
			msg = "이미 존재하는 아이디입니다.";
			nextPage = "join.jsp";
%>
			<script>
				alert('이미 존재하는 아이디입니다.');
				history.back(); 
			</script>
<%	
		}else{

			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String addr = request.getParameter("addr");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String role = request.getParameter("role");
			String lang = request.getParameter("lang");
 
			
			 String sql = "INSERT INTO member_table (id, pw, name, addr, email, phone, role, lang) " +
                     		"VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, addr);
			pstmt.setString(5, email);
			pstmt.setString(6, phone);
			pstmt.setString(7, role);
			pstmt.setString(8, lang);

			
			int result = pstmt.executeUpdate();
			
			if(result == 1){
				msg = "회원가입이 완료되었습니다. 로그인 후 이용해 주세요.";
				nextPage = "login.jsp";
			}else{
				msg = "회원가입이 정상적으로 처리되지 않았습니다.";
				nextPage = "join.jsp";
			}
			
		} // end if else
		
	}catch(Exception e){
	    msg = "회원가입 처리 실패 : " + e.getMessage();
	    nextPage = "join.jsp";
	    e.printStackTrace();  
	}finally{
	    DBCPUtil.close(rs, pstmt, conn);
	    session.setAttribute("msg", msg);
	}
	%>

	<script>
	    location.replace('<%=nextPage%>');
	</script>





























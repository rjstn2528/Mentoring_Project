<!-- 민서진 -->
<%@ include file="common/header.jsp"%>
<%@ include file="checkAdmin.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, utils.*" %>
<%

	String strNum = request.getParameter("num");

	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	String id = "";
	String pw = "";
	String name = "";
	String addr = "";
	String email = "";
	String phone = "";
	String role = "";
	String lang = "";
	
	try{
		
		String sql = "SELECT id, pw, name, addr, email,  phone, role, lang FROM member_table WHERE num = ?";
		// 파라미터로 받은 회원 번호 변환
		int num = Integer.parseInt(strNum);
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			
			id = rs.getString(1);
			pw = rs.getString(2);
			name = rs.getString(3);
			addr = rs.getString(4);
			email = rs.getString(5);
			phone = rs.getString(6);
			role = rs.getString(7);
			lang = rs.getString(8);
		}
	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBCPUtil.close(rs, pstmt, conn);
	}
	
%>

<section class="member-info">
<div class="member-container">
	<table>
		<tr>
			<th colspan="2" class="detail">
			<h3><%=role %> 회원 정보 상세보기</h3></th>
		</tr>
		<tr>
			<td>회원번호</td>
			<td><%=strNum %></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><%=id %></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><%=pw %></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=name %></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><%=addr %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=email %></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=phone %></td>
		</tr>
		<tr>
			<td>회원 구분</td>
			<td><%=role %></td>
		</tr>
		<% if (lang != null) { %>
		<tr>
			<td>프로그래밍 언어</td>
			<td><%=lang %></td>
		</tr>
		<%} %> 
		<tr>
			<th colspan="2">
				<a href="memberUpdateForm.jsp?num=<%=strNum%>" class="member-btn edit">수정</a> | <a href="javascript:memberDelete();" class="member-btn delete">삭제</a>
			</th>
		</tr>
	</table>
</div>
</section>
<script>
	function memberDelete(){
		let isChecked = confirm('<%=id %>님 회원 정보를 삭제하시겠습니까?');
		if(isChecked){
			location.href="memberDelete.jsp?num=<%=strNum %>";
		}
	}
</script>
<%@ include file="common/footer.jsp"%>
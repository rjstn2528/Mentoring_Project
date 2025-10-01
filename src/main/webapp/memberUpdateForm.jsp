<!-- 민서진 -->
<%@ include file="common/header.jsp"%>
<%@ include file="checkAdmin.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.*, vo.MemberVO" %>    
<%
	String strNum = request.getParameter("num");

	MemberVO m = null;
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM member_table WHERE num =?";
	
	try{
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(strNum));
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				m = new MemberVO();
				m.setNum(rs.getInt("num"));
				m.setId(rs.getString("id"));
				m.setPw(rs.getString("pw")); 
				m.setName(rs.getString("name"));
				m.setEmail(rs.getString("email"));
				m.setAddr(rs.getString("addr"));
				m.setPhone(rs.getString("phone"));
				m.setRole(rs.getString("role")); 
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBCPUtil.close(rs, pstmt, conn);
		}

%>    

<section class="member-update-form">
<script type="text/javascript" src="js/inputCheck.js"></script>
<form action="memberUpdate.jsp" method="POST">
<div class="member-edit-container">
	<table>
		<tr>
			<th colspan="2" class="update"><h3>회원정보 수정</h3></th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="id" data-msg="아이디" value="<%=m.getId()%>" readonly onclick="alert('id는 변경할 수 없습니다.');"/>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="text" name="pw" data-msg="비밀번호" value="<%=m.getPw()%>"/>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="name" data-msg="이름" value="<%=m.getName()%>"/>
			</td>
		</tr>
			<tr>
			<td>이메일</td>
			<td>
				<input type="text" name="email" data-msg="이메일" value="<%=m.getEmail()%>"/>
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>
				<input type="text" name="addr" data-msg="주소" value="<%=m.getAddr()%>"/>
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<input type="text" name="phone" data-msg="전화번호" value="<%=m.getPhone()%>"/>
			</td>
		</tr>
		<tr>
			<input type="hidden" name="num" value="<%=m.getNum()%>"/> 
		</tr>
	
			<tr>
			<th colspan="2" class="update-btn">
				<button class="updateBtn">수정 완료</button>
			</th>
		</tr>
	</table>
</div>
</form>
</section>

<%@ include file="common/footer.jsp"%>
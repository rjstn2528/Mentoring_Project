<!-- 김도은 / 멘토 프로필 수정 폼 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String intro = request.getParameter("intro");

	if(loginMember == null || intro == null){
		response.sendError(403);
		return;
	}

%>
    
<section id="main">

<form action="profileUpdate.jsp" method="POST">
	<br>
	<h5>-자기 소개 외 정보 수정은 회원 정보 수정을 이용해 주세요.-</h5>
	<table border="1" id="mentorP">
		<tr>
			<th colspan="4">프로필 수정</th>
		</tr>
		<tr>
			<th>이름</th>
			<td><%=loginMember.getName()%></td>
			<th>프로그래밍 언어</th>
			<td><%=loginMember.getLang()%></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><%=loginMember.getPhone()%></td>
			<th>이메일</th>
			<td><%=loginMember.getEmail()%></td>
		</tr>
		<tr>
			<td colspan="4" id="intro">
				<textarea rows="30" cols="66" name="intro"><%=intro%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="4" class="btn">
				<button type="submit">수정 완료</button>
			</td>
		</tr>
	</table>
</form>	

</section>

<%@ include file="common/footer.jsp" %>
<!-- 김도은 / 공지 사항 작성 폼 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="vo.*"%>
    
<%
	

	if(loginMember == null || loginMember != null && !loginMember.getId().equals("admin")){
		// 접근 제한
		response.sendError(403);
		return;
	}


%>
<section id="main">

<h3 class="nTitle">공지 사항 작성</h3>

<hr>

<form action="noticeWriteSubmit.jsp" method="post">
	<table border="1" id="updateN">
		<tr>
			<th>제목</th>
			<td class="title"> <input type="text" name="title" placeholder="제목을 작성하세요."/> </td>
		</tr>
		<tr>
			<td colspan="2"> <textarea rows="20" cols="66" name="content" placeholder="공지를 작성하세요."></textarea> </td>
		</tr>
		<tr>
			<td colspan="2">
				<button type="submit" />작성하기</button>
			</td>
		</tr>
	</table>
</form>
</section>
<%@ include file="common/footer.jsp"%>
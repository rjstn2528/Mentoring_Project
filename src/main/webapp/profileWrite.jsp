<!-- 김도은 / 멘토 프로필 등록 폼 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<section id="main">
<form action="profileWriteSubmit.jsp" method="POST">
	<table border="1" id="mentorP">
		<tr>
			<th colspan="2">프로필 등록</th>
		</tr>
		<tr>
			<td colspan="2" id="introM">
				<h4>- 자기 소개 작성 - </h4>
				<textarea rows="20" cols="66" name="intro" placeholder="멘티들에게 본인을 소개해 주세요."></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="btn">
				<button type="submit">작성 완료</button>
			</td>
		</tr>
	</table>
</form>
</section>

<%@ include file="common/footer.jsp" %>
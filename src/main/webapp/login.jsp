<!-- 김진주 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section id="main">
<form action="loginCheck.jsp" method="POST">
	<table border="1" class="login">
		<tr>
			<th colspan="2"><h1>로그인</h1></th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" id="box" name="id" placeholder="INSERT ID" data-msg="아이디" autofocus/>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" id="box" name="pw" placeholder="INSERT PASSWORD" data-msg="비밀번호"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<label>
				<input type="checkbox" name="login" value="login"/>
					로그인 상태 유지
				</label>
			</td>
		</tr>
		<tr>
			<th colspan="2">
			<button>로그인</button>
			<button type="button"><a href="findPw.jsp" style="text-decoration: none; color: black;">비밀번호 찾기</a></button>
			</th>
		</tr>
	</table>
</form>
</section>

<%@ include file="common/footer.jsp"%>

<!-- 김진주 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<section id="main">
<form action="joinCheck.jsp" method="POST">
	<table border="1" class="login">
		<tr>
			<th colspan="2"><h1>회원가입</h1></th>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" id="box" name="id" data-msg="아이디" placeholder=" ID " autofocus required/></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" id="box" name="pw" data-msg="비밀번호" placeholder=" PASSWORD " required/></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" id="box" name="name" data-msg="이름" placeholder=" NAME " required/></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" id="box" name="addr" data-msg="주소" placeholder=" ADDRESS " required/></td>
		</tr>
		<tr>
		    <td>이메일</td>
		    <td><input type="email" id="box" name="email" data-msg="이메일" placeholder=" EMAIL " required/></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" id="box" name="phone" data-msg="전화번호" placeholder=" PHONE " required/></td>
		</tr>
		<tr>
			<td>ROLE</td>
			<td id="role">
				<label><input type="radio" name="role" value="멘티" checked onclick="toggleLanguage(false)"/> 멘티</label>
				<label><input type="radio" name="role" value="멘토" onclick="toggleLanguage(true)"/> 멘토</label>
			</td>
		</tr>
		<tr id="languageRow" style="display:none;">
			<td>전문 언어</td>
			<td id="role">
				<select name="lang" style="width:200px; text-align:center; text-align-last:center;">
					<option value="">-- 선택하세요 --</option>
					<option value="JAVA">JAVA</option>
					<option value="C언어">C언어</option>
					<option value="Javascript">Javascript</option>
					<option value="Python">Python</option>
					<option value="ETC">기타</option>
				</select>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit">회원가입</button>
			</th>
		</tr>
	</table>
</form>
</section>

<script>
function toggleLanguage(show) {
    const row = document.getElementById("languageRow");
    if (show) {
        row.style.display = "";
    } else {
        row.style.display = "none";
        document.querySelector('select[name="lang"]').value = "";
    }
}
</script>
<%@ include file="common/footer.jsp"%>
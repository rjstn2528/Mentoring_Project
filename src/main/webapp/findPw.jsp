<!-- 김진주 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="js/inputCheck.js"></script>
<section id="main">
    <form action="findPwCheck.jsp" method="POST">

		
        <table class="login">
        	<tr>
			<th colspan="2"><h3>비밀번호 찾기</h3></th>
			</tr>
			<tr>
                <td>아이디</td>
                <td><input type="text" id="box" name="id" placeholder="ID" required autofocus></td>
            </tr>
            <tr>
                <td>이메일</td>
                <td><input type="email" id="box" name="email" placeholder="EMAIL" required></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><input type="text" id="box" name="phone" placeholder="PHONE" required></td>
            </tr>
            <tr>
            	<th colspan="2">
            	<button type="submit">비밀번호 찾기</button>
        		<button type="button" onclick="location.href='login.jsp'">취소</button>
            	</th>
            </tr>
            
        </table>
        
        
    </form>
</section>

<%@ include file="common/footer.jsp"%>

<!-- 김진주 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<section id="main">
	<form action="memberDelete2.jsp" method="post">
	<div class="form-guide">
    *회원 탈퇴를 위해 비밀번호를 입력해주세요.
	</div>
        <table class="login">
        	<tr>
        		<th colspan="2">비밀번호 입력창</th>
        	</tr>
        	<tr>
              <td>아이디</td>
                <td>
                    <input type="text" name="id" id="box"
                           value="<%=session.getAttribute("id")%>" readonly>
                </td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td>
                    <input type="password" name="pw" id="box" placeholder=" 비밀번호를 입력하세요. "required>
                </td>
            </tr>
            <tr>
            	<th colspan="2">
		           <button type="submit">회원 탈퇴</button>
		           <button type="button" onclick="location.href='index.jsp'">취소</button>
        		</th>
        	</tr>
        </table>
        <br>
        
    </form>
</section>

<%@ include file="common/footer.jsp"%>
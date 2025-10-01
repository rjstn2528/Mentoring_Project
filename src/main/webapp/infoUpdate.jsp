<!-- 김진주 -->
<%@ include file="common/header.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section id="main">
<form action="infoUpdateSubmit.jsp" method="POST">
    <table class="login">
        <tr>
            <th colspan="2"><h1>회원정보 수정</h1></th>
        </tr>
        <tr>
            <td>아이디</td>
            <td>
                <input type="text" id="box" name="id" data-msg="아이디" readonly value="<%= loginMember.getId()%>"/>
                
            </td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td>
                <input type="password" id="box" name="pw" data-msg="비밀번호" value="<%= loginMember.getPw()%>"/>
            </td>
        </tr>
        <tr>
            <td>이름</td>
            <td>
                <input type="text" id="box" name="name"  data-msg="이름" placeholder="Name" value="<%= loginMember.getName()%>"/>
            </td>
        </tr>
        <tr>
            <td>주소</td>
            <td>
                <input type="text" id="box" name="addr"  data-msg="주소" placeholder="Address" value="<%= loginMember.getAddr()%>"/>
            </td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>
                <input type="email" id="box" name="email"  data-msg="이메일" placeholder="email" value="<%= loginMember.getEmail()%>"/>
            </td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td>
                <input type="text" id="box" name="phone"  data-msg="전화번호" placeholder="Phone" value="<%= loginMember.getPhone()%>"/>
            </td>
        </tr>
        <tr>
            <td>역할(Role)</td>
            <td>
                <input type="text" id="box" name="role" data-msg="역할" readonly value="<%= loginMember.getRole()%>"/>
            </td>
        </tr>
        
        <%if("멘토".equals(loginMember.getRole()) && loginMember.getLang() != null) {%>
        <tr>	
            <td>주언어(Language)</td>
            <td class="lang">
                <select name="lang">
                    <option value="JAVA" <%= "JAVA".equals(loginMember.getLang()) ? "selected" : "" %>>JAVA</option>
                    <option value="C언어" <%= "C언어".equals(loginMember.getLang()) ? "selected" : "" %>>C언어</option>
                    <option value="Javascript" <%= "Javascript".equals(loginMember.getLang()) ? "selected" : "" %>>Javascript</option>
                    <option value="Python" <%= "Python".equals(loginMember.getLang()) ? "selected" : "" %>>Python</option>
                    <option value="ETC" <%= "ETC".equals(loginMember.getLang()) ? "selected" : "" %>>기타</option>
                </select>
            </td>
        </tr>
         <%} %>
        <tr>
            <th colspan="2">
                <button type="submit">회원정보 수정</button>
            </th>
        </tr>
    </table>
</form>
</section>

<%@ include file="common/footer.jsp"%>
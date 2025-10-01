<!-- 김진주 -->
<%@ include file="common/header.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	session.removeAttribute("login");


	Cookie cookie = new Cookie("rememberMe", "");
	cookie.setMaxAge(0);
	cookie.setPath("/");
	response.addCookie(cookie);
	session.setAttribute("msg", "로그아웃되었습니다.");
	
%>

<script>
	location.href='index.jsp'; 
</script>























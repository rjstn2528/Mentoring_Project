<!-- 민서진 -->
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	if(member == null || !member.getId().equals("admin")){
		response.sendError(403); 
		return; 
	} 
%>
    
    
    
    
    
    
    
<!-- 김도은 / 멘토 목록 -->
<%@ include file="common/header.jsp"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="utils.*, vo.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
	//페이징 ----------------------------------------------

	// 요청 페이지 번호 기본 값 1로 설정
	int pageNum = 1;	
	
	String strPage = request.getParameter("page");
	if(strPage != null){
		pageNum = Integer.parseInt(strPage);
	}
	
	// 한 페이지에 멘토 5명씩 출력
	int perPageNum = 5;
	
	Criteria cri = new Criteria(pageNum, perPageNum);
	int startRow = cri.getStartRow();
	
	
	// 페이징 ----------------------------------------------
	
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 멘토 프로필 목록을 저장할 리스트
	List<MentorProfileVO> list = new ArrayList<>();
	// 멘토 프로필 저장용
	MentorProfileVO profile = null;
	
	String sql = "SELECT * FROM mentor_profile ORDER BY num DESC";
		   sql+= " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
	
    try {
		  pstmt = conn.prepareStatement(sql);
		  pstmt.setInt(1, cri.getStartRow());
		  pstmt.setInt(2, cri.getPerPageNum());
		  
		  rs = pstmt.executeQuery();
		  
		  while(rs.next()){
			  // 멘토 프로필 목록에 저장된 프로필이 있는 경우
			  profile = new MentorProfileVO();
			  
			  profile.setNum(rs.getInt(1));
			  profile.setMentorId(rs.getString(2));
			  profile.setName(rs.getString(3));
			  profile.setLang(rs.getString(4));
			  profile.setEmail(rs.getString(5));
			  profile.setIntro(rs.getString(6));
			  profile.setCreatedAt(rs.getDate(7));
			  
			  list.add(profile);
		  }
    }catch(Exception e){
    	e.printStackTrace();
		response.sendError(500);
		return;
    }finally{
    	DBCPUtil.close(rs, pstmt, conn);
    }
    
 // 페이징 ----------------------------------------------
	
 	PageMaker pm = null;
 	int totalCount = 0;
 	
 	try{
 		conn = DBCPUtil.getConnection();
 		sql = "SELECT count(*) FROM mentor_profile";
 		pstmt = conn.prepareStatement(sql);
 		rs = pstmt.executeQuery();
 		
 		if(rs.next()){
 			totalCount = rs.getInt(1); // 멘토 프로필 테이블에 등록된 프로필 수
 		}
 		
 		// 한 페이지에 멘토 5명씩, 페이지 번호 10개씩 출력
 		pm = new PageMaker(cri, totalCount, 10);
 		
 	}catch(Exception e){
 		e.printStackTrace();
 		response.sendError(500);
 		return;
 	}finally{
 		DBCPUtil.close(rs, pstmt, conn);
 	}

 // 페이징 ---------------------------------------------- 
   
    // 멘토별 멘토링 평점 가져오기
    
    List<RatingVO> rList = new ArrayList<>();
    RatingVO score = null;
    
    conn = DBCPUtil.getConnection();
    
    sql = "SELECT mentor_id, ROUND(AVG(score), 2) AS avg_score FROM rating GROUP BY mentor_id";
	
    try {
		  pstmt = conn.prepareStatement(sql);
		  
		  rs = pstmt.executeQuery();
		  
		  while(rs.next()){
			  // 멘토 프로필 목록에 저장된 프로필이 있는 경우
			  score = new RatingVO();
			  
			  score.setId(rs.getString(1));
			  score.setScore(rs.getDouble(2));
			  
			  // rList에 아이디와 평점 저장
			  rList.add(score);
		  }
  }catch(Exception e){
  	e.printStackTrace();
		response.sendError(500);
		return;
  }finally{
  	DBCPUtil.close(rs, pstmt, conn);
  }

  for(MentorProfileVO vo : list){
	  for(RatingVO r : rList){
		  if(vo.getMentorId().equals(r.getId())){
			  vo.setScore(r.getScore());
		  }
	  }
  }
    
%>

<section id="main">

<p id="title">멘토 찾기</p>
<hr>
<% if(!list.isEmpty()) { %>
<!-- 목록에 저장된 멘토 프로필이 있을 때 -->
	<% for(MentorProfileVO p : list){ %>
	<form action="boardList.jsp">
	<input type="hidden" name="mentorId" value="<%=p.getMentorId()%>">
	<table border="1" class="profile">
		<tr>
			<th colspan="2">
				<span><%=p.getName()%></span> 멘토
			</th>
		</tr>
		<tr>
			<td>주력 언어 : <%=p.getLang()%></td>
			<td>평점 :  <%=p.getScore() %>
			<%-- 			<% if(!rList.isEmpty()) {
				for(RatingVO r : rList) {
					if(p.getMentorId().equals(r.getId())){ %>
						<!-- 프로필 아이디와 평점 아이디가 같으면 평점 출력-->
						<%= r.getScore()%>
					<% }else{ %>
						<!-- 일치하는 평점이 없으면 0.0 -->
						0.0
					<% } %>
				<% } // end for %>
			 <% }else { // end null check %>
			 	<!-- 평점이 하나도 없는 상태여서 리스트가 null이면 0.0 -->
			 	0.0
			 <% } %> --%>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button type="submit">멘토링 받기</button>
			</td>
		</tr>
	</table>
	</form>
	<% } %>
	
	<!-- 페이지 번호 출력 -->
	<div id="pageBlock">
		<% if(pm.isFirst()){ %>
			<a href="?page=1">[처음]</a>
		<% } %>
		
		<% if(pm.isPrev()){ %>
			<a href="?page=<%=pm.getStartPage()-1%>">[이전]</a>
			 ... 
		<% } %>
		
		<% for(int i = pm.getStartPage(); i <= pm.getEndPage(); i++){ 
			String selected = (pageNum == i) ? "selected" : "";
		%>
			<a href="?page=<%=i%>" class="<%=selected%>">[<%=i%>]</a>								
		<% } %>
		
		<% if(pm.isNext()){ %>
			 ... 
			<a href="?page=<%=pm.getEndPage()+1%>">[다음]</a>
		<% } %>
		
		<% if(pm.isLast()){ %>
			<a href="?page=<%=pm.getMaxPage()%>">[마지막]</a>
		<% } %>
	</div>
<%} %>
</section>
<%@ include file="common/footer.jsp"%>


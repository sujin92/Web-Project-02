<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Boardlist" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.comment" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.23">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>ChanggiFood-BoardView</title>
<%
	ArrayList<comment> alc = (ArrayList<comment>)request.getAttribute("commentlist");
	int alcsize = 0;
	System.out.println(alc.size());
	if (alc != null) {
		alcsize = alc.size();
	}
	Boardlist bl = (Boardlist)request.getAttribute("viewInfo");
	String userid = (String)session.getAttribute("userid");
	String writer = bl.getWriter();
 	int cupage = Integer.valueOf(request.getParameter("page"));
 	int id = Integer.valueOf(request.getParameter("id"));
 	int next = -1;
 	if (request.getAttribute("nextpage") != null) {
 		next = Integer.valueOf((String)request.getAttribute("nextpage")); 
 	}
 	int previous = -1;
 	if (request.getAttribute("previouspage") != null) {
 		previous = Integer.valueOf((String)request.getAttribute("previouspage")); 
 	}
 	int totalpage = (Integer)request.getAttribute("totalpage");
 	String category = request.getParameter("category");
 	String sub_title = "";
	if (category.equals("notice")) {
		category = "공지사항";
	}
	else if (category.equals("bulletin")) {
		category = "게시판";
	}
	if (category.equals("공지사항")) {
		sub_title = "NOTICE";
	}
	else if (category.equals("게시판")) {
		sub_title = "BULLETIN";
	}
	else if (category.equals("1:1 문의")) {
		sub_title = "고객센터";
	}
%>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="bo_view">
        <div class="container">
            <h5><small><%=sub_title %></small></h5>
            <h3><%=category %></h3>
            <hr>
            <h3><%=bl.getTitle() %></h3>
            <hr>
            <div>
                <div class="row">
                    <p><i class="fa-solid fa-pen"></i>&nbsp;<%=bl.getWriter() %></p>
                    <p><i class="fa-solid fa-eye"></i>&nbsp; <%=bl.getHit() %></p>
                </div>
                <div>
                    <p><%=bl.getDate() %></p>
                </div>
            </div>
            <div class="row d-flex justify-content-center mb-5">
            <%	if (!category.equals("1:1 문의")){
	            	for (int i = 0; i < bl.getImg().length; i++){
	            		if (!(bl.getImg()[i].equals("")) && bl.getImg()[i] != null){
            %>
            	<img alt="" src="../resources/images/<%=bl.getImg()[i]%>" class="mx-1" style="width: 19%">
            <%
	            		}
	            	}
	            }
			%>
			</div>
            <p style="white-space: normal;"><%=bl.getContent() %></p>
            <hr>
            <p><i class="fa-solid fa-comment"></i>&nbsp; <%=alcsize %></p>
           
            <%
            	if (userid != null){
            %>
            <form class="row d-flex justify-content-between mb-5 form-group" method="post" action="comment.bo?category=<%=category%>&id=<%=id%>&page=<%=cupage%>">
            	<input type="text" class="col-10 form-control" name="comment">
            	<input type="submit" class="btn btn-success px-5 col-2" style="max-width: 15%;" value="댓글 달기">
           	</form>
            <%
            	}
            	else{
            %>
            <div id="comment">
                <p>로그인한 회원만 댓글 등록이 가능합니다.</p>
            </div>
            <%
            	}
            %>
             <div class="col-12 mb-5">
            <%
            	if (alc != null) {
            		for (int i = 0; i < alc.size(); i++){
            			comment cm = alc.get(i);
            %>
            	<div class="row col-12 mb-2" style="border-bottom: 1px solid rgba(0,0,0,.1);">
            		<p class="col-12"><%=cm.getBc_content() %></p>
            		<p class="col-6" style="font-size: 0.9rem; color:rgba(0,0,0,.5);">작성자 : <%=cm.getBc_writer() %></p>
            		<p class="col-6 text-right" style="font-size: 0.9rem; color:rgba(0,0,0,.5);">작성일 : <%=cm.getBc_date() %></p>
            	</div>
            <%
            		}
            	}
            %>
            </div>
            <div>
            	<%
            		//이전페이지
            		if (previous == -1) {
            	%>
                <!-- <a class="btn btn-secondary col-2" onclick="noprevious()">이전글</a> -->
                <%
            		}
            		else{
            			if (category.equals("공지사항")){
                %>
                <a href="notice_view.bo?id=<%=previous%>&page=<%=cupage%>&category=<%=category %>" class="btn btn-secondary col-2">이전글</a>
                <%
            			}
            			else if (category.equals("게시판")){
            	%>
            	<a href="bulletin_view.bo?id=<%=previous%>&page=<%=cupage%>&category=<%=category %>" class="btn btn-secondary col-2">이전글</a>
            	<%
            			}
            			else if (category.equals("1:1 문의")){
            				
            	%>
            	<a href="one_view.bo?id=<%=previous%>&page=<%=cupage%>&category=<%=category %>" class="btn btn-secondary col-2">이전글</a>
            	<%
            			}
            			else {
        		%>
   				<a href="review_view.bo?id=<%=previous%>&page=<%=cupage%>&category=<%=category %>" class="btn btn-secondary col-2">이전글</a>
        		<%
            			}
            		
            		}
            		// 다음페이지
            		if (next == -1) {
            	%>
                <!-- <a class="btn btn-secondary col-2" onclick="nonext()">다음글</a> -->
                <%
            		}
            		else{
            			if (category.equals("공지사항")){
                %>
                <a href="notice_view.bo?id=<%=next%>&page=<%=cupage%>&category=<%=category %>" class="btn btn-secondary col-2">다음글</a>
                <%
            			}
            			else if (category.equals("게시판")){
            	%>
            	<a href="bulletin_view.bo?id=<%=next%>&page=<%=cupage%>&category=<%=category %>" class="btn btn-secondary col-2">다음글</a>
            	<%
            			}
            			else if (category.equals("1:1 문의")){
            				
            	%>
            	<a href="one_view.bo?id=<%=next%>&page=<%=cupage%>&category=<%=category %>" class="btn btn-secondary col-2">다음글</a>
            	<%
            			}
            			else {
        		%>
   				<a href="review_view.bo?id=<%=next%>&page=<%=cupage%>&category=<%=category %>" class="btn btn-secondary col-2">다음글</a>
        		<%
            			}
            		
            		}
            		if(category.equals("공지사항")){
                %>
                <a href="./notice.bo?page=<%=cupage %>&category=<%=category %>" class="btn btn-success col-2">목록</a>
                <%
            		}
            		else if (category.equals("게시판")){
                %>
                <a href="./bulletin.bo?page=<%=cupage %>&category=<%=category %>" class="btn btn-success col-2">목록</a>
                <%
            		}
            		else if (category.equals("1:1 문의")){
                %>
                <a href="./one_qna.bo?page=<%=cupage %>&category=<%=category %>" class="btn btn-success col-2">목록</a>
                <%
            		}
            		else {
                %>
                <a href="./review.bo?page=<%=cupage %>&category=<%=category %>" class="btn btn-success col-2">목록</a>
                <%
            		}
            		if (userid != null && userid.equals(writer)){
                %>
                <input type="button" onclick="delnoview()" class="btn btn-danger col-2" value="삭제">
                <%
            		}
                %>
                
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
<script type="text/javascript">
	function delnoview() {
		if (confirm("게시물을 삭제하시겠습니까?")){
			location.href="delnoview.bo?id=<%=bl.getId()%>&page=<%=cupage %>&category=<%=category %>";
		}
	}
	/*
	function nonext() {
		alert("현재 페이지가 마지막 페이지 입니다.");
	}
	function noprevious() {
		alert("현재 페이지가 가장 최신 페이지 입니다.");
	}*/
</script>
</html>
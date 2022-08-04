<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.oneqna" %>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.1">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<%
	ArrayList<oneqna> onelist = (ArrayList<oneqna>)request.getAttribute("oneqnalist");
	int cupage = 1;
	if (request.getParameter("page") != null) {
		cupage = Integer.valueOf(request.getParameter("page"));
	}
	int min = (cupage-1)*10;
	int max = cupage*10;
	int totalpage = 0;
	if (request.getAttribute("totalpage") != null){
		totalpage = (Integer)request.getAttribute("totalpage");
	}
	if (max > totalpage) {
		max = totalpage;
	}
	if (cupage == 1) {
%>
	<style type="text/css">
		body > .qna > div:nth-of-type(2) > div >  div:nth-of-type(2) > div:nth-of-type(3) >  p > a.pagenum:nth-of-type(<%=cupage%>){
    		color: red;
		}
	</style>
<%
	}
	else {
%>
	<style type="text/css">
		body > .qna > div:nth-of-type(2) > div >  div:nth-of-type(2) > div:nth-of-type(3) > p > a.pagenum:nth-of-type(<%=cupage+1%>){
    		color: red;
		}
	</style>
<%
	}
%>
<title>ChanggiFood-1:1 질문</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="qna">
        <div>
            <img src="../resources/images/main01.jpg" alt="">
        </div>
        <div class="container">
            <div class="row">
                <div class="col-3">
                    <div>
                        <img src="../resources/images/logo_green.png" alt="" style="width: 35%;">
                    </div>
                    <ul>
                        <a href="./faq.bo?page=1"><li>자주하는 질문 <span>&gt;</span></li></a>
                        <a href="./one_qna.bo?page=1"><li>1:1 문의<span>&gt;</span></li></a>
                    </ul>
                </div>
                <div class="col-9">
                    <div>
                        <h3>1:1 문의</h3>
                        <p><i class="fa-solid fa-house"></i>&nbsp;HOME > 커뮤니티 > 고객센터 > 1:1 문의</p>
                    </div>
                    <table class="table text-center">
                        <tr>
                            <th class="col-2">문의 날짜</th>
                            <th class="col-2">카테고리</th>
                            <th class="col-4">제목</th>
                            <th class="col-2">작성자</th>
                            <th class="col-2">문의상태</th>
                        </tr>
                        <%
                        	if(onelist != null){
	                        	for(int i = 0; i < onelist.size(); i++) {
	                        		oneqna one = onelist.get(i);
                        %>
                        <tr>
                            <td><%=one.getDate() %></td>
                            <td><%=one.getCategory() %></td>
                            <td><a href="one_view.bo?category=1:1 문의&id=<%=one.getId()%>&page=<%=cupage%>"><%= one.getTitle() %></a></td>
                            <td><%=one.getWriter() %></td>
                            <td><%= one.getStat() %></td>
                        </tr>
                        <%
                        		}
                        	}
                        %>
                    </table>
                    <div>
                        <a href="./board_write.jsp?category=1:1 문의" class="btn btn-secondary col-3" >글쓰기</a>
                    </div>
                    <div class="col-12">
		                <%
			            		if (cupage == 1){
		            	%>
		                <p><b>&lt;</b>
		                <%
		            			}
		            			else {
		           		%>
		   		                 <p><a href="one_qna.bo?page=<%=cupage-1%>"><b>&lt;</b></a>
		           		
		           		<%
		            			}
		                		int pagenum = ((totalpage-1)/10)+1;
		                		for (int a = 0; a < pagenum; a++) {
		                %>
		                 	<a href="one_qna.bo?page=<%=a+1%>" class="pagenum"><%=a+1%></a>
		               	<%
			                	}
			                	if (pagenum == cupage) { 
		               	%>
		               		<b>&gt;</b></p>
		               	<%
			                	}
			                	else {
		               	%>
		                <a href="one_qna.bo?page=<%=cupage+1%>" class="pagenum"><b>&gt;</b></a></p>
		                <%
		                		}
						%>
	            	</div>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
</html>
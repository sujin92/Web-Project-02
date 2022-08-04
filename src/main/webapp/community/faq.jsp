<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Boardlist" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.3">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>ChanggiFood-자주하는 질문</title>
</head>
<%
	String search_title = request.getParameter("search_title");
	ArrayList<Boardlist> al = (ArrayList<Boardlist>)request.getAttribute("faqlist");
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
		body > .faq > div:nth-of-type(2)  > div > div:nth-of-type(2) > div:nth-last-of-type(1) > p > a.pagenum:nth-of-type(<%=cupage%>){
			color: red;
		}
	</style>
<%
	}
	else {
%>
	<style type="text/css">
		body > .faq > div:nth-of-type(2) >  div > div:nth-of-type(2) > div:nth-last-of-type(1) > p > a.pagenum:nth-of-type(<%=cupage+1%>){
			color: red;
		}
	</style>
<%
	}
%>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="faq">
        <div>
            <img src="../resources/images/main02.jpg" alt="">
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
		                <h3>자주하는 질문</h3>
		                <p><i class="fa-solid fa-house"></i>&nbsp;HOME > 커뮤니티 > 고객센터 > 자주하는 질문</p>
		            </div>
		            <%
		            	for(int i = 0; i < al.size(); i++) {
		            		Boardlist bl = al.get(i);
		            %>
                    <div>
                        <label for="faq<%=i %>" class="col-12">
                            <div>
                                <p><i class="fa-solid fa-q"></i>&nbsp;<%=bl.getTitle() %></p>
                                <i class="fa-solid fa-angle-down"></i>
                            </div>
                        </label>
                        <input type="checkbox" id="faq<%=i %>">
                        <div class="col-12">
                            <p><i class="fa-solid fa-a"></i>&nbsp;<%=bl.getContent() %>.</p>
                        </div>
                    </div>
                    <%
		            	}
                    %>
                    <div>
                        <form action="faq.bo" method="post" class="col-5">
                            <input type="text" placeholder="검색어를 입력해주세요." class="form-control" id="search_title" name="search_title">
                            <a onclick="submit()"><i class="fa-solid fa-magnifying-glass"></i></a>
                        </form>
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
		   		                 <p><a href="faq.bo?page=<%=cupage-1%>&search_title=<%=search_title%>"><b>&lt;</b></a>
		           		
		           		<%
		            			}
		                		int pagenum = (totalpage/10)+1;
		                		for (int a = 0; a < pagenum; a++) {
		                %>
		                 	<a href="faq.bo?page=<%=a+1%>&search_title=<%=search_title%>" class="pagenum"><%=a+1%></a>
		               	<%
			                	}
			                	if (pagenum == cupage) { 
		               	%>
		               		<b>&gt;</b></p>
		               	<%
			                	}
			                	else {
		               	%>
		                <a href="faq.bo?page=<%=cupage+1%>&search_title=<%=search_title%>" class="pagenum"><b>&gt;</b></a></p>
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
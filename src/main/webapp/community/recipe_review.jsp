<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Boardlist" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=2.0">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=UTF-8");
	String likechk = request.getParameter("likechk");
	if(likechk != null && likechk.equals("1")){
%>
<script type="text/javascript">
	alert("이미 like를 주신 상품입니다.");
	document.location.href="#p_move";
</script>
<%
	}
	else if (likechk != null && likechk.equals("-1")){		
%>
	<script type="text/javascript">
		alert("like를 하기 위해서 로그인이 필요합니다.");
		location.href="http://localhost:8080/tmp_project/login/login.jsp";
	</script>
<%
	}
	else if(likechk != null && likechk.equals("2")){
%>
	<script type="text/javascript">
		alert("판매자 아이디로는 like를 주실수 없습니다.");
	</script>
<%	
	}
	else if (likechk != null && likechk.equals("3")) {
%>
	<script type="text/javascript">
		alert("선택하신 레시피에 like가 +1 되었습니다.");
	</script>
<%
	}
	String search_title = request.getParameter("search_title");
	ArrayList<Boardlist> al = (ArrayList<Boardlist>)request.getAttribute("review_list");
	int cupage = 1;
	if (request.getParameter("page") != null) {
		cupage = Integer.valueOf(request.getParameter("page"));
	}
	int min = (cupage-1)*20;
	int max = cupage*20;
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
		body > .re_review > div:nth-of-type(2) > div:nth-last-of-type(1) > p > a.pagenum:nth-of-type(<%=cupage%>){
    		color: red;
		}
	</style>
<%
	}
	else {
%>
	<style type="text/css">
		body > .re_review > div:nth-of-type(2) > div:nth-last-of-type(1) > p > a.pagenum:nth-of-type(<%=cupage+1%>){
    		color: red;
		}
	</style>
<%
	}
%>
<title>ChanggiFood-나만의 레시피</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="re_review">
        <div>
            <img src="../resources/images/main02.jpg" alt="">
        </div>
        <div class="container">
            <h5><small>MAKE IT</small></h5>
            <h3>Recipe</h3>
            <div class="row">
                <div class="col-6">
                    <h4>컬리에서 구매한 신선한 재료로 만든 나만의 레시피를 공유해보세요.</h4>
                    <h5>레시피를 자랑하고 사은품도 받아가세요!</h5>
                </div>
                <div class="col-6">
                    <img src="../resources/images/main01.jpg" alt="">
                </div>
            </div>
            <div>
	            <form action="review.bo?page=<%=cupage%>" method="post" name="searchForm" class="col-4">
	                <input type="text" class="form-control col-12" placeholder="검색어를 입력해주세요." name="search_title">
	                <i class="fa-solid fa-magnifying-glass"></i>
                </form>
            </div>
            <div class="row">
            <%
            	for(int i = min; i < max; i++) {
            		Boardlist bl = al.get(i);
            %>
                <div class="col-3" id="p_move">
                    <div>
                        <a href="review_view.bo?id=<%=bl.getId()%>&page=<%=cupage%>&category=나만의 레시피"><img src="../resources/images/<%=bl.getImg()[0] %>" alt="" class="col-12"></a>
                        <div>
                            <a href="review_like.bo?id=<%=bl.getId()%>&page=<%=cupage%>"><i class="fa-solid fa-heart"></i><span> LIKE <%=bl.getLike() %></span></a>
                        </div>
                    </div>
                    <a href="review_view.bo?id=<%=bl.getId()%>&page=<%=cupage%>&category=나만의 레시피">
                        <h5><%= bl.getTitle() %></h5>
                        <p>작성자 : <%=bl.getWriter() %></p>
                    </a>
                </div>
            <%
            	}
            %>
            </div>
            <div>
                <a href="./board_write.jsp?category=나만의 레시피" class="btn btn-secondary col-2">글쓰기</a>
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
   		                 <p><a href="review.bo?page=<%=cupage-1%>&search_title=<%=search_title%>"><b>&lt;</b></a>
           		
           		<%
            			}
                		int pagenum = ((totalpage-1)/20)+1;
                		for (int a = 0; a < pagenum; a++) {
                %>
                 	<a href="review.bo?page=<%=a+1%>&search_title=<%=search_title%>" class="pagenum"><%=a+1%></a>
               	<%
	                	}
	                	if (pagenum == cupage) { 
               	%>
               		<b>&gt;</b></p>
               	<%
	                	}
	                	else {
               	%>
                <a href="review.bo?page=<%=cupage+1%>&search_title=<%=search_title%>" class="pagenum"><b>&gt;</b></a></p>
                <%
                		}
				%>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
</html>
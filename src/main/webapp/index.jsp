<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.recipelist" %>  
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/tmp_project/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/tmp_project/resources/css/style.css?ver=1.4">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>ChanggiFood-Home</title>
</head>
<%
	if (request.getParameter("error") != null){
		String error = request.getParameter("error");
		if (error.equals("1")) {
%>
<script type="text/javascript">
	alert("정상적으로 탈퇴되었습니다.");
</script>
<%
		}
	}
	ArrayList<recipelist> recom = (ArrayList<recipelist>)request.getAttribute("recomm");
	if (recom != null){
%>
<body>
    <jsp:include page="menu.jsp"/>
    <section class="main">
        <div>
            <div>
                <input type="radio" name="slide" id="slide1" checked>
                <input type="radio" name="slide" id="slide2">
                <input type="radio" name="slide" id="slide3">
                <div>
                    <div>
                        <h3>모두와 공유하고 싶은 나만의  레시피</h3>
                        <p>나만의 노하우를 통해 레시피를 모두와 공유하고 함께 즐길 수 있는 ChanggiFood의 공간</p>
                        <a href="<c:url value='/recipe/recipes.re?r_category=밥·죽&page=1'/>" class="btn btn-primary">Recipe</a>
                    </div>
                    <div>
                        <label class="left" for="slide3"><i class="fa-solid fa-angle-left"></i></label>
                        <label class="right" for="slide2"><i class="fa-solid fa-angle-right"></i></label>
                    </div>
                </div>
                <div>
                    <div>
                        <h3>모두와 공유하고 싶은 나의 레시피 팁</h3>
                        <p>경험한 레시피를 더 발전시켜 한층 더 뛰어난 맛과 멋을 나눌 수 있는 홈 쉐프들의 공간</p>
                        <a href="<c:url value='/community/review.bo?page=1'/>" class="btn btn-primary">나만의 레시피</a>
                    </div>
                    <div>
                        <label class="left" for="slide1"><i class="fa-solid fa-angle-left"></i></label>
                        <label class="right" for="slide3"><i class="fa-solid fa-angle-right"></i></label>
                    </div>
                </div>
                <div>
                    <div>
                        <h3>고객에게 항상 열려있는 ChanggiFood</h3>
                        <p>고객과 소통의 중요성을 알고 항상 경청하는 태도로 고객과 함께 나아가고<br>
                        더 나은 서비스를 제공하기 위한 ChangiFood의 고객센터</p>
                        <a href="<c:url value='/community/faq.bo?page=1'/>" class="btn btn-primary">자주하는 질문</a>
                    </div>
                    <div>
                        <label class="left" for="slide2"><i class="fa-solid fa-angle-left"></i></label>
                        <label class="right" for="slide1"><i class="fa-solid fa-angle-right"></i></label>
                    </div>
                </div>
            </div>
        </div>
    </section>
        <section class="main2">
        <div class="container">
            <h2>Recommended Recipe</h2>
            <div>
                <input type="radio" name="slide2" id="sl1" checked>
                <div>
                    <label for="sl3" class="left"><i class="fa-solid fa-angle-left"></i></label>
                    <label for="sl2" class="right"><i class="fa-solid fa-angle-right"></i></label>
                </div>
                <input type="radio" name="slide2" id="sl2">
                <div>
                    <label for="sl1" class="left"><i class="fa-solid fa-angle-left"></i></label>
                    <label for="sl3" class="right"><i class="fa-solid fa-angle-right"></i></label>
                </div>
                <input type="radio" name="slide2" id="sl3">
                <div>
                    <label for="sl2" class="left"><i class="fa-solid fa-angle-left"></i></label>
                    <label for="sl1" class="right"><i class="fa-solid fa-angle-right"></i></label>
                </div>
                <%
                	for (int i = 0; i < recom.size(); i++) {
                		recipelist rl = recom.get(i);
                %>
                <div class="col-4 t">
                    <div>
                        <a href="recipe/recipe.re?id=<%=rl.getR_id()%>"><img src="resources/images/<%=rl.getR_img() %>" alt=""></a>
                    </div>
                    <div>
                        <div>
                        </div>
                    </div>
                    <a class="col-12" href="recipe/recipe.re?id=<%=rl.getR_id()%>">
	                    <div class="col-12">
	                        <h4><%=rl.getR_name() %></h4>
	                        <p><%=rl.getR_desc() %></p>
	                    </div>
                    </a>
                </div>
                <%
                	}
                %>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
<%
	}
	else {
		response.sendRedirect("recom.re");
	}
%>

</html>
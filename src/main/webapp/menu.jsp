<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.customer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<body>
     <nav>
        <div>
            <div class="container">
                <div>
                    <a href="<c:url value='/index.jsp'/>"><img src="<c:url value='/resources/images/logo.png'/>" width="20%"></a>
                    <% 
                    	if (session.getAttribute("user") == null && session.getAttribute("seller") == null) {
                    %>
                    <ul>
                        <a href="<c:url value='/login/login.jsp'/>"><li>로그인</li></a>
                        <a href="<c:url value='/login/sel_login.jsp'/>"><li>회원가입</li></a>
                    </ul>
                    <%
                    	}
                    	else if (session.getAttribute("user") != null){
                    %>                  
                    <ul>
                        <a href="<c:url value='/login/logout.lo'/>"><li>로그아웃</li></a>
                        <a href="<c:url value='/login/mypage.ca?page=1&orderperiod=1year'/>"><li>마이페이지</li></a>
                        <a href="<c:url value='/cart/cart.jsp'/>"><li>장바구니</li></a>
                    </ul>
                    <%
                    	}
                    	else if (session.getAttribute("seller") != null ){
                    %>
                    <ul>
                    	<a href="<c:url value='/login/logout.lo'/>"><li>로그아웃</li></a>
                        <a href="<c:url value='/login/store_management.lo?order=waiting&page=1'/>"><li>점포관리</li></a>
                        <a href="<c:url value='/login/productmanage.sel?page=1'/>"><li>상품등록</li></a>
                    </ul>
                    <%
                    	}
                    %>
                </div>
            </div>
        </div>
        <div>
            <div class="container">
                <div class="t1">
                    <label for="sitemap">≡ 전체메뉴</label>
                    <ul>
                        <a href="<c:url value='/about/aboutUs.jsp'/>"><li>회사소개</li></a>
                        <li>레시피
                            <ul>
                                <a href="<c:url value='/recipe/recipes.re?r_category=밥·죽&page=1'/>"><li>밥/죽</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=국·탕·찌개·전골&page=1'/>"><li>국/탕/찌개/전골</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=면&page=1'/>"><li>면</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=찜·조림&page=1'/>"><li>찜/조림</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=구이&page=1'/>"><li>구이</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=튀김&page=1'/>"><li>튀김</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=나물&page=1'/>"><li>나물</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=기타&page=1'/>"><li>기타</li></a>
                            </ul>
                        </li>
                        <li>커뮤니티
                            <ul>
                                <a href="<c:url value='/community/notice.bo?page=1'/>"><li>공지사항</li></a>
                                <a href="<c:url value='/community/bulletin.bo?page=1'/>"><li>게시판</li></a>
                                <a href="<c:url value='/community/review.bo?page=1'/>"><li>나만의 레시피</li></a>
                                <a href="<c:url value='/community/faq.bo?page=1'/>"><li>고객센터</li></a>
                            </ul>
                        </li>
                    </ul>
                    <input type="checkbox" id="sitemap">
                    <ul>
                        <a class="col-2" href="<c:url value='/about/aboutUs.jsp'/>"><li>회사소개</li></a>
                       	<li><span class="col-2">레시피</span>                        	
                            <ul>
                                <a href="<c:url value='/recipe/recipes.re?r_category=밥·죽&page=1'/>"><li>밥/죽</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=국·탕·찌개·전골&page=1'/>"><li>국/탕/찌개/전골</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=면&page=1'/>"><li>면</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=찜·조림&page=1'/>"><li>찜/조림</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=구이&page=1'/>"><li>구이</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=튀김&page=1'/>"><li>튀김</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=나물&page=1'/>"><li>나물</li></a>
                                <a href="<c:url value='/recipe/recipes.re?r_category=기타&page=1'/>"><li>기타</li></a>
                            </ul>                            
                       	</li>
                        <li><span class="col-2">커뮤니티</span>
                            <ul>
                                <a href="<c:url value='/community/notice.bo?page=1'/>"><li>공지사항</li></a>
                                <a href="<c:url value='/community/bulletin.bo?page=1'/>"><li>게시판</li></a>
                                <a href="<c:url value='/community/review.bo?page=1'/>"><li>나만의 레시피</li></a>
                                <a href="<c:url value='/community/faq.bo?page=1'/>"><li>자주하는 질문</li></a>
                                <a href="<c:url value='/community/one_qna.bo?page=1'/>"><li>1:1 문의</li></a>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</body>
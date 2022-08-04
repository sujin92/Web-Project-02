<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.customer" %>
<%@ page import="dto.cartlist" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.4">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>ChanggiFood-MyPage</title>
</head>
<% 
	ArrayList<cartlist> mycart = (ArrayList<cartlist>)session.getAttribute("myCart");
	int cartcnt = 0;
	if (mycart != null) {
		cartcnt = mycart.size();
	}
	String name = "";
	int point = 0;
	String c_class = "";
	float dis = 0;
	if (session.getAttribute("user") != null){
		customer cu = (customer)session.getAttribute("user");
		name = cu.getName();
		point = cu.getPoint();
		c_class = cu.getC_class();
	}
	if (c_class.equals("BRONZE")) {
		dis = 1.0f;
	}
	else if (c_class.equals("SILVER")) {
		dis = 3.0f;
	}
	else if (c_class.equals("GOLD")) {
		dis = 5.0f;
	}
	ArrayList<cartlist> al = (ArrayList<cartlist>)request.getAttribute("mypage"); 
	String error = request.getParameter("error");
	if (error != null && error.equals("1")) {
%>
<script type="text/javascript">
	alert("비밀번호가 일치하지 않습니다.");
</script>
<%
	}
	else if (error != null && error.equals("2")){
%>
<script type="text/javascript">
	alert("회원님의 정보가 정상적으로 수정되었습니다.");
</script>
<%
	}
%>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="modi_mypagechk">
          <div>
               <div class="container">
                    <h3>마이페이지</h3>
                    <div>
                         <div>
                              <i class="fa-solid fa-user"></i>
                              <p>안녕하세요. <%=name %>님</p>
                              <p><%=c_class %> 등급 | <%=dis%>%적립</p>
                         </div>
                         <div>
                              <h5>적립금 &gt;</h5>
                              <h5 class="hh"><%=point %>원</h5>
                              <p>소멸 예정 : 0원</p>
                         </div>
                         <div>
                              <h5>쿠폰 &gt;</h5>
                              <h5 class="hh">0개</h5>
                         </div>
                         <div>
                              <a href="<c:url value='/cart/cart.jsp'/>"><h5>장바구니 &gt;</h5></a>
                              <h5 class="hh"><%=cartcnt %>개</h5>
                         </div>
                    </div>
               </div>
          </div>
          <div class="container">
               <div class="row">
                    <div class="col-3">
                         <div>
                              <img src="../resources/images/logo_green.png" width="35%">
                         </div>
                         <ul>
                              <a href="mypage.ca?page=1&orderperiod=1year"><li>주문 내역 <span>&gt;</span></li></a>
                              <a href="<c:url value='/community/one_qna.bo?page=1'/>"><li>상품 문의<span>&gt;</span></li></a>
                              <a href="<c:url value='/login/modimypagechk.jsp'/>"><li>개인정보 수정<span>&gt;</span></li></a>
                         </ul>
                    </div>
                    <div class="col-9">
                         <form action="pwchk.lo?user=customer" method="post">
                              <div class="d-flex justify-content-center align-items-center" style="height: 30vh;">
                                   <label class="col-3 mb-0">비밀번호 입력</label>
                                   <input type="password" class="col-5 form-control" name="pw">
                                   <input type="submit" value="입력" class="btn btn-success ml-2 col-2">
                              </div>
                         </form>
                    </div>
               </div>
          </div>
     </section>
     <jsp:include page="/footer.jsp"/>     
</body>
</html>
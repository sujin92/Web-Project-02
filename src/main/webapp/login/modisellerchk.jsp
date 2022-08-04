<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.orderlist" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<%	
	String order = request.getParameter("order");
	ArrayList<orderlist> alo = (ArrayList<orderlist>)request.getAttribute("orderlist");
	String name = "";
	
	if (session.getAttribute("seller") != null) {
		name = (String)session.getAttribute("seller");
	}	String error = request.getParameter("error");
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
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.3">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>ChanggiFood-Seller Management</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="s_manage_modi">
        <div>
            <div class="container">
            	<h3>점포 관리</h3>
            </div>
            <div class="container">
                <i class="fa-solid fa-user"></i>
                <h5>안녕하세요. <%=name %> 님</h5>
            </div>
        </div>
        <div class="container">
        	<div class="row">
            	<div class="col-3">
                	<div>
                    	<img src="../resources/images/logo_green.png" width="35%">
                    </div>
                    <ul>
                        <a href="<c:url value='/login/store_management.lo?order=waiting&page=1'/>"><li>주문 내역<span>&gt;</span></li></a>
                        <a href="<c:url value='/login/modisellerchk.jsp'/>"><li>점포 정보 수정<span>&gt;</span></li></a>
                    </ul>
                </div>
                <div class="col-9">
                    <form action="selpwchk.lo" method="post">
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
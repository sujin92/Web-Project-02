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
	int cupage = 1;
	int totalpage = 1;
	if (request.getParameter("page") != null && !request.getParameter("page").equals("null")){
		cupage = Integer.valueOf(request.getParameter("page"));
	}
	if (request.getAttribute("totalpage") != null && !request.getAttribute("totalpage").equals("null")) {
		totalpage = Integer.valueOf((String)request.getAttribute("totalpage"));
	}
	//페이지 넘버
	int min = 1;
	int max = 5;
	if (cupage > 3) {
		min = cupage - 2;
		max = cupage + 2;
	}
	if (max > (totalpage/10)+1) {
		max = (totalpage/10)+1;
	}
	
	//출력 갯수
	int max_size = alo.size();
	int min_size = (cupage-1) * 10;
	if (max_size > cupage * 10) {
		max_size = cupage * 10;
	}
	
	
	if (session.getAttribute("seller") != null) {
		name = (String)session.getAttribute("seller");
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
	<section class="s_manage">
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
                        <a href="<c:url value='/login/store_management.lo?order=waiting'/>"><li>주문 내역<span>&gt;</span></li></a>
                        <a href="<c:url value='/login/modisellerchk.jsp'/>"><li>점포 정보 수정<span>&gt;</span></li></a>
                    </ul>
                </div>
                <form name="orderForm" action="ordersub.lo" method="post" class="col-9">
                    <div>
	                    <div>
	                        <h5>주문 내역</h5>
	                        <input type="button" value="전체선택"  class="btn btn-danger" onclick="allchk()">
                        </div>
                        
                        <%
                        	if (order.equals("waiting")){
                        %>
                        <select name="" class="form-control col-3" onchange="compleorder()">
                        	<option selected>접수 대기</option>
                        	<option>접속 완료</option>
                       	</select>
                       	<%
                        	}
                        	else {
                       	%>
                       	<select name="" class="form-control col-3" onchange="waitorder()">
                       		<option >접수 대기</option>
                        	<option selected>접수 완료</option>
                       	</select>
                       	<%
                        	}
                       	%>
                    </div>
                    <table class="table">
                        <tr>
                            <th></th>
                            <th>주문번호</th>
                            <th>상품명</th>
                            <th>수량</th>
                            <th>배송지</th>
                            <th>접수상태</th>
                        </tr>
                        <%
                          	if(alo != null){
                          		for(int i = min_size; i < max_size; i++) {
                          			orderlist ol = alo.get(i);
                          			String[] f_name = ol.getF_singname().split(",");
                          			String[] f_unit = ol.getF_singunit().split(",");
                        %>
                        <tr>
                        	<%
                        		if(ol.getChk() == 1){
                        	%>
                            <td class="align-middle"><input type="checkbox" disabled name="orderchk"></td>
                            <%
                          		}
                        		else{ 
                            %>
                            <td class="align-middle"><input type="checkbox" checked name="orderchk" class="allchkbtn"></td>
                            <%
                        		}
                            %>
                            <td class="align-middle"><%=ol.getId() %></td>
                            <input type="hidden" value="<%=ol.getId() %>" name="orderid">
                            <td class="align-middle">
                            	<ul class="m-0">
                            		<%
                            			for(int j = 0; j < f_name.length; j++) {
                            		%>
                             			<li><%=f_name[j] %></li>
                            		<%
                            			}
                            		%>
                            	</ul>
                            </td>
                            <td class="align-middle">
                            	<ul class="m-0">
                            		<%
                            			for(int x = 0; x < f_unit.length; x++) {
                            		%>
                             			<li><%=f_unit[x] %> 개</li>
                            		<%
                            			}
                            		%>
                            	</ul>
                            </td>
                            <td class="align-middle"><%=ol.getAddr() %></td>
                            <%
                            	if (ol.getChk() == 0) {
                            %>
                            <td class="align-middle">접수 대기</td>
                            <%
                            	}
                            	else if (ol.getChk() == 1){
                            %>
                            <td class="align-middle">접수 완료</td>
                            <%
                            	}
                            %>
                            <input type="hidden" value="<%=ol.getChk()%>">
                        </tr>
                        <%
                        		}
                          	}
                        %>
                    </table>
                    <div>
                        <input type="button" class="btn btn-secondary col-3" value="주문접수" onclick="orderchkbtn()">
                    </div>
                    <div class="d-flex justify-content-center mt-5">
                    	<%
                    		if (cupage == min) { 
                    	%>
                    		<a class="mx-1" style="font-weight: bold;">&lt;</a>
	                    <%
                    		}
                    		else {
                    			
                    	%>
                    		<a href="store_management.lo?order=<%=order%>&page=<%=cupage-1%>" class="mx-1" style="font-weight: bold;">&lt;</a>
                    	<%
                    		}
	                    //페이징 시작해야함.
	                    	for (int i = min; i <= max; i++) {
	                    		if (i == cupage){
	                    %>
	                    	<a href="store_management.lo?order=<%=order%>&page=<%=i%>" style="color: red;font-weight: bold;" class="mx-1"><%=i%></a>
	                   	<%
		                   		}
		                   		else {
	                   	%>
	                    	<a href="store_management.lo?order=<%=order%>&page=<%=i%>" class="mx-1"><%=i%></a>
	                    <%
	                    		}
	                    	}
	                    	if (cupage == max){
	                    %>
	                    	<a class="mx-1" style="font-weight: bold;">&gt;</a>
                    	<%
                    		}
	                    	else {
                    	%>
                    		<a href="store_management.lo?order=<%=order%>&page=<%=cupage+1%>" class="mx-1" style="font-weight: bold;">&gt;</a>
                    	<%
	                    	}
                    	%>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
    <script type="text/javascript">
    	function allchk() {
    		var chkbtn = document.getElementsByClassName('allchkbtn');
    		for (let i = 0; i < chkbtn.length; i++) {
    			chkbtn[i].checked = true;
    		}
    	}
    	function orderchkbtn() {
    		if (confirm("선택하신 상품의 주문접수를 하시겠습니까?")) {
    			document.orderForm.submit();
    		}
    	}	
    
    	function waitorder() {
    		location.href="store_management.lo?order=waiting";
    	}
    	function compleorder() {
    		location.href="store_management.lo?order=complete";
    	}
    </script>
</body>
</html>
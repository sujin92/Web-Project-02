<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.customer" %>
<%@ page import="dto.cartlist" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%	
	String order_p = request.getParameter("orderperiod");
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
	
	int cupage = Integer.parseInt(request.getParameter("page"));
	int cnt = 0;
	if (request.getAttribute("cnt") != null) {
		String s_cnt = (String)request.getAttribute("cnt");
		cnt = Integer.parseInt(s_cnt);
	}
	int min = (cupage-1) * 10;
	int max = 0;
	if (cupage * 10 > cnt){
		max = cnt;
	}
	else {
		max = cupage * 10;
	}
	if (cupage == 1) {
%>
	<style type="text/css">
		body > .mypage > div:nth-of-type(2) > div > div:nth-last-of-type(1) > p > a.pagenum:nth-of-type(<%=cupage%>){
    		color: red;
		}
	</style>
<%
	}
	else {
%>
	<style type="text/css">
		body > .mypage > div:nth-of-type(2) > div > div:nth-last-of-type(1) > p > a.pagenum:nth-of-type(<%=cupage+1%>){
    		color: red;
		}
	</style>
<%
	}
%>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.4">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>ChanggiFood-Mypage</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
    <section class="mypage">
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
                    <div>
                        <h5>주문내역 <small>지난 1년 간의 주문 내역 조회가 가능합니다.</small></h5>
                        <%
                        	if (order_p.equals("1year")) {
                        %>
                        <select name="order_period" id="order_period" class="col-3 form-control" onchange="orderperi()">
                            <option value="1year" selected>1년</option>
                            <option value="1month">1개월</option>
                            <option value="3month">3개월</option>
                            <option value="6month">6개월</option>
                        </select>
                        <%
                        	}
                        	else if (order_p.equals("1month")){
                        %>
                        <select name="order_period" id="order_period" class="col-3 form-control" onchange="orderperi()">
                            <option value="1year">1년</option>
                            <option value="1month" selected>1개월</option>
                            <option value="3month">3개월</option>
                            <option value="6month">6개월</option>
                        </select>
                        <%
                        	}
                        	else if (order_p.equals("3month")){
                        %>
                        <select name="order_period" id="order_period" class="col-3 form-control" onchange="orderperi()">
                            <option value="1year">1년</option>
                            <option value="1month">1개월</option>
                            <option value="3month" selected>3개월</option>
                            <option value="6month">6개월</option>
                        </select>
                        <%
                        	}
                        	else if (order_p.equals("6month")){
                        %>
                        <select name="order_period" id="order_period" class="col-3 form-control" onchange="orderperi()">
                            <option value="1year">1년</option>
                            <option value="1month">1개월</option>
                            <option value="3month">3개월</option>
                            <option value="6month" selected>6개월</option>
                        </select>
                        <%
                        	}
                        %>
                    </div>
                    <hr>
                    <div>
                        <table class="table">
                            <tr>
                                <th class="col-2"></th>
                                <th class="col-2">상품명</th>
                                <th class="col-4" colspan="3">상세선택</th>
                                <th class="col-2">합계</th>
                                <th class="col-2">주문일</th>
                            </tr>
                            <%
                            	for (int i = min; i < max; i++) {
                            		cartlist ca = al.get(i);
                            		int sum = 0;
                            %>
                            <tr>
                            	<td><img src="../resources/images/<%=ca.getFilename() %>" alt=""></td>
                                <td><%= ca.getFoodName() %></td>
                                <td>
                                    <ul>
                                    <%
                                    	for (int j = 0; j < ca.getFoods().length; j++) {
                                    		String[] foods = ca.getFoods();
                                    %>
                                        <li><%= foods[j] %></li>
                                    <%
                                    	}
                                    %>
                                    </ul>
                                </td>
                                <td>
                                	<ul>
                                	<%
                                		for (int x = 0; x < ca.getFoodprice().length; x++){
                                			String[] foodprice = ca.getFoodprice();
                                	%>
                                    
                                        <li><%=foodprice[x] %> 원</li>
                                    <%
                                		}
                                    %>
                                    </ul>
                                </td>
                                <td>
                                    <ul>
                                    <%
                                    	for (int y = 0; y < ca.getFoodunit().length; y++) {
                                    		String[] foodunit = ca.getFoodunit();
                                    		String[] foodprice = ca.getFoodprice();
                                    		sum += Integer.valueOf(foodunit[y]) * Integer.valueOf(foodprice[y]);
                                    %>
                                        <li><%=foodunit[y] %> 개</li>
                                    <%
                            			}
                                    %>
                                    </ul>
                                </td>
                                <td><%= sum %> 원</td>
                                <td><%=ca.getDate() %><br><br>주문번호 : <%=ca.getNum() %></td>
                            </tr>
                            <%
                            	}
                            %>
                        </table>
                    </div>
                    <hr>
                    <div>
                        <a href="<c:url value='/community/one_qna.bo?page=1'/>" class="btn btn-secondary">1:1 문의하기</a>
                    </div>
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
   		                 <p><a href="mypage.ca?page=<%=cupage-1%>&orderperiod=<%=order_p%>"><b>&lt;</b></a>
           		
           		<%
            			}
                	int pagenum = (cnt/10)+1;
                	if (cnt %10 == 0 && cnt != 0) {
                		pagenum = cnt/10;
                	}
                	for (int a = 0; a < pagenum; a++) {
                %>
                 	<a href="mypage.ca?page=<%=a+1%>&orderperiod=<%=order_p%>" class="pagenum"><%=a+1%></a>
               	<%
                	}
                	if (pagenum == cupage) { 
               	%>
               		<b>&gt;</b></p>
               	<%
                	}
                	else {
               	%>
                <a href="mypage.ca?page=<%=cupage+1%>&orderperiod=<%=order_p%>" class="pagenum"><b>&gt;</b></a></p>
                <%
                	}
                %>
            	</div>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
    <script type="text/javascript">
    	function orderperi() {
    		let order = document.getElementById('order_period');
    		let ordervalue = order.options[order.selectedIndex].value;
    		location.href="mypage.ca?orderperiod="+ordervalue+"&page=1";
    	}
    </script>
</body>
</html>
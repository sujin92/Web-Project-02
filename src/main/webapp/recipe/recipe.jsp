<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.recipelist" %>
<%@ page import="dto.foodprice" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<%
	String userid = (String)session.getAttribute("userid");
	String id = request.getParameter("id");
	request.setCharacterEncoding("utf-8");
	recipelist rp = (recipelist)request.getAttribute("sel_recipe");
	String writer = rp.getR_writer();
	ArrayList<foodprice> fp = (ArrayList<foodprice>)request.getAttribute("foodprice");
	String addchk = request.getParameter("add");
	if (addchk != null) {
%>
	<script type="text/javascript">
		alert("카트에 상품이 추가되었습니다.");
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
<title>ChanggiFood-Recipe</title>

</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="recipe">
        <div class="container">
            <p><i class="fa-solid fa-house"></i>&nbsp;HOME > 레시피 > <%= rp.getR_category()%></p>
            <hr>
            <div class="row">
                <div class="col-6">
                    <img src="../resources/images/<%=rp.getR_img() %>" alt="" class="col-12">
                </div>
                <div class="col-6">
                <div class="row d-flex justify-content-between" style="padding-right:15px;">
                    <h3 class="col-6"><%=rp.getR_name() %></h3>
                        <%
			            	if(userid != null && userid.equals(writer)) { 
			            %>
			            	<input type="button" onclick="recipedel()" value="레시피 삭제" class="btn btn-danger col-3">
			            <%
			            	}
			            %>
                </div>
                    
                    <hr>
                    <h5><%=rp.getR_desc() %></h5>
                    <hr>
                    <div class="row">
                        <h5 class="col-4">배송비</h5>
                        <p class="col-8">3,000원 / 3만원 이상 구매 시 무료배송</p>
                    </div>
                    <form action="" method="post" name="cartForm" id="cartForm">
                        <table class="table">
                            <tr>
                                <th class="col-1"></th>
                                <th class="col-5">상품명</th>
                                <th class="col-2">갯수</th>
                                <th class="col-4 text-right">상품가격</th>
                            </tr>
                            <%
                            	String[] foods = rp.getR_product().split(",");
                            	String[] foodunit = rp.getR_unit().split(",");
                            	int sum_price = 0;
                            	int foodlen = foods.length;
                            	for (int i = 0; i < foods.length; i++) {
                                	int fo_price = 0;                                	
                            		for (int j = 0; j < fp.size(); j++) {
                            			foodprice f_price = fp.get(j);
                            			if (foods[i].equals(f_price.getF_name())){
                            				fo_price = f_price.getF_price();
                            				sum_price += fo_price*Integer.parseInt(foodunit[i]);
                            				break;
                            			}
                            		}
                            %>
                            <tr class="form-group">
                            	<input type="hidden" value=<%=rp.getR_id() %> name="foodid">
                                <td><input type="checkbox" id="p_chk<%=i %>" onclick="p_chked<%=i %>()" checked></td>
                                <td class="align-middle"><%=foods[i] %></td>
                                <input type="hidden" name="foods<%=i %>" value="<%=foods[i] %>">
                                <td><input type="number" name="foodnum<%=i %>" value="<%=foodunit[i]%>" min="0" class="form-control" onchange="p_change<%=i%>()" id="food_num<%=i%>"></td>
                                <td class="align-middle text-right" id="priceview<%=i%>"><%=fo_price*Integer.valueOf(foodunit[i]) %>원</td>
                                <input type="hidden" name="foodprice<%=i %>" value="<%=fo_price%>" id="pricechk<%=i%>">
                                <input type="hidden" value="<%=fo_price*Integer.valueOf(foodunit[i]) %>" id="pricevalue<%=i%>">
                            </tr>
                            <script type="text/javascript">
                            	function p_chked<%=i%>() {
                            		if (document.getElementById("p_chk<%=i%>").checked == true) {
                            			document.getElementById("food_num<%=i%>").value = <%=foodunit[i]%>;
                            			document.getElementById("food_num<%=i%>").disabled = false;
                            			var foodnum<%=i%> = document.getElementById("food_num<%=i%>").value;
    									var pricechk<%=i%> = document.getElementById("pricechk<%=i%>").value;
    									document.getElementById("pricevalue<%=i%>").value = foodnum<%=i%>*pricechk<%=i%>;
    									document.getElementById("priceview<%=i%>").innerHTML = (foodnum<%=i%>*pricechk<%=i%>) + "원";
    									var sum = Number(0);
    									var s_price = Number(0);
                                		for (var j = 0; j < <%=foodlen%>; j++) {
                                			var sum_name = "pricevalue"+j;
                                			s_price = document.getElementById(sum_name).value;                           			
                                			sum = Number(sum) + Number(s_price);
                                		}
                                		document.getElementById('sum_price').innerHTML = sum + "원";
                            		}
                            		else if (document.getElementById("p_chk<%=i%>").checked == false) {
                            			document.getElementById("food_num<%=i%>").value = 0;
                            			document.getElementById("food_num<%=i%>").disabled = true;
                            			var foodnum<%=i%> = document.getElementById("food_num<%=i%>").value;
    									var pricechk<%=i%> = document.getElementById("pricechk<%=i%>").value;
    									document.getElementById("pricevalue<%=i%>").value = foodnum<%=i%>*pricechk<%=i%>;
    									document.getElementById("priceview<%=i%>").innerHTML = (foodnum<%=i%>*pricechk<%=i%>) + "원";
    									var sum = Number(0);
    									var s_price = Number(0);
                                		for (var j = 0; j < <%=foodlen%>; j++) {
                                			var sum_name = "pricevalue"+j;
                                			s_price = document.getElementById(sum_name).value;                           			
                                			sum = Number(sum) + Number(s_price);
                                		}
                                		document.getElementById('sum_price').innerHTML = sum + "원";
                            		} 
                            	}
								function p_change<%=i%>() {
									var foodnum<%=i%> = document.getElementById("food_num<%=i%>").value;
									var pricechk<%=i%> = document.getElementById("pricechk<%=i%>").value;
									document.getElementById("pricevalue<%=i%>").value = foodnum<%=i%>*pricechk<%=i%>;
									document.getElementById("priceview<%=i%>").innerHTML = (foodnum<%=i%>*pricechk<%=i%>) + "원";
									var sum = Number(0);
									var s_price = Number(0);
                            		for (var j = 0; j < <%=foodlen%>; j++) {
                            			var sum_name = "pricevalue"+j;
                            			s_price = document.getElementById(sum_name).value;                           			
                            			sum = Number(sum) + Number(s_price);
                            		}
                            		document.getElementById('sum_price').innerHTML = sum + "원";
								}
								function recipedel() {
									if (confirm("레시피를 삭제하시겠습니까?")){
										location.href="delrecipe.re?id=<%=rp.getR_id()%>";
									}
								}
							</script>
                            <%
                            	}
                            %>
                            <tr class="ans">
                                <th colspan="2" class="text-center">총 합계 금액</th>
                                <th colspan="2" class="text-right" id="sum_price"><%=sum_price %>원</th>
                            </tr>
                        </table>
                        <div class="form-group row">
                        <%
                        	if(session.getAttribute("user") != null){
                        %>
	                        <script type="text/javascript">
	                        	function addCart() {
	                        		document.getElementById('cartForm').action = "addCart.ca?name=<%=rp.getR_name() %>&len=<%=foodlen%>&file=<%=rp.getR_img() %>&id=<%=id%>";
	                        		document.cartForm.submit();
	                        	}
	                        	function goCart() {
	                        		document.getElementById('cartForm').action = "goCart.ca?name=<%=rp.getR_name() %>&len=<%=foodlen%>&file=<%=rp.getR_img() %>";
	                        		document.cartForm.submit();
	                        	}
                        	</script>
                     	<%
                     		}
                     		else if (session.getAttribute("seller") != null) {
                       	%>
                       		<script type="text/javascript">
                        	function addCart() {
                        		alert("판매자 아이디로 구매를 하실 수 없습니다.");                        		
                        	}
                        	function goCart() {
                        		alert("판매자 아이디로 구매를 하실 수 없습니다.");
                        	}
                       	 	</script>
                       	<%
                        	}
                        	else{
                       	 %>
                       	 	<script type="text/javascript">
                        	function addCart() {
                        		alert("로그인을 하신 후 이용해주세요.");
                        		document.getElementById('cartForm').action = "../login/login.jsp";
                        		document.cartForm.submit();
                        	}
                        	function goCart() {
                        		alert("로그인을 하신 후 이용해주세요.");
                        		document.getElementById('cartForm').action = "../login/login.jsp";
                        		document.cartForm.submit();
                        	}
                       	 	</script>
                       	 <%
                        	}
                       	 %>
                            <button class="btn btn-secondary col-5" onclick="addCart()">장바구니 담기</button>
                            <button class="btn btn-success col-5" onclick="goCart()">바로 구매하기</button>
                        </div>
                    </form>
                </div>
            </div>
            <hr>
            <div>
                <h5>레시피 Tip</h5>
                <div>
                    <p><%=rp.getR_tip() %></p>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>    
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="dto.foodmanage" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.7">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="utf-8">
<script type="text/javascript">
	function food_search(){
		document.searchfoodForm.submit();
	}
	
	
	function food_code_search() {
		var popupwidth = 800;
		var popupheight = 500;
		var popx = (window.screen.width / 2) - (popupwidth / 2);
		var popy = (window.screen.height / 2) - (popupheight / 2);
		window.open("foodsearch.sel?search="+document.getElementById('foodserach').value ,"selectPop","status=no, width="+popupwidth+", height="+popupheight+",left="+popx+",top="+popy);
	}
	
	
	document.addEventListener('keydown', function(event) {
		if (event.keyCode === 13) {
			event.preventDefault();
		};
	}, true);
</script>
<title>ChanggiFood-상품관리</title>
<%
	String addchk = request.getParameter("addchk");
	ArrayList<foodmanage> alf = (ArrayList<foodmanage>)request.getAttribute("foodmanage");
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
		body > .a_product > div > div:nth-last-of-type(1) >  p > a.pagenum:nth-of-type(<%=cupage%>){
    		color: red;
		}
	</style>
<%
	}
	else {
%>
	<style type="text/css">
		body > .a_product > div > div:nth-last-of-type(1)  > p > a.pagenum:nth-of-type(<%=cupage+1%>){
    		color: red;
		}
	</style>
<%
	}
	if (addchk != null && addchk.equals("1")){
%>
	<script type="text/javascript">
		alert("이미 존재하는 상품입니다.");
	</script>
<%
	}
%>
<script type="text/javascript">
	function addfoodbtn(){
		var foodcate = document.getElementById('foodcate');
		var name = document.getElementById('name');
		var price = document.getElementById('price');
		var unit = document.getElementById('unit');
		
		if(foodcate.length == 0 || foodcate.value=="") {
			alert("상품코드를 검색해주세요");
			return false;
		}
		if(name.length == 0 || name.value == "") {
			alert("상품명을 입력해주세요.");
			return false;
		}
		if (price.length == 0 || price.value == ""){
			alert("가격을 입력해주세요.");
			return false;
		}
		else if (isNaN(price.value)) {
			alert("가격은 숫자만 입력해주세요");
			return false;
		}
		if (unit.length == 0 || unit.value == ""){
			alert("수량을 입력해주세요.");
			return false;
		}
		else if (isNaN(unit.value)) {
			alert("수량은 숫자만 입력해주세요.");
			return false;
		}
		
		document.addfoodForm.submit();
		
	}
</script>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="a_product">
                <div class="container">
            <div class="row">
                <h3>상품 관리</h3>
                <p><i class="fa-solid fa-house"></i>&nbsp;HOME > 상품관리</p>
            </div>
            <div>
                <form action="productmanage.sel" method="post" class="col-4" name="searchfoodForm">
                    <input type="text" placeholder="찾으실 상품을 입력해주세요" class="form-control" name="search_food" id="search_food">
                    <a onclick="food_search()"><i class="fa-solid fa-magnifying-glass"></i></a>
                </form>
            </div>
            <form action="addfood.sel?page=<%=cupage %>" method="post" name="addfoodForm">
                <table class="table text-center">
                    <tr>
                        <th class="col-1 align-bottom">품번</th>
                        <th class="col-3 foodsearch">
                            <div class="row">
                                <input type="text" placeholder="상품코드 검색" class="form-control col-12 my-2" id="foodserach" name="foodserach">
                                <a onclick="food_code_search()"><i class="fa-solid fa-magnifying-glass"></i></a>
                                <input type="text" placeholder="상품코드" readonly class="form-control col-12" name="foodcate" id="foodcate">
                            </div>
                        </th>
                        <th class="col-3 align-bottom">
                            <div class="row">
                                <input type="text" name="name" id="name" class="col-10 ml-3 form-control" placeholder="상품명 입력">
                            </div>
                        </th>
                        <th class="col-2 align-bottom">
                            <div class="row">
                                <input type="text" name="price" id="price" class="col-10 ml-1 form-control" placeholder="가격 입력">
                            </div>
                        </th>
                        <th class="col-2 align-bottom">
                            <div class="row">
                                <input type="text" name="unit" id="unit" class="col-10 form-control" placeholder="수량 입력">
                            </div>
                        </th>
                        <th class="col-1 align-bottom">
                            <input type="button" name="addfood" id="addfood" value="추가" class="btn btn-success" onclick="addfoodbtn()">
                        </th>
                    </tr>
                    <%
                    	for (int i = min; i < max; i++) {
                    		foodmanage fm = alf.get(i);
                    %>
	                    <tr>
	                        <td><%=i+1%></td>
	                        <td><%=fm.getF_code() %></td>
	                        <td><%=fm.getF_name() %></td>
	                        <td><%=fm.getF_price() %>원</td>
	                        <td><%=fm.getF_unit() %>pcs</td>
	                        <td>
	                            <input type="button" value="삭제" class="btn btn-danger" onclick="fooddelete<%=i%>()">
	                            <input type="hidden" name="fooddel<%=i %>" id="fooddel<%=i %>" value="<%=fm.getF_id()%>">
	                        </td>
	                    </tr>
	                    <script type="text/javascript">
							function fooddelete<%=i%>() {
								document.addfoodForm.action = "delfood.sel?num=<%=i%>";
								document.addfoodForm.submit();
							}
						</script>
                    <%
                    	}
                    %>
                </table>
            </form>
            <div class="col-12">
                <%
	            		if (cupage == 1){
            	%>
                <p><b>&lt;</b>
                <%
            			}
            			else {
           		%>
   		                 <p><a href="productmanage.sel?page=<%=cupage-1%>"><b>&lt;</b></a>
           		
           		<%
            			}
                		int pagenum = ((totalpage-1)/10)+1;
                		for (int a = 0; a < pagenum; a++) {
                %>
                 	<a href="productmanage.sel?page=<%=a+1%>" class="pagenum"><%=a+1%></a>
               	<%
	                	}
	                	if (pagenum == cupage) { 
               	%>
               		<b>&gt;</b></p>
               	<%
	                	}
	                	else {
               	%>
                <a href="productmanage.sel?page=<%=cupage+1%>" class="pagenum"><b>&gt;</b></a></p>
                <%
                		}
				%>
           	</div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
</html>
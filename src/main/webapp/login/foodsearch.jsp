<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.barcodesearch" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>ChanggiFood-상품코드 선택</title>
</head>
<%
	ArrayList<barcodesearch> alb = (ArrayList<barcodesearch>)request.getAttribute("barcodesearch");
	if (alb == null) {
%>
 	<script type="text/javascript">
 		alert("일치하는 상품이 없습니다.");
 		window.close();
 	</script>
<%
	}
%>

<body>
	<section class="codesel">
		<div class="container">
			<table class="table table-hover">
				<tr>
					<th class="col-3">대분류</th>
					<th class="col-3">중분류</th>
					<th class="col-3">소분류</th>
					<th class="col-3"></th>
				</tr>
				<%
					if(alb != null){
						for (int i = 0; i < alb.size(); i++) {
							
							barcodesearch bs = alb.get(i);
							String main = bs.getFb_main();
							String middle = bs.getFb_middle();
							String sub = bs.getFb_sub();
							String code = main.substring(0,2) + middle.substring(0,2) + sub.substring(0,2);
				%>
					<tr>
						<td><%= main %></td>
						<td><%= middle %></td>
						<td><%= sub %></td>
						<td>
							<input type="hidden" value="<%=code%>" id="bar<%=i%>" name="bar<%=i%>" >
							<input type="button" value="선택" onclick="fb_sel<%=i%>()" class="btn btn-success">
						</td>
					</tr>
					<script type="text/javascript">
						function fb_sel<%=i%>() {
							opener.document.getElementById('foodcate').value= document.getElementById('bar<%=i%>').value;
							window.close();
						}
					</script>
				<%
						}
					}
				%>
			</table>			
		</div>
	</section>
</body>

</html>
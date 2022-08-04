<%@page import="dto.foodmanage"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>ChanggiFood-재료 검색</title>
<%
	ArrayList<foodmanage> alf = (ArrayList<foodmanage>)request.getAttribute("foodlist");
%>
</head>
<body>
	<section class="fsel">
		<div class="container">
		<table class="table col-12">
			<tr>
				<th class="col-3">상품코드</th>
				<th class="col-3">상품명</th>
				<th class="col-3">가격</th>
				<th class="col-3"></th>
			</tr>
			<%
				if (alf != null) {
					for (int i = 0; i < alf.size(); i++) {
						foodmanage fm = alf.get(i);
			%>
			<tr>
				<td>
					<%= fm.getF_code() %>
					<input type="hidden" value="<%= fm.getF_code() %>" id="code<%=i%>" name="code<%=i%>">
				</td>
				<td>
					<%= fm.getF_name() %>
					<input type="hidden" value="<%= fm.getF_name() %>" id="name<%=i%>" name="name<%=i%>">
				</td>
				<td>
					<%= fm.getF_price() %>
					<input type="hidden" value="<%= fm.getF_price() %>" id="price<%=i%>" name="price<%=i%>">
				</td>
				<td>
					<input type="button" value="선택" onclick="sel_create<%=i %>()" class="btn btn-success">
				</td>
			</tr>
			<script type="text/javascript">
				function sel_create<%=i%>(){
					const setname = opener.document.getElementsByClassName('f_name_in');
					for (let i = 1; i < setname.length; i++) {
						if (setname[i].value == document.getElementById('name<%=i%>').value) {
							alert("이미 선택하신 상품입니다.");
							return false;
						}
					}
					var tr = opener.document.createElement('tr');
					tr.innerHTML = opener.document.getElementById('pre_set').innerHTML;
					opener.document.getElementById('field').appendChild(tr);
					var f_name = opener.document.getElementsByClassName('f_name');
					
					var f_price = opener.document.getElementsByClassName('f_price');
					opener.document.getElementsByClassName('f_name')[f_name.length - 1].innerHTML = document.getElementById('name<%=i%>').value;
					opener.document.getElementsByClassName('f_price')[f_price.length - 1].innerHTML = document.getElementById('price<%=i%>').value + "원";
					var f_name_value = document.getElementById('name<%=i%>').value;
					var f_price_value =  document.getElementById('price<%=i%>').value;
					var num = opener.document.getElementById('inputcnt');
					var c_value = num.value;
					c_value = Number(c_value)+Number(1);
					opener.document.getElementById('inputcnt').value = c_value;
					
					var f_name_in = opener.document.getElementsByClassName('f_name_in');
					var f_price_in = opener.document.getElementsByClassName('f_price_in');
					var f_unit = opener.document.getElementsByClassName('f_unit');
					var f_unit_in = opener.document.getElementsByClassName('f_unit_in');
					opener.document.getElementsByClassName('f_price')[f_price.length - 1].id = "ft_price_ina"+c_value;
					opener.document.getElementsByClassName('f_name_in')[f_name_in.length - 1].value = f_name_value;
					opener.document.getElementsByClassName('f_name_in')[f_name_in.length - 1].id = "f_name_ina"+c_value;
					opener.document.getElementsByClassName('f_unit')[f_unit.length - 1].id = "ina"+c_value;
					opener.document.getElementsByClassName('f_unit_in')[f_unit_in.length - 1].id = "f_unit_ina"+c_value;
					opener.document.getElementsByClassName('f_unit_in')[f_unit_in.length - 1].value = 1;
					opener.document.getElementsByClassName('f_price_in')[f_price_in.length - 1].value = f_price_value;
					opener.document.getElementsByClassName('f_price_in')[f_price_in.length - 1].id = "f_price_ina"+c_value;
					const setunit = opener.document.getElementsByClassName('f_unit_in');
					const setprice = opener.document.getElementsByClassName('f_price_in');
					var total = 0;
					for (let i = 1; i < setprice.length; i++) {
						total = Number(total) + (Number(setprice[i].value) * Number(setunit[i].value));
					}
					
					opener.document.getElementById('f_sum').innerHTML = total + " 원";
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
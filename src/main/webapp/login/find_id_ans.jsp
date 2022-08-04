<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.1">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>ChanggiFood-ID/PW찾기</title>
<%
	ArrayList<String> ans = (ArrayList<String>)request.getAttribute("ans");
	if (request.getParameter("error") != null) {
		int error = Integer.valueOf(request.getParameter("error"));
		if (error == 0) {
%>
<script type="text/javascript">
	alert("찾으시는 ID가 존재하지 않습니다.");
	window.close();
</script>
<%
		}
	}
%>
</head>
<body>
	<section class="find_id_ans d-flex align-items-center justify-content-center" style="width: 600px; height: 500px">
        <div class="container">
        	<div class="mb-4 ml-4" style="position: absolute; top: 30px; left: 30px">
                <img src="../resources/images/logo_green.png" alt="" class="col-3">
            </div>
            <div class="d-flex justify-content-center align-items-center">
                <div class="col-10 pb-5">
                    <h3>ID 찾기</h3>
                    <br>
           			<h3>
	            <%
	            	if (ans != null) {
		            	for(int i = 0; i < ans.size(); i++) {
		            		if (i==0) {
	       		%>
	       			<%=ans.get(i)%>
	       		<%
		            		}
		            		else {
	            			
	   			%>
	   				<%=", "+ans.get(i) %>
	   			<%
		            		}
		            	}
	            	}
	            %>
	            	</h3>
			     </div>
            </div>
            <div class="d-flex justify-content-center" style="position: absolute; left: 50%; bottom: 75px; transform: translateX(-50%);" >
                <a href="find_pw.jsp" class="btn btn-success">패스워드 찾기</a>
            </div>
        </div>
     </section>
</body>
</html>
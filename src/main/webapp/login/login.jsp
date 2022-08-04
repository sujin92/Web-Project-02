<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
	String signup = request.getParameter("signup");
	if (signup != null){
%>
	<script type="text/javascript">
		alert("ChanggiFood에 회원가입이 되었습니다.");
	</script>
<%
	}
%>
<script type="text/javascript">
	function openNewWindow(obj) { 
		var popupwidth = 610;
		var popupheight = 510;
		var popx = (window.screen.width / 2) - (popupwidth / 2);
		var popy = (window.screen.height / 2) - (popupheight / 2);
		open (obj,"Mail","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, width=610, height=510, left="+popx+",top="+popy);
	}
</script>
<title>ChanggiFood-로그인</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
 	<section class="login">
        <div class="container">
            <div class="col-6">
                <h3>LOGIN</h3>
                <form action="login.lo" class="form-horizatal" method="post">
                    <div class="form-group">
                        <input name="id" type="text" placeholder="아이디 (920907v)" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <input name="pw" type="password" placeholder="비밀번호 (영문, 숫자, 특수문자 조합 10~14자리)"  class="form-control" required maxlength="14">
                    </div>
                    <div class="form-group">
                        <input type="submit" value="로그인" class="form-control">
                    </div>
                    <div class="form-group">
                        <a href="sel_login.jsp" class="form-control">회원가입</a>
                    </div>
                </form>
                <div>
                    <a href="javascript:openNewWindow('find_id.jsp')">이메일 아이디 찾기</a> | <a href="javascript:openNewWindow('find_pw.jsp')">패스워드 찾기</a>
                </div>
                <div>
                    <span>SNS 간편 로그인</span>
                </div>
                <div>
                    <a href="" class="form-control">네이버 아이디로 로그인</a>
                    <a href="" class="form-control">카카오 아이디로 로그인</a>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
    <%
    	String error = request.getParameter("error");
    	if (error != null && error.equals("1")) {
    %>
    	<script type="text/javascript">
    		alert("아이디와 비밀번호를 다시 확인해주세요.");
    	</script>
    <%
    	}
    %>
</body>
</html>
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
<title>ChanggiFood-회원가입</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
    <section class="sel_sign">
        <div class="container">
            <div class="col-6">
                <h3>회원가입</h3>
                <div>
                    <h5>저희 몰에 회원가입하시면 모든 서비스 이용 및<br>다양한 혜택을 누리실 수 있습니다.</h5>
                </div>
                <div>
                    <a href="./signUp.jsp" class="form-control">개인 회원 가입</a>
                </div>
                <div>
                    <a href="./seller_signUp.jsp" class="form-control">사업자 회원 가입</a>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
</html>
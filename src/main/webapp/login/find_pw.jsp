<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ChanggiFood-비밀번호 찾기</title>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.1">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<section class="find_pw d-flex align-items-center justify-content-center" style="width: 600px; height: 500px">
	    <div class="container">
	        <div class="mb-4 ml-4" style="position: absolute; top: 30px; left: 30px">
                <img src="../resources/images/logo_green.png" alt="" class="col-3">
	        </div>
	        <form action="pwsearch.lo" method="post" name="pwForm">
	            <div class="mb-3">
	                <label class="pl-4 ml-3">아이디 입력</label>
	                <div class="col-12 row text-center d-flex align-items-center justify-content-center">
	                    <input type="text" class="form-control mb-1 col-11" placeholder="ID 입력" name="id" id="id">
	                </div>
	            </div>
	            <div class="mb-3">
	                <label class="pl-4 ml-3">휴대폰 번호로 찾기</label>
	                <div class="col-12 row text-center d-flex align-items-center justify-content-center">                
	                    <input type="text" class="col-3 form-control" id="phone1" name="phone1"><span class="col-1">-</span><input type="text" class="col-3 form-control" id="phone2" name="phone2"><span class="col-1">-</span><input type="text" class="col-3 form-control" id="phone3" name="phone3">
	                </div>
	            </div>
	            <div class="mb-5">
	                <label class="pl-4 ml-3 mt-3">이메일로 찾기</label>
	                <div class="col-12 row text-center d-flex align-items-center justify-content-center">                
	                    <input type="text" name="mail" id=mail class="form-control col-11">
	                </div>
	            </div>
	            <div class="d-flex justify-content-center mt-5">
	                <input type="button" value="PW 찾기" class="btn btn-success col-4" onclick="pwsearch()">
	            </div>
	        </form>
	    </div>
	</section>
     <script type="text/javascript">
     	function  pwsearch() {
     		var phone1 = document.getElementById('phone1');
     		var phone2 = document.getElementById('phone2');
     		var phone3 = document.getElementById('phone3');
     		var id = document.getElementById('id');
     		var mail = document.getElementById('mail');
     		if ((phone1.value == "" || phone2.value == "" || phone3.value == "") && mail.value == "") {
     			alert("휴대폰이나 이메일을 입력하신 후에 PW 찾기를 눌러주세요.");
     			return false;
     		}

     		if (id.value == "") {
     			alert("ID를 입력해주세요.");
     			return false;
     		}
     		
     		if (!(phone1.value == "" && phone2.value == "" && phone3.value == "") && !(mail.value == "")){
     			alert("휴대폰이나 이메일 중 1개만 입력해주세요.");
     			return false;
     		}
     		
     		document.pwForm.submit();
     	}
     </script>
</body>
</html>
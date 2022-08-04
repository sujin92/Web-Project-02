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
<title>ChanggiFood-ID/PW찾기</title>
<%
	String user = (String)request.getAttribute("user");
	String id = (String)request.getAttribute("id");
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
		else if (error == 1) {
%>
<script type="text/javascript">
	alert("비밀번호가 정상적으로 변경되었습니다.");
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
			<form action="pwchange.lo?id=<%=id%>&user=<%=user%>" method="post" name="pwcForm">
                <div class="form-group row d-flex justify-content-center align-items-center">
                    <label class="col-4 mb-0 text-center">비밀번호 변경</label>
                    <input class="col-6 form-control" id="pw" name="pw" type="password" onchange="pwchk()">
                </div>
                <div class="form-group row d-flex justify-content-center align-items-center">
                    <label class="col-4 mb-0 text-center">비밀번호 변경 확인</label>
                    <input class="col-6 form-control" id="pwre" name="pwre" type="password" onchange="pwchk()">
                </div>
                <div class="row justify-content-center align-items-center" style="display: none;" id="pwsuc">
                    <label class="col-4"></label>
                    <p class="col-6 p-0 m-0" style="color: #28b421;">비밀번호가 일치합니다.</p>
                </div>
                <div class="row justify-content-center align-items-center" style="display: none;" id="pwfail">
                    <label class="col-4"></label>
                    <p class="col-6 p-0 m-0" style="color: red;">비밀번호가 일치하지 않습니다.</p>
                </div>
                <div class="form-group row d-flex justify-content-center align-items-center" style="position: absolute; left: 50%; transform: translateX(-50%); bottom: 75px;">
                    <input type="button" value="비밀번호 변경" class="btn btn-success" id="pwsub" disabled onclick="pwchangsub()">
                </div>
            </form>
        </div>
     </section>
     <script type="text/javascript">
     	function pwchk() {
     		var pw = document.getElementById('pw');
     		var pwre = document.getElementById('pwre');
     		if (pw.value != "" && pw.value != pwre.value) {
     			document.getElementById('pwfail').style.display = "flex";
     			document.getElementById('pwsuc').style.display = "none";
     			document.getElementById('pwsub').disabled = true;
     		}
     		if (pw.value != "" && pw.value == pwre.value) {
     			document.getElementById('pwsuc').style.display = "flex";
     			document.getElementById('pwfail').style.display = "none";
     			document.getElementById('pwsub').disabled = false;
     		}
     	}
     	function pwchangsub() {
     		var pw = document.getElementById('pw');
     		if (pw.value == "") {
     			alert("변경할 비밀번호를 입력해주세요");
     			return false;
     		}
     		else if(!check(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/, pw, "[비밀번호]\n영문, 숫자, 특수문자 조합 8~20자리 입력해주세요.")) {
     	        return false;
     	    }
     			
   			function check(regExp, e, msg) {
    	        if (regExp.test(e.value)) {
    	            return true;
    	        }
    	        alert(msg);
    	        e.select();
    	        e.focus();
    	        return false;
     	    }
   			
   			document.pwcForm.submit();
     	}
     </script>
</body>
</html>
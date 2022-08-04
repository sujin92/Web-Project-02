<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.orderlist" %>
<%@ page import="dto.seller" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<%	
	seller sellinfo = (seller)request.getAttribute("sellinfo");
	String name = "";
	
	if (session.getAttribute("seller") != null) {
		name = (String)session.getAttribute("seller");
	}
%>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.3">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<meta charset="UTF-8">
<title>ChanggiFood-Seller Management</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="s_modi">
        <div>
            <div class="container">
            	<h3>점포 관리</h3>
            </div>
            <div class="container">
                <i class="fa-solid fa-user"></i>
                <h5>안녕하세요. <%=name %> 님</h5>
            </div>
        </div>
        <div class="container">
        	<div class="row">
            	<div class="col-3">
                	<div>
                    	<img src="../resources/images/logo_green.png" width="35%">
                    </div>
                    <ul>
                        <a href="<c:url value='/login/store_management.lo?order=waiting&page=1'/>"><li>주문 내역<span>&gt;</span></li></a>
                        <a href="<c:url value='/login/modisellerchk.jsp'/>"><li>점포 정보 수정<span>&gt;</span></li></a>
                    </ul>
                </div>
                <div class="col-9">
                    <form action="selmodi.lo" method="post" name="selmodiForm">
   	                    <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                        <label class="col-3">사업자등록번호</label>
	                        <input type="text" class="col-7 form-control" readonly name="com_number" value="<%=sellinfo.getS_com_number()%>">
	                    </div>
                        <div class="mt-5 row col-12 d-flex align-items-center justify-content-center form-group">
                            <label class="col-3">아이디</label>
                            <input type="text" class="col-7 form-control" readonly name="id" value="<%=name%>">
                        </div>
                        <div class="row col-12 d-flex align-items-center justify-content-center form-group">
                            <label class="col-3">비밀번호 변경</label>
                            <input type="password" class="col-7 form-control" name="pwchk" id="pwchk" onchange="success()">
                        </div>
                        <div class="row col-12 d-flex align-items-center justify-content-center form-group">
                            <label class="col-3">비밀번호 변경 재확인</label>
                            <input type="password" class="col-7 form-control" name="pwchkre" id="pwchkre" onchange="success()">
                            <input type="hidden" name="pwchkans" id="pwchkans" value="0">
                        </div>
                        <div class="pwans row col-12 d-flex align-items-center justify-content-center form-group">
                            <label class="col-3"></label>
                            <div class="col-7">
                                <p id="pwans_success">비밀번호가 일치합니다.</p>
                                <p id="pwans_faile">비밀번호가 일치하지 않습니다.</p>
                            </div>
                        </div>
                        <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                        <label class="col-3">상호명</label>
	                        <input type="text" class="col-7 form-control" id="com_name" name="com_name" value="<%=sellinfo.getS_com_name()%>">
	                    </div>
	                    <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                        <label class="col-3">대표자 이름</label>
	                        <input type="text" class="col-7 form-control" id="owner_name" name="owner_name" value="<%=sellinfo.getS_owner_name()%>">
	                    </div>
	                    <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                        <label class="col-3">이메일</label>
	                        <input type="text" class="col-7 form-control" id="email" name="email" value="<%=sellinfo.getS_mail()%>">
	                    </div>
	                    <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                        <label class="col-3">휴대전화</label>
	                        <input type="text" class="col-7 form-control" id="phone" name="phone" value="<%=sellinfo.getS_phone()%>">
	                    </div>
	                    <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                        <label class="col-3">주소</label>
	                        <input type="text" class="col-7 form-control" readonly name="addr" value="<%=sellinfo.getS_addr()%>">
	                    </div>
	                    <%
	                    
	                    %>
	                    <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                  	    <label class="col-3"></label>
	                  	    <input name="addr1" type="text" id="sample6_postcode" placeholder="우편번호" class="col-4 mr-3 form-control">
	                  		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="ml-5 col-2 form-control btn btn-secondary">				
	                  	</div>
	                  	<div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                  		<label class="col-3"></label>
	   						<input name="addr2" type="text" id="sample6_address" placeholder="주소" class="col-7 form-control">                    	
						</div>
						<div class="row col-12 d-flex align-items-center justify-content-center form-group">
                  			<label class="col-3"></label>
							<input name="addr3" type="text" id="sample6_detailAddress" placeholder="상세주소" class="col-7 form-control">
                  		</div>
                      	<div class="mt-5 row col-12 d-flex align-items-center justify-content-center form-group">
	                        <input type="button" value="수정하기" class="btn btn-success col-4 mx-2" onclick="modi()">
	                        <input type="button" value="탈퇴하기" class="btn btn-danger col-4" onclick="unsign()">
                        </div>
                   	</form>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
<script type="text/javascript">
	function unsign() {
		if (confirm("ChanggiFood를 탈퇴하시겠습니까?")) {
			document.selmodiForm.action = "unsign.lo";
			document.selmodiForm.submit();
		}
	}
	function success() {
	    if(document.getElementById('pwchk').value != "" && document.getElementById('pwchkre').value != "" && document.getElementById('pwchk').value == document.getElementById('pwchkre').value) {
	        document.getElementById('pwans_success').style.display = 'block';
	        document.getElementById('pwans_faile').style.display = 'none';
	        document.getElementById('pwchkans').value = "1";
	    }
	    else if (document.getElementById('pwchk').value != "" && document.getElementById('pwchkre').value != "" && document.getElementById('pwchk').value != document.getElementById('pwchkre').value) {
	        document.getElementById('pwans_faile').style.display = 'block';
	        document.getElementById('pwans_success').style.display = 'none';
	        document.getElementById('pwchkans').value = "0";
	    }
	};
	function modi() {
		var pw = document.getElementById('pwchk');
		var pwchk = document.getElementById('pwchkans');
		var phone = document.getElementById('phone');
		var email = document.getElementById('email');
		var com_name = document.getElementById('com_name');
		var owner_name = document.getElementById('owner_name');
		
		if (!pw.value=="" && pwchk.value == 0) {
			alert("[비밀번호]\n비밀번호가 일치하지 않습니다.");
			return false;
		}
		if (!pw.value == "") {
			if (!check(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/, pw, "[비밀번호]\n영문, 숫자, 특수문자 조합 8~20자리 입력해주세요.")){
				return false;
			}
		}
	    if (com_name.value == "") {
	        alert("[상호명]\n상호명을 입력해주세요.");
	        return false;
	    }
	    if (owner_name.value == "") {
	        alert("[대표자 이름]\n대표자 이름을 입력해주세요.");
	        return false;
	    }
		if (phone.value == "") {
	        alert("[휴대전화]\n휴대전화를 입력해주세요.");
	        return false;
	    } 
	    else if (!check(/^\d{3}-\d{3,4}-\d{4}$/, phone, "[휴대전화]\n'-'를 포함하여 정확하게 입력해주세요.")){
	        return false;
	    }
		if (!check(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/, email, "[이메일]\n이메일 형식을 확인해주세요.")){
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
	    document.selmodiForm.submit();
	}

	function sample6_execDaumPostcode() {	
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample6_postcode').value = data.zonecode;
	            document.getElementById("sample6_address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("sample6_detailAddress").focus();
	        }
	    }).open();
	}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.customer" %>
<%@ page import="dto.cartlist" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.4">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>ChanggiFood-MyPage</title>
<% 
	ArrayList<cartlist> mycart = (ArrayList<cartlist>)session.getAttribute("myCart");
	customer ct = (customer)request.getAttribute("userinfo");
	String id = (String)session.getAttribute("userid");
	String gender = ct.getGender();

	int cartcnt = 0;
	if (mycart != null) {
		cartcnt = mycart.size();
	}
	String name = "";
	int point = 0;
	String c_class = "";
	float dis = 0;
	if (session.getAttribute("user") != null){
		customer cu = (customer)session.getAttribute("user");
		name = cu.getName();
		point = cu.getPoint();
		c_class = cu.getC_class();
	}
	if (c_class.equals("BRONZE")) {
		dis = 1.0f;
	}
	else if (c_class.equals("SILVER")) {
		dis = 3.0f;
	}
	else if (c_class.equals("GOLD")) {
		dis = 5.0f;
	}
	ArrayList<cartlist> al = (ArrayList<cartlist>)request.getAttribute("mypage"); 
%>
<script type="text/javascript">
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
</script>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="modi_mypage">
          <div>
               <div class="container">
                    <h3>마이페이지</h3>
                    <div>
                         <div>
                              <i class="fa-solid fa-user"></i>
                              <p>안녕하세요. <%=name %>님</p>
                              <p><%=c_class %> 등급 | <%=dis%>%적립</p>
                         </div>
                         <div>
                              <h5>적립금 &gt;</h5>
                              <h5 class="hh"><%=point %>원</h5>
                              <p>소멸 예정 : 0원</p>
                         </div>
                         <div>
                              <h5>쿠폰 &gt;</h5>
                              <h5 class="hh">0개</h5>
                         </div>
                         <div>
                              <a href="<c:url value='/cart/cart.jsp'/>"><h5>장바구니 &gt;</h5></a>
                              <h5 class="hh"><%=cartcnt %>개</h5>
                         </div>
                    </div>
               </div>
          </div>
          <div class="container">
               <div class="row">
                    <div class="col-3">
                         <div>
                              <img src="../resources/images/logo_green.png" width="35%">
                         </div>
                         <ul>
                              <a href="mypage.ca?page=1&orderperiod=1year"><li>주문 내역 <span>&gt;</span></li></a>
                              <a href="<c:url value='/community/one_qna.bo?page=1'/>"><li>상품 문의<span>&gt;</span></li></a>
                              <a href="<c:url value='/login/modimypagechk.jsp'/>"><li>개인정보 수정<span>&gt;</span></li></a>
                         </ul>
                    </div>
                    <div class="col-9">
                         <form action="modi.lo" method="post" name="modiForm">
	                         <div class="mt-5 row col-12 d-flex align-items-center justify-content-center form-group">
	                              <label class="col-3">아이디</label>
	                              <input type="text" class="col-7 form-control" readonly name="id" value="<%=id%>">
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
	                              <label class="col-3">이름</label>
	                              <input type="text" class="col-7 form-control" id="name" name="name" value="<%=ct.getName()%>">
	                         </div>
	                         <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                              <label class="col-3">이메일</label>
	                              <input type="text" class="col-7 form-control" id="email" name="email" value="<%=ct.getMail()%>">
	                         </div>
	                         <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                              <label class="col-3">휴대전화</label>
	                              <input type="text" class="col-7 form-control" id="phone" name="phone" value="<%=ct.getPhone()%>">
	                         </div>
	                         <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                              <label class="col-3">주소</label>
	                              <input type="text" class="col-7 form-control" readonly name="addr" value="<%=ct.getAddr()%>">
	                         </div>
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
	                         <div class="row col-12 d-flex align-items-center justify-content-center form-group">
	                              <label class="col-3">성별</label>
	                              <div class="col-7 row m-0 d-flex align-items-center justify-content-center">
	                                   <input type="radio" id="man" name="gender" value="남성">
	                                   <label for="man" class="col-3">남성</label>
	                                   <input type="radio" id="women" name="gender" value="여성">
	                                   <label for="women"class="col-3">여성</label>
	                                   <input type="radio" id="nosel" name="gender" value="선택안함">
	                                   <label for="nosel"class="col-3">선택안함</label>
	                              </div>
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
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function unsign() {
		if (confirm("ChanggiFood를 탈퇴하시겠습니까?")) {
			document.modiForm.action = "unsign.lo";
			document.modiForm.submit();
		}
	}
	function modi() {
		var pw = document.getElementById('pwchk');
		var pwchk = document.getElementById('pwchkans');
		var phone = document.getElementById('phone');
		var email = document.getElementById('email');
		var name = document.getElementById('name');
		
		if (!pw.value=="" && pwchk.value == 0) {
			alert("[비밀번호]\n비밀번호가 일치하지 않습니다.");
			return false;
		}
		if (!pw.value == "") {
			if (!check(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/, pw, "[비밀번호]\n영문, 숫자, 특수문자 조합 8~20자리 입력해주세요.")){
				return false;
			}
		}
	    if (name.value == "") {
	        alert("[이름]\n이름을 입력해주세요.");
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
	    document.modiForm.submit();
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
<%
	if (gender.equals("남성")) {
%>
<script type="text/javascript">
	document.getElementById('man').checked = true;
</script>
<%
	}
	else if (gender.equals("여성")) {
%>
<script type="text/javascript">
	document.getElementById('women').checked = true;
</script>
<%
	}
	else {
%>
<script type="text/javascript">
	document.getElementById('nosel').checked = true;
</script>
<%
	}
%>
</html>
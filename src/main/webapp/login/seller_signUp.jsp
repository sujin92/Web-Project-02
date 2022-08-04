<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.2">
<script type="text/javascript" src="../resources/js/validate.js?ver=2.4"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>ChanggiFood-사업자 고객 회원가입</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
    <section class="seller_signup">
        <div class="container">
            <div>
                <h5>사업자</h5>
                <h3>회원가입</h3>
            </div>
            <div>
                <h5>* 필수 입력 사항</h5>
            </div>
            <hr>
            <div>
                <form action="seller_signup.lo" method="post" name="signForm" class="form-horizatal col-9">
                    <div class="form-group row">
                        <label class="col-3">아이디 <span>*</span></label>
                        <input name="id" id="id" type="text" placeholder="아이디(920907v)" required class="form-control col-5 id">
                        <input id="idchkbtn" type="button" value="중복확인" class="btn btn-secondary ml-2 col-3 idchk" onclick="selidchk()">
                    </div>
                    <div class="form-group row">
                    	<label class="col-3"></label>
                    	<div class="col-5">
                    		<p id="idsuccess" style="display: none; color: #28b421;">사용가능한 아이디 입니다.</p>
                    		<p id="idfaile" style="display: none; color : red;">사용 불가능한 아이디 입니다.</p>
                    		<p id="idans" style="display: none;">아이디를 다시 확인하신 후 입력해주세요(8자리 이상)</p>
                    		<input type="hidden" id="idchkbul" value="">
                    	</div>
                    </div>
                    <div class="form-group row">
                        <label class="col-3">비밀번호 <span>*</span></label>
                        <input name="pw" id="pw" type="password" placeholder="비밀번호(영문, 숫자, 특수문자 조합 10~14자리)" required class="form-control col-5" onchange="success()">
                    </div>
                    <div class="form-group row">
                        <label class="col-3">비밀번호 확인 <span>*</span></label>
                        <input id="pwre" type="password" placeholder="비밀번호를 한 번 더 입력해주세요." required class="form-control col-5" onchange="success()">
                    </div>
                    <div class="pwans row">
                        <div class="col-3"></div>
                        <div class="col-5">
                            <p id="pwans_success">비밀번호가 일치합니다.</p>
                            <p id="pwans_faile">비밀번호가 일치하지 않습니다.</p>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-3">상호 <span>*</span></label>
                        <input name="name" id="name" type="text" placeholder="기업명을 입력해주세요." required class="form-control col-5">
                    </div>
                    <div class="form-group row">
                        <label class="col-3">사업자등록번호 <span>*</span></label>
                        <input name="number" id="number" type="text" placeholder="'-'포함하여 입력해주세요." required class="form-control col-5">
                        <input type="button" value="중복확인" class="btn btn-secondary ml-2 col-3" onclick="sellnumchk()" id="sellnumchkbtn">
                    </div>
                    <div class="form-group row">
                    	<label class="col-3"></label>
                    	<div class="col-5">
                    		<p id="sellnumsuccess" style="display: none; color: #28b421;">사용가능한 사업자등록번호입니다.</p>
                    		<p id="sellnumfaile" style="display: none; color : red;">사용 불가능한 사업자등록번호입니다.</p>
                    		<input type="hidden" id="sellnumchkbul" value="">
                    	</div>
                    </div>
                    <div class="form-group row">
                        <label class="col-3">대표자명 <span>*</span></label>
                        <input name="ownername" id="ownername" type="text" placeholder="대표자명을 입력해주세요." required class="form-control col-5">
                    </div>
                    <div class="form-group row">
                        <label class="col-3">이메일 <span>*</span></label>
                        <input name="email" id="mail" type="text" placeholder="이메일 (920907v@naver.com)" required class="form-control col-5">
                        <input type="button" value="중복확인" class="btn btn-secondary ml-2 col-3" onclick="emailchk()" id="emailchkbtn">
                    </div>
                    <div class="form-group row">
                    	<label class="col-3"></label>
                    	<div class="col-5">
                    		<p id="emailsuccess" style="display: none; color: #28b421;">사용가능한 이메일 입니다.</p>
                    		<p id="emailfaile" style="display: none; color : red;">사용 불가능한 이메일 입니다.</p>
                    		<p id="emailans" style="display: none;">이메일을 다시 확인하신 후 입력해주세요</p>
                    		<input type="hidden" id="emailchkbul" value="">
                    	</div>
                    </div>
                    <div class="form-group row">
                        <label class="col-3">휴대전화 <span>*</span></label>
                        <input name="phone" id="phone" type="text" placeholder="'-'을 포함하여 입력해주세요." required class="form-control col-5">
                    </div>
                    <div class="form-group row">
                    	<label class="col-3">주소 <span>*</span></label>
                    	<input name="addr1" type="text" id="sample6_postcode" placeholder="우편번호" class="col-5 form-control">
                    	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="ml-2 col-3 form-control btn btn-secondary">				
                    </div>
                    <div class="form-group row">
                    	<label class="col-3"></label>
     					<input name="addr2" type="text" id="sample6_address" placeholder="주소" class="col-5 form-control">                    	
					</div>
					<div class="form-group row">
                    	<label class="col-3"></label>
						<input name="addr3" type="text" id="sample6_detailAddress" placeholder="상세주소" class="col-5 form-control">
                    </div>
                    <div class="form-group row protocol">
                        <label class="col-3">약관 동의 <span>*</span></label>
                        <div class="col-9 row">
                            <div class="col-8 form-group">
                                <input type="checkbox" id="ch1" onclick="selectAll(this)">
                                <label for="ch1">전체 동의합니다.</label>
                            </div>
                            <div class="col-8 form-group">
                                <input type="checkbox" id="ch2" name="allcheck" class="allcheck">
                                <label for="ch2">이용 약관 동의(필수)</label>
                            </div>
                            <div class="col-4 form-group">
                                <input type="button" id="procheck1" value="약관보기" class="btn btn-secondary col-12 ml-2">
                            </div>
                            <div class="col-8 form-group">
                                <input type="checkbox" id="ch3" name="allcheck" class="allcheck">
                                <label for="ch3">개인 정보 수집 · 이용 동의 (필수)</label>
                            </div>
                            <div class="col-4 form-group">
                                <input type="button" id="procheck2" value="약관보기" class="btn btn-secondary col-12 ml-2">
                            </div>
                            <div class="col-8">
                                <input type="checkbox" id="ch4" name="allcheck" onclick="markettingAll(this)" class="allcheck">
                                <label for="ch4">혜택/정보 수신 동의(선택)</label>
                            </div>
                            <div class="col-8 row form-group">
                                <div class="ml-3 col-5">
                                    <input type="checkbox" id="ch4_1" name="smark" class="markettingcheck allcheck">
                                    <label for="ch4_1">SMS</label>
                                </div>
                                <div class="col-5">
                                    <input type="checkbox" id="ch4_2" name="emark" class="markettingcheck allcheck">
                                    <label for="ch4_2">이메일</label>
                                </div>
                            </div>
                            <div class="col-8 form-group">
                                <input type="checkbox" id="ch5" name="allcheck" class="allcheck">
                                <label for="ch5">본인은 만 14세 이상입니다. (필수)</label>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row submit">
                        <input type="button" value="가입하기" class="btn btn-secondary col-6" id="check" disabled onclick="validate2()">
                    </div>
                </form>
            </div>
        </div>
    </section>
    <section class="s_modal">
        <div class="s_modal_bg"></div>
        <div class="s_modal_wrap mdw_1">
            <div>
                <h3>이용 약관 내역</h3>
                <hr>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
            </div>
            <div>
                <button class="s_modal_close mdc_1 btn">닫기</button>
            </div>
        </div>
        <div class="s_modal_wrap mdw_2">
            <div>
                <h3>개인정보 수집 · 이용 동의</h3>
                <hr>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
                <p>약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.약관 내역입니다.</p>
            </div>
            <div>
                <button class="s_modal_close mdc_2 btn">닫기</button>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function selidchk() {
		var id = document.getElementById('id').value;
		window.open("idchk.lo?id="+id+"&user=seller", "idchk", "width:0px, height:0px");	
	}
	function emailchk() {
		var email = document.getElementById('mail').value;
		window.open("emailchk.lo?email="+email+"&user=seller","emailchk", "width:0px, height:0px");
	}
	function sellnumchk() {
		var sellnum = document.getElementById('number').value;
		window.open("sellnumchk.lo?sellnum="+sellnum+"&user=seller","sellnumchk", "width:0px, height:0px");
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
</html>
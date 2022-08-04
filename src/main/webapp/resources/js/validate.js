function validate() {
    var idchkbul = document.getElementById('idchkbul');
    var id = document.getElementById('id');
    var pw = document.getElementById('pw');
    var pwre = document.getElementById('pwre');
    var name = document.getElementById('name');
    var mailchkbul = document.getElementById('emailchkbul');
    var mail = document.getElementById('mail');
    var phone = document.getElementById('phone');
    var addr = document.getElementById('sample6_address');
    var addr2 = document.getElementById('sample6_detailAddress');
    var ch2 = document.getElementById('ch2');
    var ch3 = document.getElementById('ch3');
    var ch5 = document.getElementById('ch5');

    if (idchkbul.value == "") {
		alert("[아이디]\n아이디 중복체크를 해주세요.");
        id.focus;
        id.select;
        return false;
    }

    if (pw.value == "") {
        alert("[비밀번호]\n비밀번호를 입력해주세요.");
        pw.focus;
        pw.select;
        return false;
    }
    else if(!check(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/, pw, "[비밀번호]\n영문, 숫자, 특수문자 조합 8~20자리 입력해주세요.")) {
        return false;
    }

    if (pwre.value == "") {
        alert("[비밀번호 확인]\n비밀번호 확인을 입력해주세요.");
        pwre.focus;
        pwre.select;
        return false;
    }

    if (name.value == "") {
        alert("[이름]\n이름을 입력해주세요.");
        name.focus;
        name.select;
        return false;
    }

    if (mailchkbul.value == "") {
        alert("[이메일]\n이메일 중복체크를 해주세요.");
        mail.focus;
        mail.select;
        return false;
    }


    if (phone.value == "") {
        alert("[휴대전화]\n휴대전화를 입력해주세요.");
        phone.focus;
        phone.select;
        return false;
    } 
    else if (!check(/^\d{3}-\d{3,4}-\d{4}$/, phone, "[휴대전화]\n'-'를 포함하여 정확하게 입력해주세요.")){
        return false;
    }
    if (addr2.value == "") {
        alert("[주소]\n상세 주소를 입력해주세요.");
        addr2.focus;
        addr2.select;
        return false;
    } 

    if (ch2.checked == false) {
        alert("[약관동의]\n가입을 위해 이용 약관 동의가 필요합니다.");
        ch2.focus;
        ch2.select;
        return false;
    } 
    if (ch3.checked == false) {
        alert("[약관동의]\n가입을 위해 개인 정보 수집 · 이용 동의가 필요합니다.");
        ch3.focus;
        ch3.select;
        return false;
    } 
    if (ch5.checked == false) {
        alert("[약관동의]\n가입을 위해 14세 이상 확인이 필요합니다.");
        ch5.focus;
        ch5.select;
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
    document.signForm.submit();
}
	function success() {
   		const target = document.getElementById('check')
        if(document.getElementById('pw').value != "" && document.getElementById('pwre').value != "" && document.getElementById('pw').value == document.getElementById('pwre').value) {
            document.getElementById('pwans_success').style.display = 'block';
            document.getElementById('pwans_faile').style.display = 'none';
            target.disabled = false;       
        }
        else if (document.getElementById('pw').value != "" && document.getElementById('pwre').value != "" && document.getElementById('pw').value != document.getElementById('pwre').value) {
            document.getElementById('pwans_faile').style.display = 'block';
            document.getElementById('pwans_success').style.display = 'none';
            target.disabled = true;
        }
    };

window.onload = function() {
    function onpage() {
        document.querySelector('.s_modal_bg').style.display = 'block';
        document.querySelector('.mdw_1').style.display = 'block';
        $('body').css('overflow', 'hidden');
    }
    function offpage() {
        document.querySelector('.s_modal_bg').style.display = 'none';
        document.querySelector('.mdw_1').style.display = 'none';
        $('body').css('overflow-Y', 'scroll');
    }
    document.getElementById('procheck1').addEventListener('click', onpage);
    document.querySelector('.mdc_1').addEventListener('click', offpage);

    function onpage2() {
        document.querySelector('.s_modal_bg').style.display = 'block';
        document.querySelector('.mdw_2').style.display = 'block';
        $('body').css('overflow', 'hidden');
    }
    function offpage2() {
        document.querySelector('.s_modal_bg').style.display = 'none';
        document.querySelector('.mdw_2').style.display = 'none';
        $('body').css('overflow-Y', 'scroll');
    }
    document.getElementById('procheck2').addEventListener('click', onpage2);
    document.querySelector('.mdc_2').addEventListener('click', offpage2);
};

function validate2() {
    var id = document.getElementById('id');
    var pw = document.getElementById('pw');
    var pwre = document.getElementById('pwre');
    var name = document.getElementById('name');
    var number = document.getElementById('number');
    var ownername = document.getElementById('ownername');
    var mail = document.getElementById('mail');
    var phone = document.getElementById('phone');
    var addr = document.getElementById('sample6_address');
    var addr2 = document.getElementById('sample6_detailAddress');
    var ch2 = document.getElementById('ch2');
    var ch3 = document.getElementById('ch3');
    var ch5 = document.getElementById('ch5');

    if (id.value == "") {
        alert("[아이디]\n아이디를 입력해주세요.");
        id.focus;
        id.select;
        return false;
    }

    if (pw.value == "") {
        alert("[비밀번호]\n비밀번호를 입력해주세요.");
        pw.focus;
        pw.select;
        return false;
    }
    else if(!check(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/, pw, "[비밀번호]\n영문, 숫자, 특수문자 조합 8~20자리 입력해주세요.")) {
        return false;
    }

    if (pwre.value == "") {
        alert("[비밀번호 확인]\n비밀번호 확인을 입력해주세요.");
        pwre.focus;
        pwre.select;
        return false;
    }

    if (name.value == "") {
        alert("[상호]\n상호명을 입력해주세요.");
        name.focus;
        name.select;
        return false;
    }
    if (number.value == "") {
        alert("[사업자등록번호]\n사업자등록번호를 입력해주세요.");
        number.focus;
        number.select;
        return false;
    }
    if (ownername.value == "") {
        alert("[대표자명]\n대표자명을 입력해주세요.");
        owner.focus;
        owner.select;
        return false;
    }
    if (mail.value == "") {
        alert("[이메일]\n이메일을 입력해주세요.");
        mail.focus;
        mail.select;
        return false;
    }

    else if (!check(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/, mail, "[이메일]\n\'아이디@이메일주소\'의 형식으로 입력해주세요.")) {
            return false;
    }

    if (phone.value == "") {
        alert("[휴대전화]\n휴대전화를 입력해주세요.");
        phone.focus;
        phone.select;
        return false;
    } 
    else if (!check(/^\d{3}-\d{3,4}-\d{4}$/, phone, "[휴대전화]\n'-'를 포함하여 정확하게 입력해주세요.")){
        return false;
    }
    if (addr.value == "") {
		alert("[주소]\n우편번호 찾기를 클릭하여 주소를 입력해주세요.");
		addr.focus;
		addr2.select;
		return false;
	}
    
    if (addr2.value == "") {
        alert("[주소]\n상세 주소를 입력해주세요.");
        addr2.focus;
        addr2.select;
        return false;
    } 

    if (ch2.checked == false) {
        alert("[약관동의]\n가입을 위해 이용 약관 동의가 필요합니다.");
        ch2.focus;
        ch2.select;
        return false;
    } 
    if (ch3.checked == false) {
        alert("[약관동의]\n가입을 위해 개인 정보 수집 · 이용 동의가 필요합니다.");
        ch3.focus;
        ch3.select;
        return false;
    } 
    if (ch5.checked == false) {
        alert("[약관동의]\n가입을 위해 14세 이상 확인이 필요합니다.");
        ch5.focus;
        ch5.select;
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
    document.signForm.submit();
}

function selectAll(selectAll)  {
    const checkboxes 
         = document.querySelectorAll('.allcheck');
    
    checkboxes.forEach((checkbox) => {
      checkbox.checked = selectAll.checked;
    })
  };

  function markettingAll(selectAll)  {
    const checkboxes 
         = document.querySelectorAll('.markettingcheck');
    
    checkboxes.forEach((checkbox) => {
      checkbox.checked = selectAll.checked;
    })
  };


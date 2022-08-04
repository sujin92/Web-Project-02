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
<title>ChanggiFood-BoardWrite</title>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("userid");
	if (id == null) {
		id = (String)session.getAttribute("seller");
	}
	String category = request.getParameter("category");
	String sub_title = "";
	if (category.equals("공지사항")) {
		sub_title = "NOTICE";
	}
	else if (category.equals("게시판")) {
		sub_title = "BULLETIN";
	}
	else if (category.equals("1:1 문의")) {
		sub_title ="고객센터";
	}
	else if (category.equals("나만의 레시피")) {
		sub_title ="Make It";
	}
%>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
	<section class="bo_write">
        <div class="container">
            <h5><small><%=sub_title %></small></h5>
            <h3><%=category%></h3>
            <p>* 필수 입력 사항</p>
            <hr>
            <form action="" method="post" enctype="multipart/form-data" name="boardForm">
                <div class="form-group row">
                    <label class="col-2">작성자 <span>*</span></label>
                    <div class="col-10">
                        <input type="text" name="id" id="id" value="<%= id %>" class="form-control" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-2">제목 <span>*</span></label>
                    <div class="col-10">
                        <input type="text" name="title" id="title" class="form-control" placeholder="제목을 입력해주세요.">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-2">내용 <span>*</span></label>
                    <div class="col-10">
                        <textarea name="contents" id="contents" cols="30" rows="10" class="form-control" placeholder="내용을 입력해주세요." style="resize: none;"></textarea>
                    </div>
                </div>
                <%
                	if(!category.equals("1:1 문의")){
                %>
                <div class="form-group row">
                    <label class="col-2">첨부파일&nbsp;<input type="button" id="filepulsbnt" value="+" class="btn btn-success ml-3" onclick="fileplus()"></label>
                    <div class="col-10 row">
                        <input type="hidden" name="file1" id="file1" class="form-control col-6 mb-2 files" onchange="filecnt1(this)"> <input type="hidden" id="filechk1" value="X" class="btn btn-danger ml-3 mb-2" disabled onclick="filecan1()">
                        <input type="hidden" name="file2" id="file2" class="form-control col-6 mb-2 files" onchange="filecnt2(this)"><input type="hidden" id="filechk2" value="X" class="btn btn-danger ml-3 mb-2" disabled onclick="filecan2()">
                        <input type="hidden" name="file3" id="file3" class="form-control col-6 mb-2 files" onchange="filecnt3(this)"><input type="hidden" id="filechk3" value="X" class="btn btn-danger ml-3 mb-2" disabled onclick="filecan3()">
                        <input type="hidden" name="file4" id="file4" class="form-control col-6 mb-2 files" onchange="filecnt4(this)"><input type="hidden" id="filechk4" value="X" class="btn btn-danger ml-3 mb-2" disabled onclick="filecan4()">
                        <input type="hidden" name="file5" id="file5" class="form-control col-6 mb-2 files" onchange="filecnt5(this)"><input type="hidden" id="filechk5" value="X" class="btn btn-danger ml-3 mb-2" disabled onclick="filecan5()">
                        <p class="col-12">10MB 이하의 이미지만 등록 가능합니다.(최대 5개)</p>
                        <div class="row col-12">
	                       <img class="col-2" style="height: 100px; width: auto;" id="preview1" />
	                       <img class="col-2" style="height: 100px; width: auto;" id="preview2" />
	                       <img class="col-2" style="height: 100px; width: auto;" id="preview3" />
	                       <img class="col-2" style="height: 100px; width: auto;" id="preview4" />
	                       <img class="col-2" style="height: 100px; width: auto;" id="preview5" />
                        </div>
                    </div>
                </div>
                <%
                	}
                	else {
                %>
                <div class="form-group row">
                    <label class="col-2">카테고리 선택 *</label>
                    <div class="col-4">
                        <select class="form-control" id="qnasel" name="qnasel">
                        	<option value="" disabled selected>질문 선택</option>
                        	<option value="상품교환">상품교환</option>
                        	<option value="배송문의">배송문의</option>
                        	<option value="구매취소">구매취소</option>
                        	<option value="환불">환불</option>
                        	<option value="기타">기타</option>
                        </select>
                    </div>
                </div>
                <%
                	}
                %>
                <hr>
                <div>
                    <input type="button" value="작성완료" class="btn btn-secondary col-2" onclick="subwrite()">
                    <a href="#" class="btn btn-danger col-2">취소</a>
                </div>
            </form>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
<%
	if(id == null){
%>
<script type="text/javascript">
	function subwrite() {
		alert("로그인을 하신 후 이용해주세요");
		location.href="../login/login.jsp";
	}
</script>
<%
	}
	else if (category.equals("공지사항")){
%>
<script type="text/javascript">
	function subwrite() {
		var title = document.getElementById('title');
		var contents = document.getElementById('contents');
		if (title.value == "") {
			alert("제목을 입력해주세요.");
			return false;
		}
		if (contents.value == "") {
			alert("내용을 입력해주세요.");
			return false;
		}
		document.boardForm.action = "notice_write.bo";
		document.boardForm.submit();
	}
</script>
<%
	}
	else if (category.equals("게시판")){
%>
<script type="text/javascript">
	function subwrite() {
		var title = document.getElementById('title');
		var contents = document.getElementById('contents');
		if (title.value == "") {
			alert("제목을 입력해주세요.");
			return false;
		}
		if (contents.value == "") {
			alert("내용을 입력해주세요.");
			return false;
		}
		document.boardForm.action = "bulletin_write.bo";
		document.boardForm.submit();
	}
</script>
<%
	}
	else if (category.equals("1:1 문의")){
%>
<script type="text/javascript">
	function subwrite() {
		var title = document.getElementById('title');
		var contents = document.getElementById('contents');
		if (title.value == "") {
			alert("제목을 입력해주세요.");
			return false;
		}
		if (contents.value == "") {
			alert("내용을 입력해주세요.");
			return false;
		}
		if (document.getElementById('qnasel').value == ""){
			alert("문의 카테고리를 선택해주세요");
			return false;
		}
		document.boardForm.encoding="application/x-www-form-urlencoded";
		document.boardForm.action = "one_write.bo";
		document.boardForm.submit();
	}
</script>
<%
	}
	else if (category.equals("나만의 레시피")){
%>
<script type="text/javascript">
	function subwrite() {
		var title = document.getElementById('title');
		var contents = document.getElementById('contents');
		if (title.value == "") {
			alert("제목을 입력해주세요.");
			return false;
		}
		if (contents.value == "") {
			alert("내용을 입력해주세요.");
			return false;
		}
		document.boardForm.action = "review_write.bo";
		document.boardForm.submit();
	}
</script>
<%
	}
%>

<script type="text/javascript">
	var reader = new FileReader();
	function fileplus() {
		document.getElementById('file1').setAttribute("type","file");
		document.getElementById('filechk1').setAttribute("type","button");
		document.getElementById('filechk1').disabled = false;
	}
	
	function filecnt1(input) {
		if (document.getElementById('file1').value != ""){
			document.getElementById('file2').setAttribute("type","file");
			document.getElementById('filechk2').setAttribute("type","button");
			document.getElementById('filechk1').disabled = false;
		}
		if (input.files && input.files[0]) {
		   	
		    reader.onload = function(e) {
		    	document.getElementById('preview1').src = e.target.result;
		    };
		    	reader.readAsDataURL(input.files[0]);
		  	} else {
			document.getElementById('preview1').src = "";
		}
	}
	
	function filecan1() {
		document.getElementById('file1').value = "";
		document.getElementById('file1').setAttribute("type","hidden");
		document.getElementById('filechk1').setAttribute("type","hidden");
		document.getElementById('filechk1').disabled = true;
		document.getElementById('file1').value = "";
		document.getElementById('preview1').src = "";
    	reader.readAsDataURL(document.querySelectorAll('.files')[0].files[0]);

	}
	
	function filecnt2(input) {
		if (document.getElementById('file2').value != ""){
			document.getElementById('file3').setAttribute("type","file");
			document.getElementById('filechk3').setAttribute("type","button");
			document.getElementById('filechk2').disabled = false;
		}
		if (input.files && input.files[0]) {
		   	
		    reader.onload = function(e) {
		    	document.getElementById('preview2').src = e.target.result;
		    };
		    	reader.readAsDataURL(input.files[0]);
		  	} else {
			document.getElementById('preview2').src = "";
		}
	}
	
	function filecan2() {
		document.getElementById('file2').value = "";
		document.getElementById('file2').setAttribute("type","hidden");
		document.getElementById('filechk2').setAttribute("type","hidden");
		document.getElementById('filechk2').disabled = true;
		document.getElementById('file2').value = "";
		document.getElementById('preview2').src = "";
    	reader.readAsDataURL(document.querySelectorAll('.files')[1].files[0]);
	}
	
	function filecnt3(input) {
		if (document.getElementById('file3').value != ""){
			document.getElementById('file4').setAttribute("type","file");
			document.getElementById('filechk4').setAttribute("type","button");
			document.getElementById('filechk3').disabled = false;
		}
		if (input.files && input.files[0]) {
		   	
		    reader.onload = function(e) {
		    	document.getElementById('preview3').src = e.target.result;
		    };
		    	reader.readAsDataURL(input.files[0]);
		  	} else {
			document.getElementById('preview3').src = "";
		}
	}
	
	function filecan3() {
		document.getElementById('file3').value = "";
		document.getElementById('file3').setAttribute("type","hidden");
		document.getElementById('filechk3').setAttribute("type","hidden");
		document.getElementById('filechk3').disabled = true;
		document.getElementById('preview3').src = "";
	}
	
	function filecnt4(input) {
		if (document.getElementById('file4').value != ""){
			document.getElementById('file5').setAttribute("type","file");
			document.getElementById('filechk5').setAttribute("type","button");
			document.getElementById('filechk4').disabled = false;
		}
		if (input.files && input.files[0]) {
		   	
		    reader.onload = function(e) {
		    	document.getElementById('preview4').src = e.target.result;
		    };
		    	reader.readAsDataURL(input.files[0]);
		  	} else {
			document.getElementById('preview4').src = "";
		}
	}
	
	function filecan4() {
		document.getElementById('file4').value = "";
		document.getElementById('file4').setAttribute("type","hidden");
		document.getElementById('filechk4').setAttribute("type","hidden");
		document.getElementById('filechk4').disabled = true;
		document.getElementById('preview4').src = "";
	}
	
	function filecnt5(input) {
		if (document.getElementById('file4').value != ""){
			document.getElementById('filechk5').disabled = false;
		}
		if (input.files && input.files[0]) {
		   	
		    reader.onload = function(e) {
		    	document.getElementById('preview5').src = e.target.result;
		    };
		    	reader.readAsDataURL(input.files[0]);
		  	} else {
			document.getElementById('preview5').src = "";
		}
	}
	
	function filecan5() {
		document.getElementById('file5').value = "";
		document.getElementById('file5').setAttribute("type","hidden");
		document.getElementById('filechk5').setAttribute("type","hidden");
		document.getElementById('filechk5').disabled = false;
		document.getElementById('preview5').src = "";
	}
</script>
</html>
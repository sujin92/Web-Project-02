<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<link rel="stylesheet" href="../resources/css/style.css?ver=1.5">
<script src="https://kit.fontawesome.com/42c64699fb.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>ChanggiFood-Recipe Registration</title>
</head>
<body>
	<jsp:include page="/menu.jsp"/>
    <section class="recipe_add">
        <div class="container">
            <h3>레시피 등록</h3>
            <hr>
            <input type="hidden" id="inputcnt" value="0">
            <input type="hidden" id="suminput" value="0">
            <form action="addrecipe.re" class="row" method="post" enctype="multipart/form-data" name="addrecipeForm">
                <div class="col-6">
                	<div style="width:100%; height: 500px;border: 1px solid #ced4da; border-radius: 2px;">
                    	<img src="" alt="" style="width: 100%; height: 100%; display: none; border-radius: 2px;" id="preview" name="preview">
                    </div>
                    <input type="file" class="form-control mt-3" onchange="addimg(this)" id="reimg" name="reimg">
                </div>
                <div class="col-6">
                    <div class="row d-flex align-items-center form-group">
                        <label class="col-4">레시피 이름</label>
                        <input type="text" class="col-8 form-control" name="rename" id="rename">
                    </div>
                    <div class="row d-flex align-items-center form-group">
                        <label class="col-4">레시피 한줄 설명</label>
                        <input type="text" class="col-8 form-control" name="redes" id="redes">
                    </div>
                    <div class="row d-flex align-items-center form-group">
                    	<label class="col-4">카테고리</label>
                    	<select class="form-control col-8" name="catesel" id="catesel">
                    		<option value="" disabled selected style="display: none">카테고리 선택</option>
                    		<option value="밥·죽">밥/죽</option>
                    		<option value="국·탕·찌개·전골">국/탕/찌개/전골</option>
                    		<option value="면">면</option>
                    		<option value="찜·조림">찜/조림</option>
                    		<option value="구이">구이</option>
                    		<option value="튀김">튀김</option>
                    		<option value="나물">나물</option>
                    		<option value="기타">기타</option>
                    	</select>
                    </div>
                    <table class="table col-12">
                    	<tbody id="field">
	                        <tr class="text-center">
	                            <th class="col-3">상품명</th>
	                            <th class="col-3">갯수</th>
	                            <th class="col-3">상품가격</th>
	                            <th class="col-3">삭제</th>
	                        </tr>
	                        <tr class="text-center" id="pre_set" style="display: none;">
	                            <input type="hidden" class="f_name_in" name="f_name_in">
	                            <input type="hidden" class="f_price_in" name="f_price_in">
	                            <input type="hidden" class="f_unit_in" name="f_unit_in">
	                            <td class="f_name col-3 text-center"></td>
	                            <td class="f_unit col-3 text-center">
	                            	<input type="number" value="1" min="1" name="f_unit" class="form-control f_unit" onchange="chgprice(this)">                           
	                            </td>
	                            <td class="f_price col-3 text-center"></td class="col-3 text-center">
	                            <td class="f_del col-3 text-center">
	                            	<input type="button" class="btn btn-danger" id="f_delete" value="삭제" onclick="remove_input(this)">
	                            </td>
	                        </tr>
                        </tbody>
                    </table>
                    <div class="row">
                        <p class="col-6 text-center"><b>합계</b></p>
                        <p class="col-6 text-right"><b id="f_sum">0원</b></p>
                    </div>
                    <div class="row d-flex align-items-center form-group justify-content-end">
                        <input type="text" class="col-5 form-control" id="foodsearch">
                        <input type="button" class="btn btn-success ml-2 col-2" value="검색" onclick="food_search()">
                    </div>
                </div>
                <div class="col-12 mt-3">
                    <p><i class="fa-solid fa-book-open"></i>&nbsp;&nbsp;레시피 설명</p>
                    <textarea rows="20" class="col-12 form-control" style="resize: none;" placeholder="나만의 레시피를 등록해주세요." name="retip" id="retip"></textarea>
                </div>
                <div class="col-12 d-flex justify-content-end mt-3">
                    <input type="button" value="등록" class="btn btn-success col-2" onclick="addrecipechk()">
                </div>
            </form>
            </div>
        </div>
    </section>
    <jsp:include page="/footer.jsp"/>
</body>
<script type="text/javascript">
	function addrecipechk() {
		var reimg = document.getElementById('reimg');
		var rename = document.getElementById('rename');
		var redes = document.getElementById('redes');
		var catesel = document.getElementById('catesel');
		var f_name = document.getElementsByClassName('f_name_in');
		var retip = document.getElementById('retip');
		
		if (reimg.value == null || reimg.value == "") {
			alert("레시피 사진을 첨부해주세요");
			reimg.focus();
			reimg.select();
			return false;
		}
		if (rename.value == null || rename.value == ""){
			alert("레시피 이름을 입력해주세요");
			rename.focus();
			rename.select();
			return false;
		}
		if (redes.value == null || redes.value == "") {
			alert("레시피 한줄 설명을 입력해주세요");
			redes.focus();
			redes.select();
			return false;
		}
		if (catesel.value == null || catesel.value == "") {
			alert("카테고리를 선택해 주세요");
			catesel.focus();
			catesel.select();
			return false;
		}
		if (f_name.length < 2){
			alert("상품을 추가해주세요");
			f_name.focus();
			f_name.select();
			return false;
		}
		if (retip.value == null || retip.value == ""){
			alert("레시피 설명을 입력해주세요");
			retip.focus();
			retip.select();
			return false;
		}
		else if (retip.value.length < 10) {
			alert("레시피 설명을 10자 이상 입력해주세요");
			retip.focus();
			retip.select();
			return false;
		}
		
		document.addrecipeForm.submit();
	}
	function chgprice(obj) {
		var id = obj.id;
		var foodprice = document.getElementById('f_price_'+id).value;
		var foodunit = obj.value;
		document.getElementById('f_unit_'+id).value = foodunit;
		var sumvalue = document.getElementById('suminput').value;
		document.getElementById('ft_price_'+id).innerHTML = (Number(foodprice)* Number(foodunit)) + " 원";
		
		const setunit = document.getElementsByClassName('f_unit_in');
		const setprice = document.getElementsByClassName('f_price_in');
		var total = 0;
		for (let i = 1; i < setprice.length; i++) {
			total = Number(total) + (Number(setprice[i].value) * Number(setunit[i].value));
		}
		
		document.getElementById('f_sum').innerHTML = total + " 원";
	}
	
	var reader = new FileReader();
	function addimg(input) {
		if (input.files && input.files[0]) {
		   	document.getElementById('preview').style.display = "block";
		    reader.onload = function(e) {
		    	document.getElementById('preview').src = e.target.result;
		    };
		    	reader.readAsDataURL(input.files[0]);
		  	} else {
			document.getElementById('preview').src = "";
		}
	}
	
	function food_search() {
		var popupwidth = 800;
		var popupheight = 500;
		var popx = (window.screen.width / 2) - (popupwidth / 2);
		var popy = (window.screen.height / 2) - (popupheight / 2);
		window.open("foodsearch.re?search="+document.getElementById('foodsearch').value ,"searchPop","status=no, width="+popupwidth+", height="+popupheight+",left="+popx+",top="+popy);
	}
	
	function remove_input(obj) {
		document.getElementById('field').removeChild(obj.parentNode.parentNode);
		const setunit = document.getElementsByClassName('f_unit_in');
		const setprice = document.getElementsByClassName('f_price_in');
		var total = 0;
		for (let i = 1; i < setprice.length; i++) {
			total = Number(total) + (Number(setprice[i].value) * Number(setunit[i].value));
		}
		
		document.getElementById('f_sum').innerHTML = total + " 원";
	}
</script>
</html>
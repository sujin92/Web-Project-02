<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if (request.getParameter("idchk") != null){ 
		int idchk = Integer.valueOf(request.getParameter("idchk"));
		if (idchk == 1) {
%>
		<script type="text/javascript">
				opener.document.getElementById('idfaile').style.display = "block";
				opener.document.getElementById('idsuccess').style.display = "none";
				opener.document.getElementById('idans').style.display = "none";
				window.close();
		</script>
<%
		}
		else if (idchk == 0){
%>
		<script type="text/javascript">
			var id = opener.document.getElementById('id');
			if (!(id.value.length < 8)) { 
				opener.document.getElementById('idfaile').style.display = "none";
				opener.document.getElementById('idsuccess').style.display = "block";
				opener.document.getElementById('idans').style.display = "none";
				opener.document.getElementById('idchkbtn').disabled = true;
				opener.document.getElementById('id').readOnly = true;
				opener.document.getElementById('idchkbul').value = true;
				window.close();
			}
			else {
				opener.document.getElementById('idfaile').style.display = "none";
				opener.document.getElementById('idsuccess').style.display = "none";
				opener.document.getElementById('idans').style.display = "block";
				window.close();
			}
		</script>
<%
		}
		else if (idchk == -1) {
%>
		<script type="text/javascript">
			opener.document.getElementById('idfaile').style.display = "none";
			opener.document.getElementById('idsuccess').style.display = "none";
			opener.document.getElementById('idans').style.display = "block";
			window.close();
		</script>
<%
		}
	}
	else if (request.getParameter("emailchk") != null) {
		int emailchk = Integer.valueOf(request.getParameter("emailchk"));
			if (emailchk == 1) {
	%>
			<script type="text/javascript">
					opener.document.getElementById('emailfaile').style.display = "block";
					opener.document.getElementById('emailsuccess').style.display = "none";
					opener.document.getElementById('emailans').style.display = "none";
					window.close();
			</script>
	<%
			}
			else if (emailchk == 0){
	%>
			<script type="text/javascript">
				var email = opener.document.getElementById('mail');
				if (check(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/, email)) { 
					opener.document.getElementById('emailfaile').style.display = "none";
					opener.document.getElementById('emailsuccess').style.display = "block";
					opener.document.getElementById('emailans').style.display = "none";
					opener.document.getElementById('emailchkbtn').disabled = true;
					opener.document.getElementById('mail').readOnly = true;
					opener.document.getElementById('emailchkbul').value = true;
					window.close();
				}
				else {
					opener.document.getElementById('emailfaile').style.display = "none";
					opener.document.getElementById('emailsuccess').style.display = "none";
					opener.document.getElementById('emailans').style.display = "block";
					window.close();
				}
				function check(regExp, e) {
				    if (regExp.test(e.value)) {
				        return true;
				    }
				}
			</script>
	<%
			}
			else if (emailchk == -1) {
	%>
			<script type="text/javascript">
				opener.document.getElementById('emailfaile').style.display = "none";
				opener.document.getElementById('emailsuccess').style.display = "none";
				opener.document.getElementById('emailans').style.display = "block";
				window.close();
			</script>
	<%
			}
	}
	else if(request.getParameter("sellnumchk") != null) {
		int sellnumchk = Integer.valueOf(request.getParameter("sellnumchk"));
			if (sellnumchk == 1) {
	%>
				<script type="text/javascript">
						opener.document.getElementById('sellnumfaile').style.display = "block";
						opener.document.getElementById('sellnumsuccess').style.display = "none";
						window.close();
				</script>
	<%
			}
			else if (sellnumchk == 0){
	%>
				<script type="text/javascript">

					opener.document.getElementById('sellnumfaile').style.display = "none";
					opener.document.getElementById('sellnumsuccess').style.display = "block";
					opener.document.getElementById('sellnumchkbtn').disabled = true;
					opener.document.getElementById('number').readOnly = true;
					opener.document.getElementById('sellnumchkbul').value = true;
					window.close();
			</script>
	<%
			}
			else if (sellnumchk == -1) {
	%>
				<script type="text/javascript">
					opener.document.getElementById('sellnumfaile').style.display = "none";
					opener.document.getElementById('sellnumsuccess').style.display = "none";
					window.close();
				</script>
	<%
		}
	}
	%>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% String AuthenticationKey = (String)request.getAttribute("AuthenticationKey");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Email</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div>
		<h2>이메일 전송이 완료되었습니다.</h2>
		<input type="text" id="check_key" placeholder="인증번호 입력">
		<button type="button" onclick="fn_check();">인증</button>
	</div>
	
	<script>
		const fn_check=()=>{
			const AuthenticationKey='<%=AuthenticationKey%>';
			const check_key=$("#check_key").val();
			if(AuthenticationKey!=check_key){
				alert("인증번호가 일치하지 않습니다.");
			}else{
				alert("인증되었습니다.");
				opener.memberEnrollFrm.check_email.value=AuthenticationKey;
				close();
			}
		}
	</script>
</body>
</html>
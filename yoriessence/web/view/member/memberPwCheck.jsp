<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/view/common/header.jsp"%>
<%
	Member m = (Member)request.getAttribute("member");
%>
<section>
	<div id="update_div">
		<h1>회원정보수정</h1><br>
		<p>개인정보 보호를 위해 비밀번호를 재확인 합니다.</p><br>
		<form action="" method="post" onsubmit="fn_pwck_validate();">
			비밀번호 <input type="password" id="up_pw" class="up_pw">
			<button type="submit">확인</button>
		</form>
	</div>
	<script>
		const fn_pwck_validate=()=>{
			const uppw=$("#up_pw").val();
			const pw=<%=m.getPassword()%>;
			console.log("1");
			console.log(uppw);
			console.log("2");
			console.log(pw)
			if(uppw !=null && uppw != pw){
				alert("비밀번호가 일치하지 않습니다.");
				userId.focus();				
				return false;
			}
		}
	</script>
</section>
<style>
#update_div{
	margin-left: 705px;
	width:500px;
	height:300px;
	border:1px red solid;
	text-align:center;
}
p{
	margin-top:10px;
}
div>h1{
	margin-top:40px;
	font-size:50px;
}
#up_pw{
	width: 200px;
	height: 30px;
	border: solid 1px #dadada;
}
form{
	margin-top:50px;
	display:inline-block;
}
button{
	width: 50px;
	height: 30px;
}
</style>
<%@ include file="/view/common/footer.jsp"%>
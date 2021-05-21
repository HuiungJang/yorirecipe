<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/view/common/header.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link  type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/view/common/css/Enrollstyle.css" />
    <div class="bodyall">
        <div class="joinPhrase">
            <h1>회원가입</h1>
            <br>
            <p>정보를 정확하게 입력해주세요.</p>
        </div>
        <br>
        <hr style="border: 1px red solid;">
        <div class="infoinput">
        	<div style="margin-bottom:20px">
            	<h4>필수정보입력</h4>
        	</div>
            <form name="memberEnrollFrm" action="<%=request.getContextPath()%>/member/memberEnrollEnd" method="post" onsubmit="return fn_enroll_validate();">
                <!--Id-->
                <div >
                    <div>
                        <h3 class="join_title">
                            <label for="id">아이디</label>
                        </h3>
                     </div>
                    <div class="div_input_id">
                        <input type="text" id="userId" name="userId" class="int_id" maxlength="20" placeholder="5글자이상">
                        <button type="button" class="div_input_id_button"  onclick="fn_id_duplicate();">중복확인</button>
                    </div>
                    <span class="error_next_box"></span>
                </div>
        
                <!--PW-->
                <div>
                    <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
                    <span class="box int_pass">
                        <input type="password" id="pswd1" name="userPw" class="int" maxlength="20">
                        <span id="alertTxt">사용불가</span>
                        <img src="jpg/m_icon_check_disable.png" id="pswd1_img1" class="pswdImg">
                    </span>
                    <span class="error_next_box"></span>
                </div>
        
                <!-- PW2 -->
                <div>
                     <h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
                    <span class="box int_pass_check">
                        <input type="password" id="pswd2" name="userPwck" class="int" maxlength="20">
                        <img src="jpg/m_icon_pass.png" id="pswd2_img1" class="pswdImg">
                    </span>
                    <span class="error_next_box"></span>
                </div>
        
                <!-- NAME -->
                <div>
                     <h3 class="join_title"><label for="name">이름</label></h3>
                    <span class="box int_name">
                        <input type="text" id="name" name="userName" class="int" maxlength="20">
                    </span>
                    <span class="error_next_box"></span>
                </div>
        
                <!-- NiCKNAME -->
                <div>
                    <h3 class="join_title"><label for="nickname">닉네임</label></h3>
                    <span class="box int_name">
                        <input type="text" id="nickname" name="userNick" class="int" maxlength="20">
                    </span>
                    <span class="error_next_box"></span>
                </div>
        
                <!-- EAMIL -->
                <div>
                    <h3 class="join_title"><label for="nickname">이메일</label></h3>
                    <div class="div_input_email">
                        <input type="email" id="email" name="email"  class="email" maxlength="20" placeholder="example@naver.com">
                        <button type="button" class="div_input_email_button"onclick="send_email();">이메일 인증</button>
                    </div>
                    <div class="div_input_email" style="margin-top: 10px;">
                        <input type="text" id="check_email" class="email" placeholder="인증번호" disabled>
                    </div>
                    <span class="error_next_box"></span>
                </div>
        
                <!-- POHNE -->
                <div>
                    <h3 class="join_title"><label for="nickname">휴대전화</label></h3>
                    <span class="box int_name">
                        <input type="text" id="phone" name="phone" class="int" maxlength="20" placeholder="-를 제외해주세요. 예)01012345678">
                    </span>
                    <span class="error_next_box"></span>
                </div>
        
                 <!-- ADDRESS -->
                <div>
                    <h3 class="join_title"><label for="nickname">주소</label></h3>
                     <div class="div_input_address">
                        <input type="text" id="mainaddress" name="address" class="address" maxlength="20" placeholder="우편번호 / 주소">
                        <button type="button" onclick="findAddr();" class="div_input_addr_button">우편번호 찾기</button>
                    </div>
                    <div class="div_input_address" style="margin-top: 10px;">
                        <input type="text" id="subaddress" class="address" maxlength="20" placeholder="상세주소">
                    </div>
                    <span class="error_next_box"></span>
                </div>
                <br>
	            <hr style="border: 1px red solid;">
	            <br>
	            <div class="joinCheck">
	                 <input type="checkbox"> 개인정보
	                <br>
	                <input type="submit" value="가입하기">
	            </div>
	       </form>
          </div>
    </div>
    <form action="" name="checkDuplicateId">
    	<input type="hidden" name="userId">
    </form>
    <form action="" name="sendEmailform">
    	<input type="hidden" name="email">
    </form>
<script>
	//비밀번호 값 일치 check
	$(function(){
		$("#pswd2").blur((e)=>{
			const pwck=$(e.target).val();
			const pw=$("#pswd1").val();
			if(pwck!=pw){
				alert("패스워드가 일치하지 않습니다.");
				$("#pswd1").focus();
			}
		});
	});
	//아이디 4글자 이상 else 전송X
	const fn_enroll_validate=()=>{
		const userId=$("#userId").val();
		console.log(userId);
		if(userId.length<4){
			alert("아이디는 최소 5자리 이상이여야 합니다.");
			userId.focus();				
			return false;
		}
		const check_email=$("#check_email").val();
		 if(check_email==""){
			alert("이메일 인증이 필요합니다.");
			return false;
		}
		
	}

	//중복검사
	const fn_id_duplicate=()=>{
		const url = "<%=request.getContextPath()%>/checkDuplicateId";
		const title = "checkDuplicateId";
		const status = "left=500px, top=100px, width=300px, height=200px";
		open("",title,status);
		checkDuplicateId.userId.value=$("#userId").val();
		checkDuplicateId.method="post";
		checkDuplicateId.action=url;
		checkDuplicateId.target=title;
		checkDuplicateId.submit();
	}
	//이메일보내기
	const send_email=()=>{
		const url = "<%=request.getContextPath()%>/member/email";
		const title = "EnrollEmail";
		const status = "left=500px, top=100px, width=300px, height=200px";
		open("",title,status);
		sendEmailform.email.value=$("#email").val();
		sendEmailform.method="post";
		sendEmailform.action=url;
		sendEmailform.target=title;
		sendEmailform.submit();
	}
	//우편주소
    function findAddr(){
        new daum.Postcode({
            oncomplete: function(data) {
            	var addr="";
            	//지번인지 도로명인지 분기처리
            	if(data.userSelectedType =='R'){ //도로명 선택
            		addr=data.roadAddress;
            	}else{ //지번선택
            		addr=data.jibunAddress;
            	}
           		document.getElementById('mainaddress').value = addr;
           		document.getElementById('subaddress').focus();
            }
        }).open();
    }

</script>
<%@ include file="/view/common/footer.jsp"%>
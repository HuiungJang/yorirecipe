<%--
  Created by IntelliJ IDEA.
  User: jang
  Date: 2021/04/29
  Time: 11:31 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yoriessence.member.vo.Member" %>
<%
Member loginMember=(Member)session.getAttribute("loginMember");
	Cookie[] cookies=request.getCookies();
	String saveId=null;
	if(cookies!=null){
		for(Cookie c : cookies){
	if(c.getName().equals("saveId")){
		saveId=c.getValue();
		break;
	}
		}
	}
%>

<html lang="ko">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>요리레시피</title>
    <script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <meta name ="google-signin-client_id" content="393793381722-emq1t5c5as3afleds82jf0u633h15l39.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
    <link  type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/view/common/css/common.css" />
</head>
<body>
<header>
    <div id="header_div">
        <div class="logo_div">
            <a href="">
                    <span><img id="mainlogo" src="" width="100px" height="100px"></span>
            </a>
        </div>
        <div class="menu_div">
            <ul>
                <li><a class="underline" href="<%=request.getContextPath()%>/rankchef.do">셰프랭킹</a></li>
                <li><a class="underline" href="">추천식단</a></li>
                <li><a class="underline" href="">레시피</a></li>
            </ul>
        </div>
        <div class="submenu_div">
                <div id="dropdown">
			        <ul id="dropdown_ul">
			        	<li style="float:left"><a href="#"><img src="" width="55px" height="55px"></a>
			        	<li style="float:left"><a href="#"><img src="" width="55px" height="55px"></a>
		                <li style="float:left">
			        	<%if(loginMember==null){ %>
		                <a href="#none" class="LoginTriger"><img style="width: 55px; height: 55px;"src="" alt=""></a>
		                <%}else{ %>
			            <a><img src="" width="55px" height="55px"></a>
			                <ul id="dropdown_ul2">
			                    <li><a href="<%=request.getContextPath()%>/searchchef.do?chefsearch=<%=loginMember.getUserId()%>">프로필</a></li>
			                    <li><a href="<%=request.getContextPath()%>/member/memberPwCheck?userId=<%=loginMember.getUserId()%>">회원정보수정</a></li>
			                    <li><a href="#">나의레시피</a></li>
			                    <li><a href="#">주문정보</a></li>
			                    <li><a href="#">나의포인트</a></li>
			                    <li><a href="#">고객센터</a></li>
			                    <li><a href="<%=request.getContextPath()%>/member/logout.do">로그아웃</a></li>
			                </ul>
			            <%} %>
		                </li>
			        </ul>               
            	</div>
        </div>
    </div>
    
<div class="popup">
        <div class="popup-content-container">
            <span class="close-button">x</span> 
            <h1 class="loginfont">L O G I N</h1>
            <form name="formLogin" action="<%=request.getContextPath()%>/member/login.do" method="POST" class="loginform">
                <div class="input-container">
                    <input type="text" name="userId" id="login_id" class="input-default" placeholder="아이디" title="아이디 입력">
                </div>
                <div class="alert-container">
                    <span id="loginAlertId" class="alert-text hidden">
                        <span class="icon-close">
                            ::before
                            ::after
                        </span>
                        "아이디 또는 이메일 주소를 입력해주세요."
                    </span>
                </div>
                <div class="input-container">
                    <input type="password" name="userPwd" id="login_password" class="input-default" placeholder="비밀번호" title="비밀번호 입력">
                </div>
                <div class="alert-container inline-block">
                    <span id="loginAlertPassword" class="alert-text hidden">...</span>
                </div>
                <div class="SearchIdPwSpan">
                    <span>
                        <a href="">아이디 찾기</a>
                        <span>/</span>
                        <a href="">비밀번호 찾기</a>
                    </span>
                </div>
	            <div class="IdCheck">
	                <span>
	                    <input type="checkbox">
	                    <label for="">아이디 저장</label>
	                </span>
	            </div>
	            <div class="loginbutton">
	                <button>L O G I N</button>
	            </div>
            </form>
            <div>
                <div style="margin-top: 40px;">
                    <hr>
                </div>
                <div class="kakaoface">
                    <div class="kakaologinbtn">
                        <a id="kakao-login-btn"></a>
                        <a href="http://developers.kakao.com/logout"></a>
                    </div>
                    <div class="googlelogin">
                       <div class="g-signin2" data-onsuccess="onSignIn" style="width:225px; height:50px;" ></div>
                    </div>
                </div>
                <div class="join">
                    <a href="<%=request.getContextPath()%>/member/memberEnroll">회원가입</a>
                </div>
            </div>
        </div>
</div>

    <script>
    	const Login_Popup=()=>{
    		const url ="<%=request.getContextPath()%>/loginpopup";
    		const status= "left=1000px , top= 500px, width=800px, height=500px"
    		
    		open(url,"_blank",status);
    	}
 
        var model = document.querySelector(".popup");
        var trigger = document.querySelector(".LoginTriger");
        var closeButton = document.querySelector(".close-button"); 
        // console.log(model);
        function toggleModel(){
            model.classList.toggle("show-model");
        }
        function windowOnClick(event){
            if(event.target === model) {
                toggleModel();
            }
        }
        
        trigger.addEventListener("click",toggleModel);
        closeButton.addEventListener("click", toggleModel); 
        window.addEventListener("click", windowOnClick); 
        
        
        
        // 카카오 로그인
        Kakao.init('9821b1adf6591b5708f7ee0615e8458b');
        Kakao.Auth.createLoginButton({
            container: '#kakao-login-btn',
            success: function (authObj) {
                alert(JSON.stringify(authObj));
            },
            fail: function (err) {
                alert(JSON.stringify(err));
            }
        });
        
      //구글 테스트
        function init() {
        	gapi.load('auth2', function() {
        		gapi.auth2.init();
        		options = new gapi.auth2.SigninOptionsBuilder();
        		options.setPrompt('select_account');
                // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
        		options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
                // 인스턴스의 함수 호출 - element에 로그인 기능 추가
                // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
        		gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
        	})
        }

        function onSignIn(googleUser) {
        	var access_token = googleUser.getAuthResponse().access_token
        	$.ajax({
            	// people api를 이용하여 프로필 및 생년월일에 대한 선택동의후 가져온다.
        		url: 'https://people.googleapis.com/v1/people/me'
                // key에 자신의 API 키를 넣습니다.
        		, data: {personFields:'birthdays', key:'AIzaSyByMI_fY8EQyTZkJdCdRp8QlT6NDWXFr6g', 'access_token': access_token}
        		, method:'GET'
        	})
        	.done(function(e){
                //프로필을 가져온다.
        		var profile = googleUser.getBasicProfile();
        		console.log(profile)
        	})
        	.fail(function(e){
        		console.log(e);
        	})
        }
        function onSignInFailure(t){		
        	console.log(t);
        }
    </script>
</header>


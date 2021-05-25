<%@ page import="com.yoriessence.member.vo.Member" %><%--
  Created by IntelliJ IDEA.
  User: jang
  Date: 2021/05/25
  Time: 9:15 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<html>
<head>
    <title>요리에센스</title>
    <script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <meta name ="google-signin-client_id" content="393793381722-emq1t5c5as3afleds82jf0u633h15l39.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
    <link  type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/view/common/css/common.css" />
</head>
<script>
  // 가져와야할것.
  // 셰프 좋아요순 5명
  // 레시피 좋아요순 3개
  // 레시피 3개
  function mustStart() {
    $.ajax({
      url: '<%=request.getContextPath()%>/mainpage.do',
      success: data => {
        parseJSON.

        $(data).each((i,v)=>{
          console.log(v);

          console.log(data[i].v);
        })
      },
      error: (e, m, i) => {
        console.log(e);
        console.log(m);
        console.log(i);
      }
    });
  }
  mustStart();
</script>
<body>
<div id="totalContainer">
    <div class="header">
        <div class="logo">
            <a href="<%=request.getContextPath()%>/index.jsp">
                <img src="<%=request.getContextPath()%>/img/icon/mainlogo.png"
                     height="150px">
            </a>
        </div>
        <div class="menu">
                <span>
                    <a href="<%=request.getContextPath()%>/rankchef.do">셰프 랭킹</a>
                </span>
            <span>
                    <a href="<%=request.getContextPath()%>/bestrecipe.do">추천 레시피</a>
                </span>
            <span>
                    <a href="">레시피</a>
                </span>
        </div>
        <div class="controlIcon">
            <span id="managerPage">
                <button>관리자페이지</button>
            </span>
            <span>
                    <a href="">
                        <img src="<%=request.getContextPath()%>/img/icon/icon_search.png">
                    </a>
            </span>
            <span>
                <a href="">
                    <img src="<%=request.getContextPath()%>/img/icon/icon_cart.png">
                </a>
            </span>

            <%if(loginMember==null){ %>
                <span>
                    <a href="#none" class="LoginTriger">
                        <img src="<%=request.getContextPath()%>/img/icon/icon_login.png" alt="">
                    </a>
                </span>
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
        </div>

    </div>
    <script>
      // 로그인 로직 구현

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


      //웹소켓서버에 연결하기
      //WebSocket객체를 생성함
      const socket=new WebSocket("ws://localhost:9090/<%=request.getContextPath()%>/chatting");
      //http프로토콜로 통신하는 주소 ws:주소
      //https프로토콜이용 : wss:주소

      //socket설정
      //접속후 실행되는 이벤트 핸들러 등록
      socket.onopen=e=>{
        console.log("웹소켓서버에 접속 성공!");
        console.log(e);
      }
      //웹소켓서버에서 sendText, sendObject매소드를 실행하면 실행되는 함수
      socket.onmessage=e=>{
        console.log("메세지수신");
        //수신된데이터를 받으려면 이벤트객체의 data속성을 이용함
        console.log(e);
        console.log(e.data);
        //Object형태의 String 데이터를 객체로 변환해주기

        console.log(JSON.parse(e.data));
        const msg=JSON.parse(e.data);
        //let msg=e.data.split(",");
        //0 : 보낸사람
        //1 : 메세지
        if(msg["sender"]==$("#sender").val()){
          //$("#msgContainer").append($("<p>").text("<"+msg[0]+"> "+msg[2]).css("text-align","left"));
          $("#msgContainer").append($("<p>").text("<"+msg["sender"]+"> "+msg["msg"]).css("text-align","left"));
        }else{
          //$("#msgContainer").append($("<p>").text("<"+msg[0]+"> "+msg[2]).css("text-align","right"));
          $("#msgContainer").append($("<p>").text("<"+msg["sender"]+"> "+msg["msg"]).css("text-align","right"));
        }
        //메세지처리에 대한 로직을 여기에 구현을 함.

      }

      const sendMsg=()=>{
        //웹소켓서버에 메세지를 전송하는 함수
        //전송할 메세지 전처리
        //전처리한 메세지를 전송하는방법 : socket.send("데이터전송");
        //socket.send($("#sender").val()+","+$("#receiver").val()+","+$("#msg").val());
        msg=new Message($("#sender").val(),$("#receiver").val(),$("#msg").val());
        //javascript 객체를 스트링으로 변환해서 전송
        //JSON.stringify(object)함수를 이용
        socket.send(JSON.stringify(msg));
      }

      function Message(sender,reciver,msg){
        this.sender=sender;
        this.reciver=reciver;
        this.msg=msg;
      }

    </script>
    <%--        header 끝 section 시작--%>

<%--
  Created by IntelliJ IDEA.
  User: jang
  Date: 2021/04/29
  Time: 11:31 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-compatible" content="chrome=1,IE=edge">
    <title>요리레시피</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/view/common/library/jquery.3.6.0.js"></script>
    <link  type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/view/common/css/common.css" />
</head>
<body>
<header>
    <div>
        <a href="">
            <span><img id="mainlogo" src=""></span>
        </a>
    </div>
    <nav id="menu">
        <ul>
            <li><a class="underline" href="">KOREAN</a></li>
            <li><a class="underline" href="">WESTERN</a></li>
            <li><a class="underline" href="">CHINESE</a></li>
            <li><a class="underline" href="">JAPANESE</a></li>
            <li><a class="underline" href="">HEALTHY</a></li>
        </ul>
    </nav>
    <div id="submenu">
      <span id="searchicon">
        <a href=""><img style="width: 55px; height: 55px;" src="" alt=""></a>
      </span>
        <span id="loginicon">
        <a href="" ><img style="width: 55px; height: 55px;"src="" alt=""></a>
      </span>
        <span id="carticon">
        <a href="" ><img style="width: 60px; height: 60px;" src="" alt=""></a>
      </span>
    </div>
</header>


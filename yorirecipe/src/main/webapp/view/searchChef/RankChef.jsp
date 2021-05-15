<%@ page import="com.yorirecipe.model.vo.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: jang
  Date: 2021/05/08
  Time: 11:09 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../view/common/header.jsp"%>
<link  type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/view/searchChef/css/rankChef.css" />
<%
    List<User> chefInfo= (List<User>)request.getAttribute("chefInfo");
    HashMap<String,Integer> recommendCount = (HashMap<String, Integer>)request.getAttribute("recommend");
%>
<section>
<div id="rankContainer">
    <div id="rankSort">
        <span id="sortbutton">
            <form action="" method="get">
                <input type="button"  class="button" value="일간랭킹" name="daily">
                <input type="button"  class="button" value="주간랭킹" name="weekly">
                <input type="button"  class="button" value="월간랭킹" name="monthly">
            </form>
        </span>
        <span id="search">
            <form action="<%=request.getContextPath()%>/searchchef.do" method="get">
                <input type="search" class="searchChef" name="chefsearch" placeholder="셰프 이름을 입력해주세요">
                <button class="button">검색</button>
            </form>
        </span>
    </div>


    <div id="content">
        <%if(chefInfo != null){%>
            <%for(User u : chefInfo){%>
                <div class="rankImg">
                    <img src="스크린샷%202021-04-26%20오후%202.50.55.png" width="100px" height="150px">
            <%--        1,2,3등만 옆에 출력함 메달이미지? 트로피 이미지? --%>
                </div>
                <div class="list">
                    <div class="chef">
                        <img src="https://recipe1.ezmember.co.kr/cache/recipe/2020/08/18/32775e06923a4bef0cb6093ff84d28ef1.jpg" height="200px" width="200px">
                        <div class="chefInfo">
                            <p><%=u.getMemberName()%></p>
                            <span><button>DM 보내기</button></span>
                            <span><img src="스크린샷%202021-04-26%20오후%202.50.55.png" width="25px" height="25px"><%=recommendCount.get(u.getMemberId())%></span>
            <%--                좋아요 이미지 넣을 예정--%>
                        </div>
                    </div>
                </div>
            <%}%>
        <%}%>
    </div>


</div>
</section>
<%@ include file="../../view/common/footer.jsp"%>
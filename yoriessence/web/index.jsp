<%--
  Created by IntelliJ IDEA.
  User: jang
  Date: 2021/04/29
  Time: 11:31 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="view/common/header.jsp"%>
<%--        header 끝 section 시작--%>
<div class="main-content">
    <div id ="banner">
        <img src="<%=request.getContextPath()%>/img/mainImg/banner.png"
             width="1500px" height="300px">
    </div>


    <div id="recommend_recipe">
        <div class="recipe_icon">
            <img src="<%=request.getContextPath()%>/img/mainImg/recipe_icon.png" width="250px">
        </div>
        <div class="recipeData">
            <a href="">
                <img src="<%=request.getContextPath()%>/img/icon/non_profile.png"
                     width="200px" height="200px">
            </a><br>
            <div>
                <span class="recipeTitle">123</span><br>
                <span class="recipeInfo">123</span><br>
            </div>
        </div>
    </div>


    <div id="topChef">
        <span>셰프 TOP 5</span>
        <br><br>
        <div class="chefData">
            <a href="">
                <img src="<%=request.getContextPath()%>/img/icon/non_profile.png"
                     width="290px" height="290px">
            </a>
            <div>
                <span class="chefName">123</span><br>
                <span class="chefNick">123</span><br>
                <span>
                            <button>
                                DM 보내기
                            </button>
                        </span>
            </div>
        </div>
    </div>


    <div id="recipe">
        <div class="recipeData">
            <a href="">
                <img src="<%=request.getContextPath()%>/img/icon/non_profile.png"
                     width="450px" height="290px">
            </a>
            <div>
                <span class="recipeTitle">김치찌개~~~~</span><br>
                <span class="recipeInfo">이거는 설명인데 길어도 되는지 모르겠어요</span><br>
            </div>
        </div>
    </div>
</div>
<%--        section 끝 footer 시작--%>
<%@ include file="view/common/footer.jsp"%>

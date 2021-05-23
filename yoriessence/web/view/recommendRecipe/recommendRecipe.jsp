<%@ page import="com.yoriessence.recipe.model.vo.Recipe" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: jang
  Date: 2021/05/22
  Time: 10:00 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/view/common/header.jsp"%>
<%
    List<Recipe> todayRecipe = (List<Recipe>)request.getAttribute("todayRecipe");
    List<Recipe> periodRecipe=(List<Recipe>)request.getAttribute("periodRecipe");
    List<Integer> countRecipeLike = (List<Integer>)request.getAttribute("countRecipeLike");
    List<Integer> countRecipeComment = (List<Integer>)request.getAttribute("countRecipeComment");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/view/recommendRecipe/css/recommend.css">
<script>
const sortday1 = 2;
const sortday2 = 1;

  $(function(){
    $(".recommendButton button").click((e)=>{
      $.ajax({
        url:"<%=request.getContextPath()%>/bestrecipe.do?",
        data:{
          "sortday1":sortday1+1,
          "sortday2":sortday2+1
        },
        success:data=>{
          console.log("어제로 바뀜");
        }
      });

      console.log(sortday1 +': sortday1' , sortday2 +': sortday2');
    });

    $("#best_recipe_sort a").click((e)=>{
        const val = $(e.target).text();

        $.ajax({
          url:'<%=request.getContextPath()%>/bestrecipe.do',
          data:{
            "sortVal":val
          },
          success:data=>{
            console.log("정렬성공");
          }
        });
    });

  });
</script>
<section>
    <div id="prev_recipe_button">
        <div class="recommendButton">
            <button  style="border-radius: 10px; width: 50px; height: 35px; cursor: pointer">
                <
            </button>

            <span class="tooltip">
                    <p>어제 추천 메뉴를 보려면 클릭!</p>
            </span>
        </div>
        <div class="recommend_recipe_title">
            <span>오늘의 추천 메뉴</span>
        </div>
    </div>
    <div id="today_recommend_recipe_list">
        <%if(todayRecipe != null){%>
            <%for(Recipe r : todayRecipe){%>
                <div class="today_recommend_recipe">
                    <a href=""><img src="<%=r.getRepresentPicture()%>" height="200px" width="200px"></a>
                    <div class="today_recipe_info">
                        <a href=""><h2><%=r.getRecipeTitle()%></h2></a>
                        <span><%=r.getMemberId()%></span><span><%=r.getRecipeViewCount()%></span>
                    </div>
                </div>
            <%}%>
        <%}%>
    </div>
    <div id="best_recipe_title_container" class="title_container_grid">
        <div id="best_recipe_title">
            <span> 베스트 레시피 </span>
        </div>
        <div id="best_recipe_sort">
            <a>주간</a>
            |
            <a>월간</a>
            |
            <a>전체</a>
        </div>
    </div>
    <div id="recipe_list" class="grid">
        <%if(periodRecipe != null){%>
            <%for(int i=0; i<countRecipeLike.size(); i++){%>
                <div class="recipe">
                    <a href=""><img src="<%=periodRecipe.get(i).getRepresentPicture()%>" height="200px" width="200px"></a>
                    <div class="recipe_info">
                        <a href=""><span><%=periodRecipe.get(i).getRecipeTitle()%></span></a><br>
                        <span><%=periodRecipe.get(i).getMemberId()%></span><br>
                        <span>좋아요 <%=countRecipeLike.get(i)%> </span>
                        <%try{%>
                            <span> 댓글 <%=countRecipeComment.get(i)%> </span>
                        <%}catch (IndexOutOfBoundsException e){%>
                            <span> 0</span>
                        <%}%>
                        <span> 조회수 <%=periodRecipe.get(i).getRecipeViewCount()%></span>
                    </div>
                </div>
            <%}%>
        <%}%>
    </div>
    <div id="pageBar">
        <%=request.getAttribute("pageBar")%>
    </div>
</section>
<%@ include file="/view/common/footer.jsp"%>

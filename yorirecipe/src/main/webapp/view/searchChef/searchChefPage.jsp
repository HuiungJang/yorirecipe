<%@ page import="java.util.List" %>
<%@ page import="com.yoriessence.chef.model.vo.Profile" %>
<%@ page import="com.yoriessence.recipe.model.vo.Recipe" %>
<%@ page import="com.yoriessence.chef.model.vo.User" %><%--
  Created by IntelliJ IDEA.
  User: jang
  Date: 2021/05/08
  Time: 12:17 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/view/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/view/searchChef/css/searchChefPage.css">
<%
    List<Profile> chefProfile = (List<Profile>)request.getAttribute("chefProfile");
    List<Recipe> chefRecipe = (List<Recipe>)request.getAttribute("recipe");
    List<Integer> countComment = (List<Integer>)request.getAttribute("countComment");
    List<Integer> recipeRecommends  = (List<Integer>)request.getAttribute("recipeRecommends");
    User userInfo = (User)request.getAttribute("userInfo");
%>
<section>
    <div id="chef_Profile">
        <div class="chefContainer">
            <%if(chefProfile != null){%>
                <span id="picContainer">
                    <img src="<%=chefProfile.get(0).getProfilePic()%>" height="200px" width="200px" style="border-radius: 200px">
                    <br><input type="button" id="sendDM" value="DM 보내기">
                </span>
                <img class="recommendStar" src="<%=request.getContextPath()%>/img/icon/recommend_unclick.png" width="35px" height="35px">
                <span id="chef_content">
                    <img src="<%=request.getContextPath()%>/img/icon/chef_cefti.png" width="50px" height="50px">
                    <span id="chefTitle"><%=chefProfile.get(0).getProfileName()%></span>
                    <br><br><br>
                    <span class="text">
                        <p><a><%=chefProfile.get(0).getSelfIntro()%></a></p>
                        <br>
                        <span><a href="http://www.<%=chefProfile.get(0).getProfileSnsUrl1()%>"><img id="snsIcon1" src=""></a></span>
                        <span><a href="http://www.<%=chefProfile.get(0).getProfileSnsUrl2()%>"><img id="snsIcon2" src=""></a></span>
                    </span>
                </span>
            <%}%>
        </div>
    </div>
    <nav id="sort">
        <a>최신순</a>
        |
        <a>추천순</a>
        |
        <a>조회순</a>
    </nav>
    <div id="recipe_list" class="grid">

<%--        <div id="select_order">--%>
<%--            <a>추천순</a>--%>
<%--            <a>최신순</a>--%>
<%--        </div>--%>
    <% if(chefRecipe != null){%>
        <% for(int i=0; i<chefRecipe.size(); i++){%>
            <div class="recipe">
                <%if(chefRecipe.get(i).getRepresentPicture() != null){%>
                    <a href=""><img src="<%=chefRecipe.get(i).getRepresentPicture()%>" height="200px" width="200px"></a>
<%--                글 내용으로--%>
                <%}else{%>
                    <a href=""><img src="" height="200px" width="200px"></a>
<%--                글 내용으로--%>
                <%}%>
                <div class="recipe_info">
                    <p><a href=""><%=chefRecipe.get(i).getRecipeTitle()%></a></p>
<%--                    글 내용으로--%>
                    <p><a href=""><%=chefRecipe.get(i).getMemberId()%></a></p>
<%--                    프로필로--%>
                    <span>좋아요
                    <%try{%>
                        <%=recipeRecommends.get(i)%>
                    <%}catch (IndexOutOfBoundsException e){%>
                        0
                    <%}%>
                    </span>

                    <span> 댓글
                    <%try{%>
                        <%=countComment.get(i)%>
                    <%}catch (IndexOutOfBoundsException e){%>
                        0
                    <%}%>
                    </span>

                    <span>조회수 <%=chefRecipe.get(i).getRecipeViewCount()%></span>
                </div>
            </div>
        <%}%>
    <%}%>
    </div>


</section>
<script>
  function inputSNSIcon() {
    const path = "<%=request.getContextPath()%>/img/icon/icon_";
    const snsIcon1 = $("#snsIcon1");
    const snsIcon2 = $("#snsIcon2");

    if(snsIcon1.parent().attr("href").includes("instagram")){
      snsIcon1.attr("src",path+"insta.png");
    }else if(snsIcon1.parent().attr("href").includes("youtube")){
      snsIcon1.attr("src",path+"youtube.png");
    }else if(snsIcon1.parent().attr("href").includes("facebook")){
      snsIcon1.attr("src",path+"facebook.png");
    }else{
      snsIcon1.css("display","none");
    }

    if(snsIcon2.parent().attr("href").includes("instagram")){
      snsIcon2.attr("src",path+"insta.png");
    }else if(snsIcon2.parent().attr("href").includes("youtube")){
      snsIcon2.attr("src",path+"youtube.png");
    }else if(snsIcon2.parent().attr("href").includes("facebook")){
      snsIcon2.attr("src",path+"facebook.png");
    }else{
      snsIcon2.css("display","none");
    }
  }

  $(".recommendStar").click((e)=>{
    $.ajax({
      url:"<%=request.getContextPath()%>/recommendChef.do",
      data:{
        "chefId":"<%=chefProfile.get(0).getMemberId()%>",
        "recommendYN":recommendChef()
      },
      success:data=>{
        console.log("성공");
      }
    });

  });



  function recommendChef(){
    if($(".recommendStar").attr("src").includes("un")){

      if(confirm("추천하시겠습니까?")){
        // 회원만 추천가능하도록 하자
        // 로그인 했는지 확인하는거 추가해야함
        $(".recommendStar").attr({
          src:"<%=request.getContextPath()%>/img/icon/recommend_click.png",
        });
        return 1;
        // 추천함
      }

    }else{
      if(confirm("추천을 취소하시겠습니까?")){
        $(".recommendStar").attr({
          src:"<%=request.getContextPath()%>/img/icon/recommend_unclick.png",
        });
      }
      // 추천 안함
      return 0;
    }
  }

  $("#sort a").click((e)=>{
   const sortVal = $(e.target).text();
   console.log(sortVal);

   $.ajax({
     url: "<%=request.getContextPath()%>/searchchef.do",
     data:{
       "chefId":"<%=chefProfile.get(0).getMemberId()%>",
       "sortVal":sortVal,
       "chefsearch":"<%=chefProfile.get(0).getMemberId()%>"
     },
     type:"get",
     success:data=>{
        console.log("정렬성공");
     },
   })

  });


  function chefCertifiedImg(){
    if(<%= !(userInfo.getMemberGrade().equals("cf")) %>){
      $("#chef_content>img").css("display","none");
    }
  }

  chefCertifiedImg();
  inputSNSIcon();
</script>
<%@ include file="/view/common/footer.jsp"%>

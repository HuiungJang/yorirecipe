<%@ page import="com.yoriessence.chef.model.vo.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.yoriessence.chef.model.vo.Profile" %><%--
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
    List<Profile> chefProfileAll =(List<Profile>)request.getAttribute("chefProfileAll");
%>
<section>
<div id="rankContainer">
    <div id="rankSort">
        <span id="sortbutton">
            <form id="sortForm" action="" method="get">
                <input type="button"  class="button" value="일간랭킹" name="daily">
                <input type="button"  class="button" value="주간랭킹" name="weekly">
                <input type="button"  class="button" value="월간랭킹" name="monthly">
            </form>
        </span>
        <span id="search">
            <form action="<%=request.getContextPath()%>/searchchef.do" method="get">
                <input type="search" class="searchChef" name="chefsearch" placeholder="셰프 닉네임을 입력해주세요">
                <button class="button">검색</button>
            </form>
        </span>
    </div>


    <div id="content">
        <%if(chefInfo != null){%>
            <%for(int i =0; i< chefInfo.size(); i++){%>
                <div class="rankImg">
                    <%if( i==0){%>
                     <span><img class="trophy" src="<%=request.getContextPath()%>/img/icon/chef_1st.png" width="100px" height="150px"></span>

                    <%}else if(i==1){%>
                     <span><img class="trophy" src="<%=request.getContextPath()%>/img/icon/chef_2nd.png" width="100px" height="150px"></span>

                    <%}else if(i==2){%>
                     <span><img class="trophy" src="<%=request.getContextPath()%>/img/icon/chef_3rd.png" width="100px" height="150px"></span>

                    <%}else{%>
                     <span ><img class="normal" src="<%=request.getContextPath()%>/img/icon/normal_user.png" width="100px" height="150px"></span>
                    <%}%>
                </div>
                <div class="list">
                    <div class="chef">
                        <a href="<%=request.getContextPath()%>/searchchef.do?chefsearch=<%=chefInfo.get(i).getMemberNickName()%>">

                            <% if(chefProfileAll.get(i).getProfilePic() != null
                                    && chefInfo.get(i).getMemberId().equals(chefProfileAll.get(i).getMemberId())) {%>
                                <img src="<%=request.getContextPath()%>/upload/profile/<%=chefProfileAll.get(i).getProfilePic()%>"
                                     class="moveProfile" height="200px" width="200px" style="border-radius: 200px; border: #0A1329 1px solid">
                            <%}else{%>
                                <img src="<%=request.getContextPath()%>/img/icon/non_profile.png" class="moveProfile" height="200px" width="200px" style="border-radius: 200px">
                            <%}%>

                        </a>
                        <div class="chefInfo">
                            <a href="<%=request.getContextPath()%>/searchchef.do?chefsearch=<%=chefInfo.get(i).getMemberNickName()%>">
                                <p class="moveProfile">
                                    <%=chefInfo.get(i).getMemberName()%>
                                </p>
                            </a>
                            <span><button>DM 보내기</button></span>
                            <span><img src="<%=request.getContextPath()%>/img/icon/recommend_click.png" width="25px" height="25px"> <%=chefInfo.get(i).getRecommendCount()%></span>
                        </div>
                    </div>
                </div>
                <script>
                </script>
            <%}%>
        <%}%>
    </div>

    <div id="pageBar">
        <%=request.getAttribute("pageBar")%>
    </div>
</div>
</section>
<script>
  const url = new URL( window.location.href);
  const urlParams = url.searchParams;

  if(!(urlParams.get('cPage') === '1' || urlParams.get('cPage') === null)){
    $(".trophy").attr("src","<%=request.getContextPath()%>/img/icon/normal_user.png");
  }

  $("#sortForm .button").click(e=>{
    $.ajax({
      url:"<%=request.getContextPath()%>/sortrankchef.do",
      data:{
        "chefRankPageSortRef":$(e.target).val()
      },
      success:data=>{
        console.log("정렬됨");
      }
    });
  })
</script>
<%@ include file="../../view/common/footer.jsp"%>
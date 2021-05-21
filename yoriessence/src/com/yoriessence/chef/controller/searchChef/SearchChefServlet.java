package com.yoriessence.chef.controller.searchChef;


import com.yoriessence.chef.model.service.UserService;
import com.yoriessence.chef.model.vo.Profile;
import com.yoriessence.chef.model.vo.User;
import com.yoriessence.recipe.model.vo.Recipe;
import com.yoriessence.recipe.model.vo.RecipeComment;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchChefServlet", value = "/searchchef.do")
public class SearchChefServlet extends HttpServlet {
    private static final long serialVersionUID = -1448507338993502574L;
    // 셰프랭킹 화면에서 셰프검색 했을 때

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String chefName = request.getParameter("chefsearch");
        String sortVal = request.getParameter("sortVal");
        String chefId = request.getParameter("chefId");

        List<Profile> chefProfile = new UserService().chefProfile(chefName);
        // 셰프 닉네임으로 검색해서 프로필 가져옴
        if( chefProfile == null){
            // 잘못된 입력으로 검색해서 결과가 없다면 다른 페이지로 연결해주고 이 메소드를 끝내자

            request.setAttribute("msg","검색 결과가 존재하지 않습니다. 다시 검색해주세요");
            request.setAttribute("loc","/rankchef.do");
            request.getRequestDispatcher("/view/common/msg.jsp").forward(request,response);

        }else{
            request.setAttribute("chefProfile",chefProfile);

            if(chefProfile.size() == 0){
                new UserService().createProfile(chefName);
                // 기본 프로필 생성함
                // 로그인 후 프로필 눌렀을 때 프로필 없으면 생성
                // 넘어오는 값은 아이디로 고정
                // 다시 프로필 가져와서 저장함
                List<Profile> reGetChefProfile = new UserService().chefProfile(chefName);
                request.setAttribute("chefProfile",reGetChefProfile);
            }

            // 셰프가 올린 레시피에 달린 댓글 개수 가져옴
            List<Integer> recipeComments = new UserService().countComment(chefName);
            request.setAttribute("countComment",recipeComments);


            // 셰프가 올린 레시피의 추천수 가져옴
            List<Integer> recipeRecommends = new UserService().countRecipeRecommend(chefName);
            request.setAttribute("recipeRecommends",recipeRecommends);


            // 유저 정보를 가져옴
            User userInfo = new UserService().userInfo(chefName);
            request.setAttribute("userInfo",userInfo);


            if(sortVal != null){
                List<Recipe> r = new UserService().sortRecipe(chefId,sortVal);
                // 정렬해서 가져옴

                request.setAttribute("recipe",r);

            }else{
                List<Recipe> recipes = new UserService().getRecipe(chefName);
                // 그 셰프가 올린 레시피를 가져옴
                request.setAttribute("recipe",recipes);

            }


            request.getRequestDispatcher("/view/searchChef/searchChefPage.jsp").forward(request,response);
        }



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

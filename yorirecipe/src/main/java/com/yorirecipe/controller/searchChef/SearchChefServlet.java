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
        // 셰프 이름으로 검색해서 결과 가져옴

        List<Integer> recipeComments = new UserService().countComment(chefName);
        // 셰프가 올린 레시피에 달린 댓글 개수 가져옴

        List<Integer> recipeRecommends = new UserService().countRecipeRecommend(chefName);
        // 셰프가 올린 레시피의 추천수 가져옴

        User userInfo = new UserService().userInfo(chefName);

        if(sortVal != null){
            List<Recipe> r = new UserService().sortRecipe(chefId,sortVal);
            // 정렬해서 가져옴

            request.setAttribute("recipe",r);

        }else{
            List<Recipe> recipes = new UserService().getRecipe(chefName);
            // 그 셰프가 올린 레시피를 가져옴
            request.setAttribute("recipe",recipes);

        }

        request.setAttribute("userInfo",userInfo);
        request.setAttribute("recipeRecommends",recipeRecommends);
        request.setAttribute("countComment",recipeComments);
        request.setAttribute("chefProfile",chefProfile);

        request.getRequestDispatcher("/view/searchChef/searchChefPage.jsp").forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

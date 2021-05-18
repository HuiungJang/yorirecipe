package com.yoriessence.chef.controller.searchChef;

import com.yoriessence.chef.model.service.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ChefRecommendServlet", value = "/recommendChef.do")
public class ChefRecommendServlet extends HttpServlet {
    private static final long serialVersionUID = 7921870686554057478L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String chefId =request.getParameter("chefId");
        int recommendYN =Integer.parseInt(request.getParameter("recommendYN"));

        System.out.println(recommendYN);
        System.out.println(chefId);

        if(recommendYN == 1){
            // 추천하는 로직으로
            System.out.println("추천됨전");
            new UserService().recommendChef(chefId);
            System.out.println("추천됨후");
        }else{
            // 추천 취소하는 로직으로
            new UserService().cancelRecommendChef(chefId);
            System.out.println("추천취소됨");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

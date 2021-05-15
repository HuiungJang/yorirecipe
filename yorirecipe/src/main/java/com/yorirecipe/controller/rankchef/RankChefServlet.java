package com.yorirecipe.controller.rankchef;

import com.yorirecipe.model.service.UserService;
import com.yorirecipe.model.vo.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "RankChefServlet", value = "/rankchef.do")
public class RankChefServlet extends HttpServlet {
    private static final long serialVersionUID = 3779996671072247270L;
    // 셰프랭킹 서블릿

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 셰프등급 전체 가져옴
        List<User> chefInfo = new UserService().chefRankList();
        HashMap<String,Integer> recommend = new UserService().recommendCount();

        request.setAttribute("recommend",recommend);
        request.setAttribute("chefInfo",chefInfo);
        request.getRequestDispatcher("/view/searchChef/RankChef.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

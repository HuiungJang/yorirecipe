package com.yorirecipe.controller.searchChef;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SearchChefServlet", value = "/searchchef.do")
public class SearchChefServlet extends HttpServlet {
    private static final long serialVersionUID = -1448507338993502574L;
    // 셰프랭킹 화면에서 셰프검색 했을 때

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchVal = request.getParameter("chefsearch");

//        System.out.println(searchVal);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

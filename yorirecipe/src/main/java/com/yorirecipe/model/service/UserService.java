package com.yoriessence.chef.model.service;



import com.yoriessence.chef.model.dao.UserDao;
import com.yoriessence.chef.model.vo.Profile;
import com.yoriessence.chef.model.vo.User;
import com.yoriessence.recipe.model.vo.Recipe;

import static com.yoriessence.common.JDBCTemplate.*;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Properties;

public class UserService {
    private Properties pp = new Properties();
    private UserDao dao = new UserDao();

    public UserService() {
        try{
            String path = UserService.class.getResource("/driver/driver.properties").getPath();
            pp.load(new FileReader(path));
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    // 아이디로 유저 정보 가져오는 메소드
    public User userInfo(String id){
        Connection conn = getConnection();
        User userInfo = dao.userInfo(conn,id);
        close(conn);

        return userInfo;
    }


    public List<User> chefRankList(int cPage, int numPerPage){
        // 셰프 랭킹화면 데이터 가져오는 서비스
        Connection conn = getConnection();
        List<User> result = dao.chefRankList(conn,cPage,numPerPage);
        close(conn);

        return result;
    }

    public List<Profile> chefProfileAll(){
        // 추천수대로 셰프 프로필 가져오는 메소드
        Connection conn = getConnection();
        List<Profile> chefProfileAll = dao.chefProfileAll(conn);
        close(conn);

        return chefProfileAll;
    }

    public int countChefList(){
     // 셰프가 몇명인지 가져오는 서비스
     Connection conn = getConnection();
     int result = dao.countChefList(conn);
     close(conn);

     return result;
    }

    public List<Profile> chefProfile(String chefName){
        // 셰프 프로필 가져오는 서비스
        Connection conn = getConnection();
        List<Profile> chefProfile = dao.chefProfile(conn,chefName);
        close(conn);

        return chefProfile;
    };

    public List<Recipe> getRecipe(String chefName){
        // 셰프가 올린 레시피 전부 가져오는 서비스
        Connection conn = getConnection();
        List<Recipe> getRecipe = dao.getRecipe(conn,chefName);
        close(conn);

        return getRecipe;
    }

    public List<Integer> countComment(String chefName){
        // 셰프가 올린 레시피들의 댓글 수 가져오는 서비스
        Connection conn = getConnection();
        List<Integer> result = dao.countComment(conn,chefName);

        close(conn);

        return result;
    }

    public List<Integer> countRecipeRecommend(String chefName){
        // 셰프가 올린 레시피들의 추천수 가져오는 서비스

        Connection conn = getConnection();
        List<Integer> result = dao.countRecipeRecommend(conn,chefName);

        close(conn);

        return result;
    }

    public void recommendChef(String chefId){
        // 셰프 추천수 증가
        Connection conn =getConnection();
        int result = dao.recommendChef(conn,chefId);

        if (result > 0) commit(conn);
        else rollback(conn);

        close(conn);
        System.out.println("서비스");
    }

    public void cancelRecommendChef(String chefId){
        // 셰프 추천수 감소
        Connection conn =getConnection();
        int result = dao.cancelRecommendChef(conn,chefId);

        if (result > 0) commit(conn);
        else rollback(conn);

        close(conn);

    }

    public List<Recipe> sortRecipe(String chefId,String sortVal){
        // 조회수, 최신순, 추천순으로 레시피 가져오는 서비스

        Connection conn = getConnection();
        List<Recipe> getRecipe = dao.sortRecipe(conn,chefId,sortVal);
        close(conn);

        return getRecipe;
    }



}

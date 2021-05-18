package com.yoriessence.chef.model.dao;

import static com.yoriessence.common.JDBCTemplate.*;

import com.yoriessence.chef.model.vo.Profile;
import com.yoriessence.chef.model.vo.User;
import com.yoriessence.recipe.model.vo.Recipe;
import com.yoriessence.recipe.model.vo.RecipeComment;
import oracle.jdbc.proxy.annotation.Pre;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class UserDao {
    private Properties pp = new Properties();

    public UserDao() {
        try{
            String path =  UserDao.class.getResource("/chef/chef.properties").getPath();
            pp.load(new FileReader(path));
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    // 아이디를 기준으로 유저 정보가져옴
    public User userInfo(Connection conn, String id){
        PreparedStatement psmt = null;
        ResultSet rs = null;
        User u = null;

        try{
            psmt = conn.prepareStatement(pp.getProperty("getMemberInfo"));
            psmt.setString(1,id);

            rs= psmt.executeQuery();

            if(rs.next()){
                u= new User();
                u.setMemberId(rs.getString("member_id"));
                u.setMemberName(rs.getString("member_name"));
                u.setMemberEmail(rs.getString("member_email"));
                u.setMemberNickName(rs.getString("member_nickname"));
                u.setMemberAddress(rs.getString("member_address"));
                u.setMemberGrade(rs.getString("member_grade"));
                u.setMemberPhone(rs.getString("member_phone"));
                u.setMemberPoint(rs.getInt("member_point"));

            }

        }catch(SQLException e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(psmt);
        }

        return u;
    }

    // 셰프 등급만 추천순으로 조회하기, 페이징처리
    public List<User> chefRankList(Connection conn, int cPage, int numPerPage){
        PreparedStatement psmt = null;
        ResultSet rs = null;
        List<User> result = new ArrayList<>();

        try{
            psmt = conn.prepareStatement(pp.getProperty("chefRankList"));
            psmt.setInt(1,(cPage-1)*numPerPage+1);
            psmt.setInt(2,cPage*numPerPage);

            rs= psmt.executeQuery();

            while(rs.next()){
                User u = new User();
                u.setMemberId(rs.getString("member_id"));
                u.setMemberName(rs.getString("member_name"));
                u.setMemberEmail(rs.getString("member_email"));
                u.setMemberNickName(rs.getString("member_nickname"));
                u.setMemberAddress(rs.getString("member_address"));
                u.setMemberGrade(rs.getString("member_grade"));
                u.setMemberPhone(rs.getString("member_phone"));
                u.setMemberPoint(rs.getInt("member_point"));
                u.setRecommendCount(rs.getInt("recommend_count"));

                result.add(u);
            }

        }catch(SQLException e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(psmt);
        }

        return result;
    }

    public List<Profile> chefProfileAll(Connection conn){
        // 셰프등급의 유저의 프로필을 추천순으로 정렬해서 가져옴
        PreparedStatement psmt = null;
        ResultSet rs = null;
        List<Profile> chefProfileAll = new ArrayList<>();

        try{
            psmt = conn.prepareStatement(pp.getProperty("chefProfileAll"));

            rs = psmt.executeQuery();

            while(rs.next()){
                Profile p = new Profile();

                p.setMemberId(rs.getString("memberid"));
                p.setProfileName(rs.getString("profile_name"));
                p.setSelfIntro(rs.getString("profile_selfintro"));
                p.setProfilePic(rs.getString("profile_pic"));
                p.setProfileSnsUrl1(rs.getString("profile_SNS_URL_1"));
                p.setProfileSnsUrl2(rs.getString("profile_SNS_URL_2"));

                chefProfileAll.add(p);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(psmt);
        }

        return chefProfileAll;
    }

    // 셰프가 몇명인지 세는 메소드
    public int countChefList(Connection conn){
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;
       try{
           pstmt = conn.prepareStatement(pp.getProperty("countChefList"));

           rs = pstmt.executeQuery();

           if(rs.next()){
            result = rs.getInt(1);
           }

       }catch (SQLException e){
           e.printStackTrace();
       }finally {
           close(rs);
           close(pstmt);
       }

       return result;
    }

    // 셰프 검색하면 프로필 가져오는 메소드
    public List<Profile> chefProfile(Connection conn, String chefName){
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Profile> chefProfile = new ArrayList<>();

        try{
            pstmt = conn.prepareStatement(pp.getProperty("chefProfile"));

            pstmt.setString(1,chefName);

            rs = pstmt.executeQuery();

            if(rs.next()){
                Profile p = new Profile();

                p.setMemberId(rs.getString("memberid"));
                p.setProfileName(rs.getString("profile_name"));
                p.setSelfIntro(rs.getString("profile_selfintro"));
                p.setProfilePic(rs.getString("profile_pic"));
                p.setProfileSnsUrl1(rs.getString("profile_SNS_URL_1"));
                p.setProfileSnsUrl2(rs.getString("profile_SNS_URL_2"));

                chefProfile.add(p);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(pstmt);
        }

        return chefProfile;
    }

    // 레시피 리스트 가져오는 메소드
    public List<Recipe> getRecipe(Connection conn, String chefName){
        PreparedStatement psmt = null;
        ResultSet rs = null;
        List<Recipe> recipeList = new ArrayList<>();

        try{
            psmt=conn.prepareStatement(pp.getProperty("getRecipe"));

            psmt.setString(1,chefName);

            rs = psmt.executeQuery();

            while(rs.next()){
                Recipe r = new Recipe();
                r.setRecipeEnrollNo(rs.getInt("Recipe_enroll_no"));
                r.setMemberId(rs.getString("member_id"));
                r.setRecipeTitle(rs.getString("recipe_intro"));
                r.setRepresentPicture(rs.getString("represent_picture"));
                r.setRecipeVideoAddress(rs.getString("recipe_video_address"));
                r.setRecipeCategory(rs.getString("recipe_category"));
                r.setRecipeInfoHowmany(rs.getInt("recipe_info_howmany"));
                r.setRecipeInfoTime(rs.getInt("recipe_info_time"));
                r.setRecipeDifficult(rs.getString("recipe_difficult"));
                r.setRecipeProcedure(rs.getString("recipe_tip"));
                r.setRecipeViewCount(rs.getInt("recipe_view_count"));
                r.setRecipeEnrollDate(rs.getDate("recipe_enroll_date"));

                recipeList.add(r);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(psmt);
        }

        return recipeList;
    }

    public List<Integer> countComment(Connection conn, String chefName){
        // 레시피별 댓글 갯수 가져오는 메소드
        PreparedStatement psmt= null;
        ResultSet rs = null;
        List<Integer> result = new ArrayList<>();

        try{
            psmt = conn.prepareStatement(pp.getProperty("countComment"));

            psmt.setString(1,chefName);
            rs = psmt.executeQuery();

            while(rs.next()){
                result.add(rs.getInt(1));
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(psmt);
        }

        return  result;
    }

    public List<Integer> countRecipeRecommend(Connection conn, String chefName){
        // 레시피 별 추천수 가져오는 메소드
        PreparedStatement psmt= null;
        ResultSet rs = null;
        List<Integer> result = new ArrayList<>();

        try{
            psmt = conn.prepareStatement(pp.getProperty("countRecipeRecommend"));

            psmt.setString(1,chefName);
            rs = psmt.executeQuery();

            while(rs.next()){
                result.add(rs.getInt(1));
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(psmt);
        }

        return  result;
    }

    public int recommendChef(Connection conn,String chefId){
        // 셰프 추천수 증가시키는 메소드
        PreparedStatement psmt = null;
        int result=0;

        try{
            psmt = conn.prepareStatement(pp.getProperty("recommendChef"));
            psmt.setString(1,chefId);

            result= psmt.executeUpdate();

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(psmt);
        }
        System.out.println("추천수 증가됨! DAO"+result);
        return result;
    }

    public int cancelRecommendChef(Connection conn,String chefId){
        // 셰프 추천수 감소시키는 메소드
        PreparedStatement psmt = null;
        int result =0;

        try{
            psmt = conn.prepareStatement(pp.getProperty("cancelRecommendChef"));
            psmt.setString(1,chefId);

            result= psmt.executeUpdate();

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(psmt);
        }

        return result;
    }

    // 최신순, 조회순, 추천순으로 레시피 가져오는 메소드
    public List<Recipe> sortRecipe(Connection conn, String chefName,String sortVal){
        PreparedStatement psmt = null;
        ResultSet rs = null;
        List<Recipe> recipeList = new ArrayList<>();

        try{
            if(sortVal.equals("추천순")){
                psmt=conn.prepareStatement(pp.getProperty("sortRecipeRecommend"));
                psmt.setString(1,chefName);

            }else if(sortVal.equals("최신순")){
                psmt=conn.prepareStatement(pp.getProperty("sortRecipe"));
                psmt.setString(1,chefName);
                psmt.setString(2,"Recipe_enroll_no");

            }else if(sortVal.equals("조회순")){
                psmt=conn.prepareStatement(pp.getProperty("sortRecipe"));
                psmt.setString(1,chefName);
                psmt.setString(2,"Recipe_view_count");
            }

            rs = psmt.executeQuery();

            while(rs.next()){
                Recipe r = new Recipe();
                r.setRecipeEnrollNo(rs.getInt("Recipe_enroll_no"));
                r.setMemberId(rs.getString("member_id"));
                r.setRecipeTitle(rs.getString("recipe_intro"));
                r.setRepresentPicture(rs.getString("represent_picture"));
                r.setRecipeVideoAddress(rs.getString("recipe_video_address"));
                r.setRecipeCategory(rs.getString("recipe_category"));
                r.setRecipeInfoHowmany(rs.getInt("recipe_info_howmany"));
                r.setRecipeInfoTime(rs.getInt("recipe_info_time"));
                r.setRecipeDifficult(rs.getString("recipe_difficult"));
                r.setRecipeProcedure(rs.getString("recipe_tip"));
                r.setRecipeViewCount(rs.getInt("recipe_view_count"));
                r.setRecipeEnrollDate(rs.getDate("recipe_enroll_date"));

                recipeList.add(r);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(rs);
            close(psmt);
        }

        return recipeList;
    }



}

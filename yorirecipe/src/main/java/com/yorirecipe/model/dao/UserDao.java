package com.yorirecipe.model.dao;

import static com.yorirecipe.common.JDBCTemplate.*;
import com.yorirecipe.model.vo.User;

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

    // 셰프 등급만 전부 조회하기, 페이징처리
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
}

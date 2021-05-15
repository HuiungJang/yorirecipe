package com.yorirecipe.model.dao;

import static com.yorirecipe.common.JDBCTemplate.*;
import com.yorirecipe.model.vo.User;
import com.yorirecipe.model.vo.UserRecommend;
import oracle.jdbc.proxy.annotation.Pre;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
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

    // 셰프 등급만 전부 조회하기
    public List<User> chefRankList(Connection conn){
        PreparedStatement psmt = null;
        ResultSet rs = null;
        List<User> result = new ArrayList<>();

        try{
            psmt = conn.prepareStatement(pp.getProperty("chefRankList"));

            psmt.setString(1,"cf");

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

    // 추천수 가져오는 메소드
    public HashMap<String,Integer> recommendCount(Connection conn){
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        HashMap<String,Integer> result = new HashMap<>();

        try{
            pstmt = conn.prepareStatement(pp.getProperty("recommendCount"));

            rs = pstmt.executeQuery();

            while(rs.next()){
                UserRecommend c = new UserRecommend();
                c.setMemberId(rs.getString("member_id"));
                c.setRecommendCount(rs.getInt("recommend_count"));

                result.put(c.getMemberId(),c.getRecommendCount());
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

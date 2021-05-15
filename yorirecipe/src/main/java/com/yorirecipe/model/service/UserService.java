package com.yorirecipe.model.service;

import com.yorirecipe.model.dao.UserDao;
import com.yorirecipe.model.vo.User;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import static com.yorirecipe.common.JDBCTemplate.*;

public class UserService {
    private Properties pp = new Properties();
    private UserDao dao = new UserDao();

    public UserService() {
        try{
            String path =  UserDao.class.getResource("/driver/driver.properties").getPath();
            pp.load(new FileReader(path));
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    public List<User> chefRankList(){
        // 셰프 랭킹화면 데이터 가져오는 서비스
        Connection conn = getConnection();
        List<User> result = dao.chefRankList(conn);
        close(conn);

        return result;
    }

    public HashMap<String,Integer> recommendCount(){
        // 추천수 가져오는 서비스
        Connection conn = getConnection();
        HashMap<String,Integer> result = dao.recommendCount(conn);
        close(conn);

        return result;
    }




}
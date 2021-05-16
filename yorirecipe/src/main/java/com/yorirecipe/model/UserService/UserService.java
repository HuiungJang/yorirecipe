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

    public List<User> chefRankList(int cPage, int numPerPage){
        // 셰프 랭킹화면 데이터 가져오는 서비스
        Connection conn = getConnection();
        List<User> result = dao.chefRankList(conn,cPage,numPerPage);
        close(conn);

        return result;
    }

    public int countChefList(){
     // 셰프가 몇명인지 가져오는 서비스
     Connection conn = getConnection();
     int result = dao.countChefList(conn);
     close(conn);

     return result;
    }


}

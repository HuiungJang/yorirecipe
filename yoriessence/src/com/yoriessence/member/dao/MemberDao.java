package com.yoriessence.member.dao;

import static com.yoriessence.common.JDBCTemplate.close;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.yoriessence.member.vo.Member;

public class MemberDao {
	
	private Properties prop = new Properties();
	
	public MemberDao() {
		try {
			String filePath=MemberDao.class.getResource("/sql/member_sql.properties").getPath();
			prop.load(new FileReader(filePath));
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Member login(Connection conn, String userId, String userPwd) {
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		Member m = null;
		try {
			pstmt=conn.prepareStatement(prop.getProperty("selectMember"));
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				m=new Member();
				m.setUserId(rs.getString("member_id"));
				m.setUserName(rs.getString("member_name"));
				m.setPassword(rs.getString("member_pw"));
				m.setNickName(rs.getString("member_nickname"));
				m.setEmail(rs.getString("member_email"));
				m.setAddress(rs.getString("member_address"));
				m.setMembergrade(rs.getString("member_grade"));
				m.setPoint(rs.getInt("member_point"));
				m.setPhone(rs.getString("member_phone"));
			}
		}catch(Exception e ) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return m;
	}
	
	public int insertMember(Connection conn, Member m) {
		PreparedStatement pstmt =null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(prop.getProperty("insertMember"));
			pstmt.setString(1, m.getUserId());
			pstmt.setString(2, m.getUserName());
			pstmt.setString(3, m.getPassword());
			pstmt.setString(4, m.getNickName());
			pstmt.setString(5, m.getEmail());
			pstmt.setString(6, m.getAddress());
			pstmt.setString(7, m.getMembergrade());
			pstmt.setInt(8, m.getPoint());
			pstmt.setString(9, m.getPhone());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public Member checkDuplicateId(Connection conn, String userId) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Member m =null;
		try {
			pstmt=conn.prepareStatement(prop.getProperty("selectMemberId"));
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				m=new Member();
				m.setUserId(rs.getString("member_id"));
				m.setUserName(rs.getString("member_name"));
				m.setPassword(rs.getString("member_pw"));
				m.setNickName(rs.getString("member_nickname"));
				m.setEmail(rs.getString("member_email"));
				m.setAddress(rs.getString("member_address"));
				m.setMembergrade(rs.getString("member_grade"));
				m.setPoint(rs.getInt("member_point"));
				m.setPhone(rs.getString("member_phone"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return m;
	}

}
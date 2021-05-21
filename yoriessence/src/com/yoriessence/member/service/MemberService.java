package com.yoriessence.member.service;

import static com.yoriessence.common.JDBCTemplate.close;
import static com.yoriessence.common.JDBCTemplate.getConnection;

import java.sql.Connection;

import com.yoriessence.member.dao.MemberDao;
import com.yoriessence.member.vo.Member;


public class MemberService {
	private MemberDao dao=new MemberDao();
	
	public Member login(String userId, String userPwd) {
		Connection conn=getConnection();
		Member m = dao.login(conn,userId,userPwd);
		close(conn);
		return m;
	}
	
	public int insertMember(Member m) {
		Connection conn=getConnection();
		int result=dao.insertMember(conn, m);
		close(conn);
		return result;
	}
	
	public Member checkDuplicateId(String userId) {
		Connection conn=getConnection();
		Member m = dao.checkDuplicateId(conn,userId);
		close(conn);
		return m;
	}
	
}
package com.yoriessence.recipe.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.yoriessence.recipe.model.vo.Recipe;
import static com.yoriessence.common.JDBCTemplate.close;

public class RecipeDao {
	
	private Properties prop=new Properties();
	
	public RecipeDao() {
		String path=RecipeDao.class.getResource("/sql/recipe_sql.properties").getPath();
		try {
			prop.load(new FileReader(path));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<Recipe> selectRecipeList(Connection conn){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Recipe> list=new ArrayList();
		try{
			pstmt=conn.prepareStatement(prop.getProperty("selectRecipeList"));
			System.out.println(prop.getProperty("selectRecipeList"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Recipe r=new Recipe();
				r.setRecipeEnrollNo(rs.getInt("recipe_enroll_no"));
				r.setMemberId(rs.getString("member_id"));
				r.setRecipeTitle(rs.getString("recipe_title"));
				r.setRecipeIntro(rs.getString("recipe_intro"));
				r.setRepresentPicture(rs.getString("represent_picture"));
				r.setRecipeVideoAddress(rs.getString("recipe_video_address"));
				r.setRecipeCategory(rs.getString("recipe_category"));
				r.setRecipeInfoHowmany(rs.getInt("recipe_info_howmany"));
				r.setRecipeInfoTime(rs.getInt("recipe_info_time"));
				r.setRecipeDifficult(rs.getString("recipe_difficult"));
				r.setRecipeProcedure(rs.getString("recipe_procedure"));
				r.setRecipeTip(rs.getString("recipe_tip"));
				r.setRecipeViewCount(rs.getInt("recipe_view_count"));
				list.add(r);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}

}

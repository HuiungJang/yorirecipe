package com.yoriessence.recipe.model.service;

import java.sql.Connection;

import java.util.List;

import com.yoriessence.recipe.model.dao.RecipeDao;
import com.yoriessence.recipe.model.vo.Recipe;

import static com.yoriessence.common.JDBCTemplate.getConnection;
import static com.yoriessence.common.JDBCTemplate.close;

public class RecipeService {
	
	private RecipeDao dao=new RecipeDao();
	
	public List<Recipe> selectRecipeList(){
		Connection conn=getConnection();
		List<Recipe> list=dao.selectRecipeList(conn);
		close(conn);
		return list;
	}

}

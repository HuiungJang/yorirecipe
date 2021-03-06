package com.yoriessence.shopping.service;

import static com.yoriessence.common.JDBCTemplate.close;
import static com.yoriessence.common.JDBCTemplate.commit;
import static com.yoriessence.common.JDBCTemplate.getConnection;
import static com.yoriessence.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.yoriessence.shopping.dao.ShoppingCartDao;
import com.yoriessence.shopping.vo.OrderDetails;
import com.yoriessence.shopping.vo.Product;
import com.yoriessence.shopping.vo.ShoppingCart;

public class ShoppingCartService {
	
	private ShoppingCartDao dao=new ShoppingCartDao();
	
	
	
	public List<ShoppingCart> ShoppingCartCheck(String memberId) {
		Connection conn=getConnection();
		List<ShoppingCart> list=dao.ShoppingCartCheck(conn,memberId);
		close(conn);
		return list;
	}
	
	public List<Product> ProductAll(int cPage, int numPerpage) {
		Connection conn=getConnection();
		List<Product> list=dao.ProductAll(conn,cPage,numPerpage);
		close(conn);
		return list;
	}
	
	public int selectProductCount() {
		Connection conn=getConnection();
		int result=dao.selectProductCount(conn);
		close(conn);
		return result;
	}
	
	public Product Productsearch(String search) {
		Connection conn=getConnection();
		Product pds=dao.Productsearch(conn,search);
		close(conn);
		return pds;
	}
	
	public Product selectProduct(int productno) {
		Connection conn=getConnection();
		Product pd=dao.selectProduct(conn, productno);
		close(conn);
		return pd;
	}
	
	public int deleteShopping(String productname) {
		Connection conn=getConnection();
		int result=dao.deleteShopping(conn,productname);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public List<Product> Shoppingkategori(String katagori){
		Connection conn=getConnection();
		List<Product> list=dao.Shoppingkategori(conn,katagori);
		close(conn);
		return list;
	}
	
	public int insertShoppingCart(ShoppingCart sc) {
		Connection conn=getConnection();
		int result=dao.insertShoppingCart(conn,sc);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public int ProductInsert(Product pd) {
		Connection conn=getConnection();
		int result=dao.ProductInsert(conn, pd);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public List<OrderDetails> OrderDetails(String memberid){
		Connection conn=getConnection();
		List<OrderDetails> list=dao.OrderDetails(conn,memberid);
		close(conn);
		return list;
	}

}

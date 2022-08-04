package dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.http.HttpServletRequest;
import dto.barcodesearch;
import com.mysql.jdbc.Connection;
import dto.foodmanage;

public class SellDao {
	private static SellDao dao = new SellDao();
	public static SellDao getDao() {
		return dao;
	} 
	
	public void delfood(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		int num = Integer.valueOf(request.getParameter("num"));
		String idsql = "fooddel"+num;
		int id = Integer.valueOf(request.getParameter(idsql));
		try {
			String sql = "delete from foodlist where f_id = ?";
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (dbconn != null) {
					dbconn.close();
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}	
	
	public void totalpage(HttpServletRequest request, String foodname) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int total = 0;
		String sql = "";
		try {
			dbconn = conn();
			if (foodname == null) {
				sql = "select count(*) from foodlist";
			}
			else {
				sql = "select count(*) from foodlist where f_name like '%"+foodname+"%'";
			}
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			total = rs.getInt(1);
			request.setAttribute("totalpage", total);
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void productmanage(HttpServletRequest request, String foodname) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<foodmanage> alf = new ArrayList<foodmanage>(); 
		String sql = "";
		try {
			dbconn = conn();
			if (foodname == null) {
				sql = "select * from foodlist";
			}
			else {
				sql = "select * from foodlist where f_name like '%"+foodname+"%'";
			}
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				foodmanage fm = new foodmanage();
				fm.setF_id(String.valueOf(rs.getInt("f_id")));
				fm.setF_code(rs.getString("f_category"));
				fm.setF_name(rs.getString("f_name"));
				fm.setF_price(rs.getInt("f_price"));
				fm.setF_unit(rs.getInt("f_unit"));
				alf.add(fm);
			}
			request.setAttribute("foodmanage", alf);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (dbconn != null) {
					dbconn.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public int addchk(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int chk = 0;
		String name = request.getParameter("name");
		
		try {
			dbconn = conn();
			String sql = "select count(*) from foodlist where f_name=?";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			rs.next();
			chk = rs.getInt(1);
					
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chk;
	}
	
	public void addfood(HttpServletRequest request) {
		Connection  dbconn = null;
		PreparedStatement pstmt = null;
		
		String fb_code =  request.getParameter("foodcate");
		String fb_name =  request.getParameter("name");
		int fb_price =  Integer.valueOf(request.getParameter("price"));
		int fb_unit =  Integer.valueOf(request.getParameter("unit"));
		try {
			dbconn = conn();
			String sql = "insert into foodlist(f_category, f_name, f_price, f_unit) values (?,?,?,?)";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, fb_code);
			pstmt.setString(2, fb_name);
			pstmt.setInt(3, fb_price);
			pstmt.setInt(4, fb_unit);
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void f_search(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String search = request.getParameter("search");
		ArrayList<barcodesearch> alb = new ArrayList<barcodesearch>(); 
		
		try {
			dbconn = conn();
			String sql = "select * from foodbarcode where fb_sub like '%"+search+"%'";
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				barcodesearch bs = new barcodesearch();
				bs.setFb_main(rs.getString("fb_main"));
				bs.setFb_middle(rs.getString("fb_middle"));
				bs.setFb_sub(rs.getString("fb_sub"));
				alb.add(bs);
			}
			request.setAttribute("barcodesearch", alb);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (dbconn != null) {
					dbconn.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		} 
	}
	
	public Connection conn() {
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/changgimarket?ServerTimezone=Asia/Seoul&useSSL=false";
		String user = "root";
		String pw = "1234";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = (Connection) DriverManager.getConnection(url, user, pw);
		} catch (Exception e) {
			e.getMessage();
		}
		return conn;
	}
	
}

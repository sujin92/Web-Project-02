package dao;
import dto.cartlist;
import dto.foodprice;
import dto.recipelist;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;


public class CartDao {
	
	private CartDao() {};
	private static CartDao dao = new CartDao();
	public static CartDao getDao() {
		return  dao;
	}
	
	public void seldel(HttpServletRequest request) {
		HttpSession session = request.getSession();
		ArrayList<cartlist> al = (ArrayList<cartlist>)session.getAttribute("myCart");
		String[] food = request.getParameterValues("foodid");
		int[] foods = new int[food.length];
		for (int j = 0; j < foods.length; j++) {
			foods[j] = Integer.valueOf(food[j]);
		}
		int delcnt = 0; 
		for (int i = 0; i < food.length; i++) {
			al.remove(foods[i]-delcnt);
			delcnt++;
		}
		
	}
	
	public void cartdel(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("myCart");
	}
	
	public void pagecnt(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userid");
		
		String orderperiod = request.getParameter("orderperiod");
		int diff = 0;
		if (orderperiod.equals("1year")) {
			diff = 12;
		}
		else if(orderperiod.equals("1month")) {
			diff= 1;
		}
		else if(orderperiod.equals("3month")) {
			diff = 3;
		}
		else if(orderperiod.equals("6month")) {
			diff = 6;
		}
		LocalDateTime ldt = LocalDateTime.now().minusMonths(diff);
		String s_date = ldt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			dbconn = conn();
			String sql = "select count(*) from cusorder where o_id=? and o_date > ?";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, s_date);
			rs = pstmt.executeQuery();
			
			rs.next();
			int cnt = rs.getInt(1);
			String s_cnt = String.valueOf(cnt);
			request.setAttribute("cnt", s_cnt);
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
	
	public void mypage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userid");
		ArrayList<cartlist> al = new ArrayList<cartlist>();
		
		String orderperiod = request.getParameter("orderperiod");
		int diff = 0;
		if (orderperiod.equals("1year")) {
			diff = 12;
		}
		else if(orderperiod.equals("1month")) {
			diff= 1;
		}
		else if(orderperiod.equals("3month")) {
			diff = 3;
		}
		else if(orderperiod.equals("6month")) {
			diff = 6;
		}
		LocalDateTime ldt = LocalDateTime.now().minusMonths(diff);
		String s_date = ldt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		String sql = "select * from cusorder where o_id=? and o_date > ? order by o_num desc";
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			dbconn = conn();	
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, s_date);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				cartlist ca = new cartlist();
				ca.setNum(rs.getInt("o_num"));
				ca.setFoodName(rs.getString("o_f_name"));
				ca.setFoods(rs.getString("o_f_singname").split(","));
				ca.setFoodprice(rs.getString("o_f_singprice").split(","));
				ca.setFoodunit(rs.getString("o_f_singunit").split(","));
				ca.setDate(rs.getString("o_date"));
				ca.setFilename(rs.getString("o_f_img"));
				
				al.add(ca);			
			}
			request.setAttribute("mypage", al);
		}
		catch (Exception e ) {
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
	
	
	
	public void price(HttpServletRequest request) {
		Connection dbconn = null;
		String sql = "select * from foodlist";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<foodprice> foodprice = new ArrayList<foodprice>();
			while (rs.next()) {
				foodprice fp = new foodprice();
				fp.setF_name(rs.getString("f_name"));
				fp.setF_price(rs.getInt("f_price"));
				foodprice.add(fp);				
			}
			request.setAttribute("foodprice", foodprice);
		} catch (Exception e) {
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
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void addCart(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("myCart") == null) {
			ArrayList<cartlist> al = new ArrayList<cartlist>();
			session.setAttribute("myCart", al);
		}
		cartlist cl = new cartlist();
		String name = request.getParameter("name");
		int len = Integer.parseInt(request.getParameter("len"));
		String[] foods = new String[len];
		String[] foodnum = new String[len];
		String[] foodprice = new String[len];
		String file = request.getParameter("file");
		int id = Integer.valueOf(request.getParameter("foodid"));
		for (int i = 0; i < len; i++) {
			foods[i] = request.getParameter("foods"+i);
			foodnum[i] = request.getParameter("foodnum"+i);
			foodprice[i] = request.getParameter("foodprice"+i);
		}
		cl.setFoodName(name);
		cl.setFoods(foods);
		cl.setFoodunit(foodnum);
		cl.setFoodprice(foodprice);
		cl.setFilename(file);
		cl.setNum(id);
		ArrayList<cartlist> al = (ArrayList<cartlist>)session.getAttribute("myCart");
		al.add(cl);
	}
	
	public void sellcnt(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Connection dbconn = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		
		ArrayList<cartlist> al = (ArrayList<cartlist>)session.getAttribute("myCart");
		String sql1 = "select r_sell from recipe where r_id = ?";
		String sql2 = "update recipe set r_sell= ? where r_id = ?";
		
		String[] selchk = request.getParameterValues("selchk");
		
		try {
			dbconn = conn();
			pstmt1 = dbconn.prepareStatement(sql1);
			pstmt2 = dbconn.prepareStatement(sql2);
			for (int i = 0; i < al.size(); i++) {
				cartlist ca = al.get(i);
				if (selchk[i].equals("1")) {
					int id = ca.getNum();
					pstmt1.setInt(1, id);
					rs = pstmt1.executeQuery();
					
					if (rs.next()) {
						int sell = rs.getInt(1);
						pstmt2.setInt(1, sell+1);
						pstmt2.setInt(2, id);
						pstmt2.executeUpdate();
						pstmt1.clearParameters();
						pstmt2.clearParameters();
					}
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt2 != null) {
					pstmt2.close();
				}
				if (pstmt1 != null) {
					pstmt1.close();
				}
				if (dbconn != null) {
					dbconn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		int cnt = 0;
		int listcnt = al.size();
		for (int i = 0; i < listcnt; i++) {
			if (selchk[i].equals("1")) {
				al.remove(i-cnt);
				cnt++;
			}
		}
	}
	
	public void order(HttpServletRequest request) {
		HttpSession session = request.getSession();	
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date = format.format(Calendar.getInstance().getTime());
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String c_id = (String)session.getAttribute("userid");
		String foodlen  = request.getParameter("foodlen");
		String[] singfoodlen = new String[Integer.valueOf(foodlen)];
		String[] foodimg = new String[Integer.valueOf(foodlen)];
		String[] foodname = new String[Integer.valueOf(foodlen)];
		String[] singfoodname = new String[Integer.valueOf(foodlen)];
		String[] singfoodprice = new String[Integer.valueOf(foodlen)];
		String[] singfoodunit = new String[Integer.valueOf(foodlen)];
		String cusaddr = request.getParameter("cusaddr");

		String[] selchk = request.getParameterValues("selchk");
		for (int i = 0; i < Integer.valueOf(foodlen); i++) {
			if (selchk[i].equals("1")) {
				singfoodlen[i] = request.getParameter("singfoodlen"+i);
				foodimg[i] = request.getParameter("foodimg"+i);
				foodname[i] = request.getParameter("foodname"+i);
			}
		}
		for (int j = 0; j < Integer.valueOf(foodlen); j++) {
			if (selchk[j].equals("1")) {
				int x = Integer.valueOf(singfoodlen[j]);
				for (int y = 0; y < x; y++) {
					if (y == 0) {
						singfoodname[j] = request.getParameter("singfoodname"+j+y);
						singfoodprice[j] = request.getParameter("foodprice"+j+y);
						singfoodunit[j] = request.getParameter("foodunit"+j+y);
					}
					else {
						singfoodname[j] += ","+request.getParameter("singfoodname"+j+y);
						singfoodprice[j] += ","+request.getParameter("foodprice"+j+y);
						singfoodunit[j] += ","+request.getParameter("foodunit"+j+y);
					}
				}
			}
		}
		try {
			conn = conn();
			String sql = "insert into cusorder (o_date, o_id, o_f_name, o_f_img, o_f_singname, o_f_singprice, o_f_singunit, o_addr) values (?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			for (int t = 0; t < Integer.valueOf(foodlen); t++) {
				if (selchk[t].equals("1")) {
					pstmt.setString(1, date);
					pstmt.setString(2, c_id);
					pstmt.setString(3, foodname[t]);
					pstmt.setString(4, foodimg[t]);
					pstmt.setString(5, singfoodname[t]);
					pstmt.setString(6, singfoodprice[t]);
					pstmt.setString(7, singfoodunit[t]);
					pstmt.setString(8, cusaddr);
					pstmt.addBatch();
					pstmt.clearParameters();
				}
			}
			pstmt.executeBatch();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			
				try {
					if (pstmt != null) {
						pstmt.close();
					}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
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

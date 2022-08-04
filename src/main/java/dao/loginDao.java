package dao;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.mysql.jdbc.Connection;

import dto.customer;
import dto.orderlist;
import dto.seller;

public class loginDao {
	private static loginDao dao = new loginDao();
	public static loginDao getDao() {
		return dao;
	}
	
	public void unsign(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		HttpSession session = request.getSession();
		String id1 = (String)session.getAttribute("userid");
		String id2 = (String)session.getAttribute("seller");
		String id = "";
		String user = "";
		if (id1 != null) {
			id = id1;
			user = "customer";
		}
		else {
			id = id2;
			user = "seller";
		}
		String sql = "";
			if (user.equals("customer")) {
				sql = "delete from customer where c_id=?";
			}
			else {
				sql = "delete from seller where s_id=?";
			}
		try {
			dbconn = conn();
			pstmt = dbconn.clientPrepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		}
		catch (Exception e) {
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
		session.invalidate();
	}
	
	public void pwchange(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		String id = request.getParameter("id");
		String user = request.getParameter("user");
		String password = request.getParameter("pw");
		String sql = "";
		
		if (user.equals("customer")) {
			sql = "update customer set c_password=? where c_id=?";
		}
		else {
			sql = "update seller set s_password=? where s_id=?";
		}
		
		try {
			dbconn = conn();
			pstmt = dbconn.clientPrepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		}
		catch (Exception e) {
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
	
	
	public int idsearch(HttpServletRequest request) {
		int ans = 0;
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		ArrayList<String> ids = new ArrayList<String>();
		
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
		if (phone.length() < 12) {
			phone = "";
		}
		String mail = request.getParameter("mail");
		
		
		String sql = "";
		String sql2 = "";
		try {
			dbconn = conn();
			if (phone.equals("")) {
				sql = "select c_id from customer where c_mail=? ";
				pstmt = dbconn.clientPrepareStatement(sql);
				pstmt.setString(1, mail);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ids.add(rs.getString("c_id"));
					ans = 1;
				}
				
				sql2 = "select s_id from seller where s_mail=? ";
				pstmt2 = dbconn.clientPrepareStatement(sql2);
				pstmt2.setString(1, mail);				
				rs2 = pstmt2.executeQuery();
				while (rs2.next()) {
					ids.add(rs2.getString("s_id"));
					ans = 1;
				}
				 
			}
			else {
				sql = "select c_id from customer where c_phone=? ";
				pstmt = dbconn.clientPrepareStatement(sql);
				pstmt.setString(1, phone);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ids.add(rs.getString("c_id"));
					ans = 1;
				}
				
				sql2 = "select s_id from seller where s_phone=? ";
				pstmt2 = dbconn.clientPrepareStatement(sql2);
				pstmt2.setString(1, phone);
				rs2 = pstmt2.executeQuery();
				while (rs2.next()) {
					ids.add(rs2.getString("s_id"));
					ans = 1;
				}
			}
			 request.setAttribute("ans", ids);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs2 != null) {
					rs2.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (pstmt2 != null) {
					pstmt2.close();
				}
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
		return ans;
	}
	public int pwsearch(HttpServletRequest request) {
		int ans = 0;
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
				
		String id = request.getParameter("id");

		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
		if (phone.length() < 12) {
			phone = "";
		}
		String mail = request.getParameter("mail");
		
		String user = "";
		
		String sql = "";
		String sql2 = "";

		try {
			dbconn = conn();
			if (phone.equals("")) {
				sql = "select count(*) from customer where c_mail=? and c_id=?";
				pstmt = dbconn.clientPrepareStatement(sql);
				pstmt.setString(1, mail);
				pstmt.setString(2, id);
				rs = pstmt.executeQuery();
				rs.next();
				if (rs.getInt(1) == 1) {
					ans = 1;
					user = "customer";
				}
				
				sql2 = "select count(*) from seller where s_mail=? and s_id=?";
				pstmt2 = dbconn.clientPrepareStatement(sql2);
				pstmt2.setString(1, mail);
				pstmt2.setString(2, id);
				rs2 = pstmt2.executeQuery();
				rs2.next();
				if (rs2.getInt(1) == 1) {
					ans = 1;
					user = "seller";
				}
				 
			}
			else {
				sql = "select count(*) from customer where c_phone=? and c_id=?";
				pstmt = dbconn.clientPrepareStatement(sql);
				pstmt.setString(1, phone);
				pstmt.setString(2, id);
				rs = pstmt.executeQuery();
				rs.next();
				if (rs.getInt(1) == 1) {
					ans = 1;
					user = "customer";
				}
				
				sql2 = "select count(*) from seller where s_phone=? and s_id=?";
				pstmt2 = dbconn.clientPrepareStatement(sql2);
				pstmt2.setString(1, phone);
				pstmt2.setString(2, id);
				rs2 = pstmt2.executeQuery();
				rs2.next();
				if (rs2.getInt(1) == 1) {
					ans = 1;
					user = "seller";
				}
			}
			request.setAttribute("id", id);
			request.setAttribute("user", user);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs2 != null) {
					rs2.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (pstmt2 != null) {
					pstmt2.close();
				}
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
		return ans;
	}
	
	public void totalpage(HttpServletRequest request) {
		String totalpage = "1";
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from cusorder";
		try {
			dbconn = conn();
			pstmt = dbconn.clientPrepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totalpage = String.valueOf(rs.getInt(1));
			request.setAttribute("totalpage", totalpage);
		}
		catch (Exception e) {
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
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public void ordersub(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		String[] orderchk = request.getParameterValues("orderchk");
		String[] orderid = request.getParameterValues("orderid");

		try {
			String sql = "update cusorder set o_chk=1 where o_num = ?";
			dbconn = conn();
			pstmt = dbconn.clientPrepareStatement(sql);
			for(int i = 0; i < orderchk.length; i++) {
				if (orderchk[i].equals("on")) {
					pstmt.setString(1, orderid[i]);
					pstmt.executeUpdate();
					pstmt.clearParameters();
				}
			}
		}
		catch (Exception e) {
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
	
	public void orderlist(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String order = request.getParameter("order");
		String sql = "";
		if (order.equals("waiting")) {
			sql = "select * from cusorder order by o_chk asc";
		}
		else if (order.equals("complete")) {
			sql = "select * from cusorder order by o_chk desc";
		}
		
		
		ArrayList<orderlist> alo = new ArrayList<orderlist>();
		try {
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				orderlist ol = new orderlist();
				ol.setId(rs.getInt("o_num"));
				ol.setDate(rs.getString("o_date"));
				ol.setF_singname(rs.getString("o_f_singname"));
				ol.setF_singunit(rs.getString("o_f_singunit"));
				ol.setAddr(rs.getString("o_addr"));
				ol.setChk(rs.getInt("o_chk"));
				alo.add(ol);
			}
			request.setAttribute("orderlist", alo);
		} 
		catch (Exception e) {
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
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public int modi(HttpServletRequest request) {
		int ans = 0;
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		String id = request.getParameter("id");
		String pwchk = request.getParameter("pwchk");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String addr3 = request.getParameter("addr3");
		String addr = "("+addr1+")"+addr2+" "+addr3;
		String gender = request.getParameter("gender");
		
		String sql = "";
		HttpSession session = request.getSession();
		customer cu = (customer)session.getAttribute("user");
		cu.setName(name);
		
		try {
			dbconn = conn();
			if (pwchk.equals("") && addr1.equals("() ")) {
				sql = "update customer set c_name=?, c_phone=?, c_gender=? ,c_mail=? where c_id=?";
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, phone);
				pstmt.setString(3, gender);
				pstmt.setString(4, email);
				pstmt.setString(5, id);
				ans = pstmt.executeUpdate();
			}
			else if (pwchk.equals("") && !addr1.equals("() ")) {
				sql = "update customer set c_name=?, c_phone=?, c_gender=?, c_addr=? ,c_mail=? where c_id=?";
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, phone);
				pstmt.setString(3, gender);
				pstmt.setString(4, addr);
				pstmt.setString(5, email);
				pstmt.setString(6, id);
				ans = pstmt.executeUpdate();
			}
			else if (!pwchk.equals("") && addr1.equals("() ")) {
				sql = "update customer set c_name=?, c_phone=?, c_gender=?, c_password=? ,c_mail=? where c_id=?";
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, phone);
				pstmt.setString(3, gender);
				pstmt.setString(4, pwchk);
				pstmt.setString(5, email);
				pstmt.setString(6, id);
				ans = pstmt.executeUpdate();
			}
			else {
				sql = "update customer set c_name=?, c_phone=?, c_gender=?, c_addr=?, c_password=? ,c_mail=? where c_id=?";
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, phone);
				pstmt.setString(3, gender);
				pstmt.setString(4, addr);
				pstmt.setString(5, pwchk);
				pstmt.setString(6, email);
				pstmt.setString(7, id);
				ans = pstmt.executeUpdate();
			}
			
		}
		catch (Exception e) {
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
		return ans;
	}
	
	public int selmodi(HttpServletRequest request) {
		int ans = 0;
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		String id = request.getParameter("id");
		String pwchk = request.getParameter("pwchk");
		String com_name = request.getParameter("com_name");
		String owner_name = request.getParameter("owner_name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String addr3 = request.getParameter("addr3");
		String addr = "("+addr1+")"+addr2+" "+addr3;
		
		String sql = "";
		
		try {
			dbconn = conn();
			if (pwchk.equals("") && addr1.equals("() ")) {
				sql = "update seller set s_com_name=?, s_owner_name=?, s_mail=?, s_phone=? where s_id=?";
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, com_name);
				pstmt.setString(2, owner_name);
				pstmt.setString(3, email);
				pstmt.setString(4, phone);
				pstmt.setString(5, id);
				ans = pstmt.executeUpdate();
			}
			else if (pwchk.equals("") && !addr1.equals("() ")) {
				sql = "update seller set s_com_name=?, s_owner_name=?, s_mail=?, s_phone=?, s_addr=? where s_id=?";
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, com_name);
				pstmt.setString(2, owner_name);
				pstmt.setString(3, email);
				pstmt.setString(4, phone);
				pstmt.setString(5, addr);
				pstmt.setString(6, id);
				ans = pstmt.executeUpdate();
			}
			else if (!pwchk.equals("") && addr1.equals("() ")) {
				sql = "update seller set s_com_name=?, s_owner_name=?, s_mail=?, s_phone=?, s_password=? where s_id=?";
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, com_name);
				pstmt.setString(2, owner_name);
				pstmt.setString(3, email);
				pstmt.setString(4, phone);
				pstmt.setString(5, pwchk);
				pstmt.setString(6, id);
				ans = pstmt.executeUpdate();
			}
			else {
				sql = "update seller set s_com_name=?,s_owner_name=?, s_mail=?, s_phone=?, s_addr=?, s_password=? where s_id=?";
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, com_name);
				pstmt.setString(2, owner_name);
				pstmt.setString(3, email);
				pstmt.setString(4, phone);
				pstmt.setString(5, addr);
				pstmt.setString(6, pwchk);
				pstmt.setString(7, id);
				ans = pstmt.executeUpdate();
			}
			
		}
		catch (Exception e) {
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
		return ans;
	}
	public int selpwchk(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("seller");
		String pw = request.getParameter("pw");
		int ans=0;
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select s_com_name, s_com_number, s_owner_name, s_mail, s_phone, s_addr from seller where s_id = ? and s_password = ?";
		try {
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				seller sell = new seller();
				sell.setS_com_name(rs.getString("s_com_name"));
				sell.setS_com_number(rs.getString("s_com_number"));
				sell.setS_owner_name(rs.getString("s_owner_name"));
				sell.setS_mail(rs.getString("s_mail"));
				sell.setS_phone(rs.getString("s_phone"));
				sell.setS_addr(rs.getString("s_addr"));
				ans = 1;
				request.setAttribute("sellinfo", sell);
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
		return ans;
	}
	
	public int pwchk(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userid");
		String pw = request.getParameter("pw");
		int ans=0;
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select c_name, c_mail, c_phone, c_addr, c_gender from customer where c_id = ? and c_password = ?";
	
		try {
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				customer ct = new customer();
				ct.setName(rs.getString("c_name"));
				ct.setMail(rs.getString("c_mail"));
				ct.setPhone(rs.getString("c_phone"));
				ct.setAddr(rs.getString("c_addr"));
				ct.setGender(rs.getString("c_gender"));
				ans = 1;
				request.setAttribute("userinfo", ct);
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
		return ans;
	}
	
	public int sellnumchk(HttpServletRequest request) {
		int chkresult = 0;
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from seller where s_com_name=?";

		String sellnum = request.getParameter("sellnum");
		if (!sellnum.equals("")) {
			try {
				dbconn = conn();
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, sellnum);
				rs = pstmt.executeQuery();
				rs.next();
				chkresult = rs.getInt(1); 
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		else {
			chkresult = -1;
		}
		
		return chkresult; 
	}
	
	
	public int emailchk(HttpServletRequest request) {
		String user = request.getParameter("user");
		int chkresult = 0;
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		if (user.equals("customer")) {
			sql = "select count(*) from customer where c_mail=?";
		}
		else if (user.equals("seller")) {
			sql = "select count(*) from seller where s_mail=?";
		}
		String email = request.getParameter("email");
		if (!email.equals("")) {
			try {
				dbconn = conn();
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				rs.next();
				chkresult = rs.getInt(1); 
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		else {
			chkresult = -1;
		}
		
		return chkresult; 
	}
	
	public int idchk(HttpServletRequest request) {
		String user = request.getParameter("user");
		int chkresult = 0;
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		if (user.equals("customer")) {
			sql = "select count(*) from customer where c_id=?";
		}
		else if (user.equals("seller")){
			sql = "select count(*) from seller where s_id=?";
		}
		String id = request.getParameter("id");
		if (!id.equals("")) {
			try {
				dbconn = conn();
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				rs.next();
				chkresult = rs.getInt(1); 
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		else {
			chkresult = -1;
		}
		
		return chkresult; 
	}
	
	public void logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
	}
	
	public int checkId(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String id = request.getParameter("id");
		int re_idchk = 2;
		
		try {
			String sql = "select * from seller where s_id=?";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				re_idchk = 1;
			}
			else {
				re_idchk = 0;
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
		return re_idchk;
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
	
	public void signup(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String addr3 = request.getParameter("addr3");
		String gender = request.getParameter("gender");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String smark = request.getParameter("smark");
		String emark = request.getParameter("emark");
		
		String birth = year + "-" + month + "-" + day;
		String addr = "("+addr1+")"+addr2+" "+addr3;
		
		boolean smarkvalue = false, emarkvalue = false;
		if (smark.equals("on")) {
			smarkvalue = true;
		}
		if (emark.equals("on")) {
			emarkvalue = true;
		}
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		try {
			dbconn = conn();
			String sql = "insert into customer values (?,?,?,?,?,?,?,?,?,?,?,?)";

			pstmt = dbconn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			pstmt.setString(5, phone);
			pstmt.setString(6, addr);
			pstmt.setString(7, gender);
			pstmt.setString(8, birth);
			pstmt.setBoolean(9, smarkvalue);
			pstmt.setBoolean(10, emarkvalue);
			pstmt.setInt(11, 0);
			pstmt.setString(12, "bronze");
			
			pstmt.executeUpdate();

		}
		catch (Exception e) {
			e.getMessage();
		}
		finally {
			if (pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (dbconn != null) {
				try {
					dbconn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public void seller_signup(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String number = request.getParameter("number");
		String ownername = request.getParameter("ownername");
		String mail = request.getParameter("email");
		String phone = request.getParameter("phone");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String addr3 = request.getParameter("addr3");
		String smark = request.getParameter("smark");
		String emark = request.getParameter("emark");
		
		String addr = "("+addr1+")"+addr2+" "+addr3;
		
		boolean smarkvalue = false, emarkvalue = false;
		if (smark.equals("on")) {
			smarkvalue = true;
		}
		if (emark.equals("on")) {
			emarkvalue = true;
		}
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		try {
			dbconn = conn();
			String sql = "insert into seller values (?,?,?,?,?,?,?,?,?,?)";

			pstmt = dbconn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, number);
			pstmt.setString(5, ownername);
			pstmt.setString(6, mail);
			pstmt.setString(7, phone);
			pstmt.setString(8, addr);
			pstmt.setBoolean(9, smarkvalue);
			pstmt.setBoolean(10, emarkvalue);	
			
			pstmt.executeUpdate();

		}
		catch (Exception e) {
			e.getMessage();
		}
		finally {
			if (pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (dbconn != null) {
				try {
					dbconn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	public boolean login(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rt = null;
		boolean login_ans= false;
		
		try {
			dbconn = conn();
			String sql = "select c_id, c_name, c_addr, c_point, c_class from customer where c_id = (?) and c_password= (?)";
			HttpSession session = request.getSession();
			pstmt = dbconn.prepareStatement(sql);		
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rt = pstmt.executeQuery();
			String sqlans = null;
			if (rt.next()) {
				customer dto = new customer();
				sqlans = rt.getString(1);
				dto.setId(rt.getString(1));
				dto.setName(rt.getString(2));
				dto.setAddr(rt.getString(3));
				dto.setPoint(rt.getInt(4));
				dto.setC_class(rt.getString(5));
				login_ans = true;
				if (session.getAttribute("user") == null) {
					session.setAttribute("user", dto);
				}
			}
			if (session.getAttribute("userid") == null) {
				session.setAttribute("userid", sqlans);		
			}
			
			sql = "select s_id from seller where s_id = (?) and s_password= (?)";

			pstmt2 = dbconn.prepareStatement(sql);		
			pstmt2.setString(1, id);
			pstmt2.setString(2, pw);
			rt = pstmt2.executeQuery();
			String sqlans2 = null;
			if (rt.next()) {
				sqlans2 = rt.getString(1);
				login_ans = true;
			}
			if(session.getAttribute("seller") == null) {
				session.setAttribute("seller", sqlans2);
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (dbconn != null) {
				try {
					dbconn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return login_ans;
	}

}

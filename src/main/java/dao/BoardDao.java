package dao;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;
import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;

import dto.Boardlist;
import dto.oneqna;
import dto.comment;

public class BoardDao {
	private BoardDao() {};
	private static BoardDao dao = new BoardDao();
	public static BoardDao getDao() {
		return  dao;
	}
	
	public void previouspage(HttpServletRequest request) {
		String previouspage = "-1";
		String category = request.getParameter("category");
		String sql = "";
		String id = request.getParameter("id");
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		if (category.equals("게시판")) {
			sql = "select b_id from bulletin where b_id > ? order by b_id asc";
		}
		else if (category.equals("공지사항")) {
			sql = "select n_id from notice where n_id > ? order by n_id asc";
		}
		else if (category.equals("1:1 문의")) {
			sql = "select oq_id from one_qna where oq_id > ? order by oq_id asc";
		}
		else if (category.equals("나만의 레시피")) {
			sql = "select r_id from r_review where r_id > ? order by r_id asc";
		}
		try {
			dbconn = conn();
			pstmt = dbconn.clientPrepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				previouspage = String.valueOf(rs.getInt(1));
			}
			request.setAttribute("previouspage", previouspage);
			
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
	
	
	public void nextpage(HttpServletRequest request) {
		String nextpage = "-1";
		String category = request.getParameter("category");
		String sql = "";
		String id = request.getParameter("id");
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		if (category.equals("게시판")) {
			sql = "select b_id from bulletin where b_id < ? order by b_id desc";
		}
		else if (category.equals("공지사항")) {
			sql = "select n_id from notice where n_id < ? order by n_id desc";
		}
		else if (category.equals("1:1 문의")) {
			sql = "select oq_id from one_qna where oq_id < ? order by oq_id desc";
		}
		else if (category.equals("나만의 레시피")) {
			sql = "select r_id from r_review where r_id < ? order by r_id desc";
		}
		try {
			dbconn = conn();
			pstmt = dbconn.clientPrepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				nextpage = String.valueOf(rs.getInt(1));
			}
			request.setAttribute("nextpage", nextpage);
			
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
	
	public void commentsearch(HttpServletRequest request) {
		
		String category = request.getParameter("category");
		int id = Integer.valueOf(request.getParameter("id"));
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<comment> alc = new ArrayList<comment>(); 
		if (category.equals("나만의 레시피")) {
			category = "r_review";
		}
		else if (category.equals("공지사항")) {
			category = "notice";
		}
		else if (category.equals("게시판")) {
			category = "bulletin";
		}
		String sql = "select * from b_comment where bc_name=? and bc_id=? order by bc_num desc";

		try {
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setInt(2, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				comment cm = new comment();
				cm.setBc_id(rs.getInt("bc_num"));
				cm.setBc_writer(rs.getString("bc_writer"));
				cm.setBc_date(rs.getString("bc_date"));
				cm.setBc_content(rs.getString("bc_content"));
				alc.add(cm);
			}
			request.setAttribute("commentlist", alc);
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
	public void comment(HttpServletRequest request) {
		HttpSession session = request.getSession();

		int id = Integer.valueOf(request.getParameter("id"));
		String category = request.getParameter("category");
		String writer = (String)session.getAttribute("userid");
		String content = request.getParameter("comment");
		SimpleDateFormat formeter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formeter.format(new Date().getTime());
		
		if (category.equals("나만의 레시피")) {
			category = "r_review";
		}
		else if (category.equals("공지사항")) {
			category = "notice";
		}
		else if (category.equals("게시판")) {
			category = "bulletin";
		}		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into b_comment(bc_name, bc_id, bc_writer, bc_content, bc_date) values ('"+category+"',?,?,?,?)";
		
		try {
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, writer);
			pstmt.setString(3, content);
			pstmt.setString(4, date);
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
	public void delnoview(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		String id = request.getParameter("id");
		String category = request.getParameter("category");
		String sql = "";
		if (category.equals("나만의 레시피")) {
			sql = "delete from r_review where r_id=?";
		}
		else if (category.equals("공지사항")) {
			sql = "delete from notice where n_id=?";
		}
		else if (category.equals("게시판")) {
			sql = "delete from bulletin where b_id=?";
		}
		else if (category.equals("1:1 문의")) {
			sql = "delete from one_qna where oq_id=?";
		}
		try {
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void likeup(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String c_id = (String)session.getAttribute("userid");
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		int id = Integer.valueOf(request.getParameter("id"));
		try {
			String sql = "select r_like from r_review where r_id=?";
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			int like = rs.getInt("r_like") + 1;
			
			sql = "update r_review set r_like=? where r_id=?";
			pstmt2 = dbconn.prepareStatement(sql);
			pstmt2.setInt(1, like);
			pstmt2.setInt(2, id);
			pstmt2.executeUpdate();
			
			sql = "insert into likelist (c_id, r_id) values (?,?)";
			pstmt3 = dbconn.prepareStatement(sql);
			pstmt3.setString(1, c_id);
			pstmt3.setInt(2, id);
			pstmt3.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		} 
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt3 != null) {
					pstmt3.close();
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
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	public int likechk(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		HttpSession session = request.getSession();
		String c_id = (String)session.getAttribute("userid");
		String s_id = (String)session.getAttribute("seller");
		
		int r_id = Integer.valueOf(request.getParameter("id"));
		int likechk = -1;
		if (c_id != null) {
			try {
				String sql = "select count(*) from likelist where c_id=? and r_id=?";
				dbconn = conn();
				pstmt = dbconn.prepareStatement(sql);
				pstmt.setString(1, c_id);
				pstmt.setInt(2, r_id);
				rs = pstmt.executeQuery();
				
				rs.next();
				
				likechk = rs.getInt(1);
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
		else if (s_id != null) {
			likechk = 2;
		}
		return likechk;
	}
	
	public void one(HttpServletRequest request) {
		String page = request.getParameter("page");
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			dbconn = conn();
			String sql = "select * from one_qna order by oq_id desc";
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList<oneqna> al = new ArrayList<oneqna>();
			while(rs.next()) {
				oneqna oq = new oneqna();
				int id = rs.getInt("oq_id");
				String title = rs.getString("oq_title");
				String writer = rs.getString("oq_writer");
				String content = rs.getString("oq_content");
				String category = rs.getString("oq_category");
				String date = rs.getString("oq_date");
				int hit = rs.getInt("oq_hit");
				String stat = rs.getString("oq_stat");
				oq.setId(id);
				oq.setTitle(title);
				oq.setWriter(writer);
				oq.setContent(content);
				oq.setCategory(category);
				oq.setDate(date);
				oq.setHit(hit);
				oq.setStat(stat);
				
				al.add(oq);
			}
			request.setAttribute("oneqnalist", al);
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
	
	
	public void bulletin(HttpServletRequest request, String search_title) {
		String page = request.getParameter("page");
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Boardlist> al = new ArrayList<Boardlist>();
		String sql = "";
		try {
			dbconn = conn();
			if (search_title == null || search_title.equals("") || search_title.equals("null")) {
				sql = "select * from bulletin order by b_id desc";
			}
			else {
				sql = "select * from bulletin where b_title like '%"+search_title+"%' order by b_id desc";
			}
				pstmt = dbconn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Boardlist bl = new Boardlist();
				String id = rs.getString("b_id");
				String title = rs.getString("b_title");
				String writer = rs.getString("b_writer");
				String content = rs.getString("b_content");
				String[] img = rs.getString("b_img").split(",");
				String date = rs.getString("b_date");
				int hit = rs.getInt("b_hit");
				bl.setId(id);
				bl.setTitle(title);
				bl.setWriter(writer);
				bl.setContent(content);
				bl.setImg(img);
				bl.setDate(date);
				bl.setHit(hit);
				al.add(bl);
			}
			request.setAttribute("notice", al);
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
	public void recipe_view(HttpServletRequest request) {
		String id = request.getParameter("id");
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt_sub = null;
		try {
			dbconn = conn();		
			
			String sql = "select * from r_review where r_id=?";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Boardlist bl = new Boardlist();
				String title = rs.getString("r_title");
				String writer = rs.getString("r_writer");
				String content = rs.getString("r_content");
				String[] img = rs.getString("r_img").split(",");
				String date = rs.getString("r_date");
				int hit = rs.getInt("r_hit");
				bl.setId(id);
				bl.setTitle(title);
				bl.setWriter(writer);
				bl.setContent(content);
				bl.setImg(img);
				bl.setDate(date);
				bl.setHit(hit+1);
				sql = "update r_review set r_hit=? where r_id=?";
				pstmt_sub = dbconn.prepareStatement(sql);
				pstmt_sub.setInt(1, hit+1);
				pstmt_sub.setString(2, id);
				pstmt_sub.executeUpdate();
				request.setAttribute("viewInfo", bl);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (pstmt_sub != null) {
					pstmt_sub.close();
				}
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
	public void oneview(HttpServletRequest request) {
		String id = request.getParameter("id");
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt_sub = null;
		
		try {
			dbconn = conn();		
			
			String sql = "select * from one_qna where oq_id=?";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Boardlist bl = new Boardlist();
				String title = rs.getString("oq_title");
				String writer = rs.getString("oq_writer");
				String content = rs.getString("oq_content");
				String date = rs.getString("oq_date");
				int hit = rs.getInt("oq_hit");
				bl.setId(id);
				bl.setTitle(title);
				bl.setWriter(writer);
				bl.setContent(content);
				bl.setDate(date);
				bl.setHit(hit+1);
				
				sql = "update one_qna set oq_hit=? where oq_id=?";
				pstmt_sub = dbconn.prepareStatement(sql);
				pstmt_sub.setInt(1, hit+1);
				pstmt_sub.setString(2, id);
				pstmt_sub.executeUpdate();
				request.setAttribute("viewInfo", bl);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (pstmt_sub != null) {
					pstmt_sub.close();
				}
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
	
	public void bulletinview(HttpServletRequest request) {
		String id = request.getParameter("id");
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt_sub = null;
		
		try {
			dbconn = conn();		
			
			String sql = "select * from bulletin where b_id=?";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Boardlist bl = new Boardlist();
				String title = rs.getString("b_title");
				String writer = rs.getString("b_writer");
				String content = rs.getString("b_content");
				String[] img = rs.getString("b_img").split(",");
				String date = rs.getString("b_date");
				int hit = rs.getInt("b_hit");
				bl.setId(id);
				bl.setTitle(title);
				bl.setWriter(writer);
				bl.setContent(content);
				bl.setImg(img);
				bl.setDate(date);
				bl.setHit(hit+1);
				sql = "update bulletin set b_hit=? where b_id=?";
				pstmt_sub = dbconn.prepareStatement(sql);
				pstmt_sub.setInt(1, hit+1);
				pstmt_sub.setString(2, id);
				pstmt_sub.executeUpdate();
				request.setAttribute("viewInfo", bl);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (pstmt_sub != null) {
					pstmt_sub.close();
				}
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
	
	public void noticeview(HttpServletRequest request) {
		String id = request.getParameter("id");
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt_sub = null;
		
		try {
			dbconn = conn();		
			
			String sql = "select * from notice where n_id=?";
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Boardlist bl = new Boardlist();
				String title = rs.getString("n_title");
				String writer = rs.getString("n_writer");
				String content = rs.getString("n_content");
				String[] img = rs.getString("n_img").split(",");
				String date = rs.getString("n_date");
				int hit = rs.getInt("n_hit");
				bl.setId(id);
				bl.setTitle(title);
				bl.setWriter(writer);
				bl.setContent(content);
				bl.setImg(img);
				bl.setDate(date);
				bl.setHit(hit+1);
				
				sql = "update notice set n_hit=? where n_id=?";
				pstmt_sub = dbconn.prepareStatement(sql);
				pstmt_sub.setInt(1, hit+1);
				pstmt_sub.setString(2, id);
				pstmt_sub.executeUpdate();
				request.setAttribute("viewInfo", bl);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (pstmt_sub != null) {
					pstmt_sub.close();
				}
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
	
	public void faq_bopage(HttpServletRequest request, String search_title) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			dbconn = conn();
			if ( search_title == null ||search_title.equals("") || search_title.equals("null")) {
				sql = "select count(*) from faq";
			}
			else {
				sql ="select count(*) from fap where f_title '&"+search_title+"&'";
			}
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			int page = rs.getInt(1);
			request.setAttribute("totalpage", page);
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
	}
	
	public void review_bopage(HttpServletRequest request, String search_title) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			dbconn = conn();
			if (search_title == null || search_title.equals("") || search_title.equals("null")) {
				sql = "select count(*) from r_review";
			}
			else {
				sql = "select count(*) from r_review where r_title like '%"+search_title+"%'";
			}
				pstmt = dbconn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			
			rs.next();
			int page = rs.getInt(1);
			request.setAttribute("totalpage", page);
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
	}
	
	public void onebopage(HttpServletRequest request) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			dbconn = conn();
			String sql = "select count(*) from one_qna";
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			int page = rs.getInt(1);
			request.setAttribute("totalpage", page);
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
	}
	
	public void bulletinbopage(HttpServletRequest request, String search_title) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			dbconn = conn();
			if (search_title == null || search_title.equals("") || search_title.equals("null")) {
				sql = "select count(*) from bulletin";
			}
			else {
				sql = "select count(*) from bulletin where b_title like '%"+search_title+"%'";
			}
				pstmt = dbconn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			
			rs.next();
			int page = rs.getInt(1);
			request.setAttribute("totalpage", page);
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
	}
	
	public void bopage(HttpServletRequest request, String search_title) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			dbconn = conn();
			if (search_title == null || search_title.equals("") || search_title.equals("null")) {
				sql = "select count(*) from notice";
			}
			else {
				sql = "select count(*) from notice where n_title like '%"+search_title+"%'";
			}
				pstmt = dbconn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			rs.next();
			int page = rs.getInt(1);
			request.setAttribute("totalpage", page);
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
	}
	
	public void faq(HttpServletRequest request, String search_title) {
		String sql = "";
		String page = request.getParameter("page");
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Boardlist> al = new ArrayList<Boardlist>();
		try {
			dbconn = conn();
			if (search_title == null || search_title.equals("") || search_title.equals("null")) {
				sql = "select * from faq order by f_id desc";
			}
			else {
				sql = "select * from faq where f_title like '%"+search_title+"%' order by f_id desc";
			} 
			pstmt = dbconn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Boardlist bl = new Boardlist();
				String id = rs.getString("f_id");
				String title = rs.getString("f_title");
				String content = rs.getString("f_content");
				bl.setId(id);
				bl.setTitle(title);
				bl.setContent(content);
				al.add(bl);
			}
			request.setAttribute("faqlist", al);
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
	
	
	public void review(HttpServletRequest request, String search_title) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Boardlist> al = new ArrayList<Boardlist>();
		String sql = "";
		try {
			dbconn = conn();
			if (search_title == null || search_title.equals("") || search_title.equals("null")) {
				sql = "select * from r_review order by r_id desc";
			}
			else {
				sql = "select * from r_review where r_title like '%"+search_title+"%' order by r_id desc";
			}
				pstmt = dbconn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Boardlist bl = new Boardlist();
				String id = rs.getString("r_id");
				String title = rs.getString("r_title");
				String writer = rs.getString("r_writer");
				String content = rs.getString("r_content");
				String[] img = rs.getString("r_img").split(",");
				String date = rs.getString("r_date");
				int hit = rs.getInt("r_hit");
				int like = rs.getInt("r_like");
				bl.setId(id);
				bl.setTitle(title);
				bl.setWriter(writer);
				bl.setContent(content);
				bl.setImg(img);
				bl.setDate(date);
				bl.setHit(hit);
				bl.setLike(like);
				al.add(bl);
			}
			request.setAttribute("review_list", al);
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
	
	public void notice(HttpServletRequest request, String search_title) {
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Boardlist> al = new ArrayList<Boardlist>();
		String sql = "";
		try {
			dbconn = conn();
			if (search_title == null || search_title.equals("") || search_title.equals("null")) {
				sql = "select * from notice order by n_id desc";
			}
			else {
				sql = "select * from notice where n_title like '%"+search_title+"%' order by n_id desc";
			}
				pstmt = dbconn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Boardlist bl = new Boardlist();
				String id = rs.getString("n_id");
				String title = rs.getString("n_title");
				String writer = rs.getString("n_writer");
				String content = rs.getString("n_content");
				String[] img = rs.getString("n_img").split(",");
				String date = rs.getString("n_date");
				int hit = rs.getInt("n_hit");
				bl.setId(id);
				bl.setTitle(title);
				bl.setWriter(writer);
				bl.setContent(content);
				bl.setImg(img);
				bl.setDate(date);
				bl.setHit(hit);
				al.add(bl);
			}
			request.setAttribute("notice", al);
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
	public void reviewwriter(HttpServletRequest request) {

		String realFolder = request.getSession().getServletContext().getRealPath("resources/images");
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, realFolder, 10 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
		} catch (IOException e) {
			e.printStackTrace();
		} 
		String title = multi.getParameter("title");
		String id = multi.getParameter("id");
		String contents = multi.getParameter("contents");
		String filenames = "";
		Enumeration files = multi.getFileNames();
		int cnt = 0;
		while(files.hasMoreElements()) {
			String fname = (String)files.nextElement();
			if (multi.getFilesystemName(fname) != null) {
				if (cnt == 0) {
					filenames += multi.getFilesystemName(fname);
					cnt++;
				}
				else {
					filenames += ","+multi.getFilesystemName(fname);
				}
			}
		}	
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String date = format.format(Calendar.getInstance().getTime());
		
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert into r_review (r_title, r_writer, r_content, r_img, r_date) values (?,?,?,?,?)"; 
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, id);
			pstmt.setString(3, contents);
			pstmt.setString(4, filenames);
			pstmt.setString(5, date);
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
				if(dbconn != null) {
					dbconn.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public void bulletinwriter(HttpServletRequest request) {

		String realFolder = request.getSession().getServletContext().getRealPath("resources/images");
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, realFolder, 10 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		String title = multi.getParameter("title");
		String id = multi.getParameter("id");
		String contents = multi.getParameter("contents");
		String filenames = "";
		Enumeration files = multi.getFileNames();
		int cnt = 0;
		while(files.hasMoreElements()) {
			String fname = (String)files.nextElement();
			if (multi.getFilesystemName(fname) != null) {
				if (cnt == 0) {
					filenames += multi.getFilesystemName(fname);
					cnt++;
				}
				else {
					filenames += ","+multi.getFilesystemName(fname);
				}
			}
		}	
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String date = format.format(Calendar.getInstance().getTime());
		
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert into bulletin (b_title, b_writer, b_content, b_img, b_date) values (?,?,?,?,?)"; 
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, id);
			pstmt.setString(3, contents);
			pstmt.setString(4, filenames);
			pstmt.setString(5, date);
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
				if(dbconn != null) {
					dbconn.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void onewriter(HttpServletRequest request) {

		
		String title = request.getParameter("title");
		String id = request.getParameter("id");
		String contents = request.getParameter("contents");
		String category = request.getParameter("qnasel");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String date = format.format(Calendar.getInstance().getTime());
		
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert into one_qna (oq_title, oq_writer, oq_content, oq_category, oq_date) values (?,?,?,?,?)"; 
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, id);
			pstmt.setString(3, contents);
			pstmt.setString(4, category);
			pstmt.setString(5, date);
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
				if(dbconn != null) {
					dbconn.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void noticewriter(HttpServletRequest request) {

		String realFolder = request.getSession().getServletContext().getRealPath("resources/images");
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, realFolder, 10 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		String title = multi.getParameter("title");
		String id = multi.getParameter("id");
		String contents = multi.getParameter("contents");
		String filenames = "";
		Enumeration files = multi.getFileNames();
		int cnt = 0;
		while(files.hasMoreElements()) {
			String fname = (String)files.nextElement();
			if (multi.getFilesystemName(fname) != null) {
				if (cnt == 0) {
					filenames += multi.getFilesystemName(fname);
					cnt++;
				}
				else {
					filenames += ","+multi.getFilesystemName(fname);
				}
			}
		}	
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String date = format.format(Calendar.getInstance().getTime());
		
		
		Connection dbconn = null;
		PreparedStatement pstmt = null;
		
		try {
			String sql = "insert into notice (n_title, n_writer, n_content, n_img, n_date) values (?,?,?,?,?)"; 
			dbconn = conn();
			pstmt = dbconn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, id);
			pstmt.setString(3, contents);
			pstmt.setString(4, filenames);
			pstmt.setString(5, date);
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
				if(dbconn != null) {
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

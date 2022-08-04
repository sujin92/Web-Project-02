package control;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoardDao;

public class BoardController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String context_p = request.getContextPath();
		String command = uri.substring(context_p.length());
		BoardDao dao = BoardDao.getDao();
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");

		
		
		String search_title = request.getParameter("search_title");
		
		if (command.equals("/community/notice_write.bo")) {
			dao.noticewriter(request);
			RequestDispatcher rd = request.getRequestDispatcher("/community/notice.bo");
			rd.forward(request, response);
		}
		else if (command.equals("/community/notice.bo")) {
			dao.notice(request, search_title);
			dao.bopage(request, search_title);
			RequestDispatcher rd = request.getRequestDispatcher("/community/notice.jsp?category=notice&search_title="+search_title);
			rd.forward(request, response);
		}
		else if (command.equals("/community/notice_view.bo")) {
			dao.previouspage(request);
			dao.nextpage(request);
			dao.noticeview(request);
			dao.bopage(request, search_title);
			dao.commentsearch(request);
			String page = request.getParameter("page");
			RequestDispatcher rd = request.getRequestDispatcher("/community/notice_view.jsp?category=notice&page="+page);
			rd.forward(request, response);
		}
		else if (command.equals("/community/bulletin.bo")) {
			dao.bulletin(request, search_title);
			dao.bulletinbopage(request, search_title);			
			RequestDispatcher rd = request.getRequestDispatcher("/community/notice.jsp?category=bulletin&search_title="+search_title);
			rd.forward(request, response);
		}
		else if (command.equals("/community/bulletin_view.bo")) {
			dao.previouspage(request);
			dao.nextpage(request);
			dao.bulletinview(request);
			dao.bulletinbopage(request, search_title);
			dao.commentsearch(request);
			String page = request.getParameter("page");
			RequestDispatcher rd = request.getRequestDispatcher("/community/notice_view.jsp?category=bulletin&page="+page);
			rd.forward(request, response);
		}
		else if (command.equals("/community/bulletin_write.bo")) {
			dao.bulletinwriter(request);
			response.sendRedirect("http://localhost:8080/tmp_project/community/bulletin.bo");
		}
		else if (command.equals("/community/one_qna.bo")) {
			dao.one(request);
			dao.onebopage(request);
			RequestDispatcher rd = request.getRequestDispatcher("/community/one_qna.jsp");
			rd.forward(request, response);
		}
		else if (command.equals("/community/one_write.bo")) {
			dao.onewriter(request);
			response.sendRedirect("http://localhost:8080/tmp_project/community/one_qna.bo");
		}
		else if (command.equals("/community/one_view.bo")) {
			dao.previouspage(request);
			dao.nextpage(request);
			dao.oneview(request);
			dao.onebopage(request);
			dao.commentsearch(request);
			String page = request.getParameter("page");
			RequestDispatcher rd = request.getRequestDispatcher("/community/notice_view.jsp?category=1:1 문의&page="+page);
			rd.forward(request, response);
		}
		else if (command.equals("/community/review_write.bo")) {
			dao.reviewwriter(request);
			response.sendRedirect("http://localhost:8080/tmp_project/community/review.bo?page=1");
		}
		else if (command.equals("/community/review_view.bo")) {
			dao.previouspage(request);
			dao.nextpage(request);
			dao.recipe_view(request);
			dao.review_bopage(request, search_title);
			dao.commentsearch(request);
			String page = request.getParameter("page");
			RequestDispatcher rd = request.getRequestDispatcher("/community/notice_view.jsp?category=나만의 레시피&page="+page);
			rd.forward(request, response);
		}
		else if (command.equals("/community/review.bo")) {
			dao.review(request, search_title);
			dao.review_bopage(request, search_title);
			String page = request.getParameter("page");
			RequestDispatcher rd = request.getRequestDispatcher("/community/recipe_review.jsp?page="+page+"&search_title="+search_title);
			rd.forward(request, response);
		}
		else if (command.equals("/community/faq.bo")) {
			dao.faq(request, search_title);
			dao.faq_bopage(request, search_title);
			RequestDispatcher rd = request.getRequestDispatcher("/community/faq.jsp?search_title="+search_title);
			rd.forward(request, response);
		}
		else if (command.equals("/community/review_like.bo")) {
			int likechk = dao.likechk(request);
			String page = request.getParameter("page");
			if (likechk == 1) {
				response.sendRedirect("http://localhost:8080/tmp_project/community/review.bo?likechk=1&page="+page);
			}
			else if (likechk == -1) {
				response.sendRedirect("http://localhost:8080/tmp_project/community/review.bo?likechk=-1&page="+page);
			}
			else if (likechk == 2) {
				response.sendRedirect("http://localhost:8080/tmp_project/community/review.bo?likechk=2&page="+page);
			}
			else {
				dao.likeup(request);
				response.sendRedirect("http://localhost:8080/tmp_project/community/review.bo?likechk=3&page="+page);
			}
		}
		else if (command.equals("/community/delnoview.bo")) {
			dao.delnoview(request);
			String page = request.getParameter("page");
			String cate = request.getParameter("category");
			if (cate.equals("나만의 레시피")) {
				RequestDispatcher rd = request.getRequestDispatcher("/community/review.bo?page="+page+"&category="+cate);
				rd.forward(request, response);
			}
			else if (cate.equals("게시판")) {
				RequestDispatcher rd = request.getRequestDispatcher("/community/bulletin.bo?page="+page+"&category="+cate);
				rd.forward(request, response);
			}
			else if (cate.equals("공지사항")) {
				RequestDispatcher rd = request.getRequestDispatcher("/community/notice.bo?page="+page+"&category="+cate);
				rd.forward(request, response);
			}
			else if (cate.equals("1:1 문의")) {
				RequestDispatcher rd = request.getRequestDispatcher("/community/one_qnasdf.bo?page="+page+"&category="+cate);
				rd.forward(request, response);
			}
		}
		else if (command.equals("/community/comment.bo")) {
			dao.comment(request);
			String cate = request.getParameter("category");
			String page = request.getParameter("page");
			String id = request.getParameter("id");
			if (cate.equals("나만의 레시피")) {
				cate = URLEncoder.encode(cate, "UTF-8");
				response.sendRedirect("http://localhost:8080/tmp_project/community/review_view.bo?page="+page+"&category="+cate+"&id="+id);
			}
			else if (cate.equals("게시판")) {
				cate = URLEncoder.encode(cate, "UTF-8");
				response.sendRedirect("http://localhost:8080/tmp_project/community/bulletin_view.bo?page="+page+"&category="+cate+"&id="+id);
			}
			else if (cate.equals("공지사항")) {
				cate = URLEncoder.encode(cate, "UTF-8");
				response.sendRedirect("http://localhost:8080/tmp_project/community/notice_view.bo?page="+page+"&category="+cate+"&id="+id);
			}
			else if (cate.equals("1:1 문의")) {
				cate = URLEncoder.encode(cate, "UTF-8");
				response.sendRedirect("http://localhost:8080/tmp_project/community/one_view.bo?page="+page+"&category="+cate+"&id="+id);
			}
		}
	}
	
}

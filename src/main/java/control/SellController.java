package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SellDao;

public class SellController extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String context_p = request.getContextPath();
		String command = uri.substring(context_p.length());
		SellDao dao = SellDao.getDao();
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		if(command.equals("/login/productmanage.sel")) {
			String foodname = request.getParameter("search_food");
			dao.productmanage(request, foodname);
			dao.totalpage(request, foodname);
			RequestDispatcher rd = request.getRequestDispatcher("/login/productmanage.jsp");
			rd.forward(request, response);
		}
		else if(command.equals("/login/foodsearch.sel")) {
			dao.f_search(request);
			RequestDispatcher rd = request.getRequestDispatcher("/login/foodsearch.jsp");
			rd.forward(request, response);
		}
		else if(command.equals("/login/addfood.sel")) {
			int chk = dao.addchk(request);
			if (chk == 0) {
				dao.addfood(request);
				RequestDispatcher rd = request.getRequestDispatcher("/login/productmanage.sel");
				rd.forward(request, response);
			}
			else {
				response.sendRedirect("http://localhost:8080/tmp_project/login/productmanage.sel?addchk=1");
			}
		}
		else if(command.equals("/login/delfood.sel")) {
			dao.delfood(request);
			response.sendRedirect("http://localhost:8080/tmp_project/login/productmanage.sel");
		}		
	}
	
	
}

package control;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.*;

import dto.cartlist;
import dto.foodprice;
import dto.recipelist;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;

import dao.RecipeDao;

public class RecipeController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String context_p = request.getContextPath();
		String command = uri.substring(context_p.length());
		RecipeDao dao = RecipeDao.getDao();
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String search_title = request.getParameter("search_title");
		
		if (command.equals("/recipe/recipes.re")) {
			String order = request.getParameter("order");
			dao.recipes(request, search_title);
			dao.price(request);
			if (order != null) {
				if (order.equals("rowprice") || order.equals("highprice")) {
					dao.orderprice(request);
				}
			}
			dao.count(request, search_title);
			RequestDispatcher rd = null;
			if (order != null) {
				rd = request.getRequestDispatcher("/recipe/recipes.jsp?search_title="+search_title+"&order="+order);
			} 
			else {
				rd = request.getRequestDispatcher("/recipe/recipes.jsp?search_title="+search_title);
			}
			rd.forward(request, response);
		}
		else if (command.equals("/recipe/recipe.re")) {
			dao.sel_recipe(request);
			dao.price(request);
			RequestDispatcher rd = request.getRequestDispatcher("/recipe/recipe.jsp");
			rd.forward(request, response);
		}
		else if (command.equals("/recipe/addCartIcon.re")) {
			int userchk = dao.userchk(request);
			String id = request.getParameter("id");
			String ct = request.getParameter("r_category");
			ct = URLEncoder.encode(ct, "UTF-8");
			String cupage = request.getParameter("page");
			String order = request.getParameter("order");
			if (userchk == 1) {
				dao.price(request);
				dao.addCartIcon(request, response);
				response.sendRedirect("http://localhost:8080/tmp_project/recipe/recipes.re?chk=1&id="+id+"&r_category="+ct+"&page="+cupage+"&order="+order);
			}
			else if (userchk == 2) {
				response.sendRedirect("http://localhost:8080/tmp_project/recipe/recipes.re?chk=2&id="+id+"&r_category="+ct+"&page="+cupage+"&order="+order);
			}
			else if (userchk == 0) {
				response.sendRedirect("http://localhost:8080/tmp_project/recipe/recipes.re?chk=0&id="+id+"&r_category="+ct+"&page="+cupage+"&order="+order);
			}
		}
		else if (command.equals("/recipe/foodsearch.re")) {
			dao.searchfood(request);
			RequestDispatcher rd = request.getRequestDispatcher("/recipe/foodsel.jsp");
			rd.forward(request, response);
		}
		else if (command.equals("/recipe/addrecipe.re")) {
			dao.addrecipe(request);
			RequestDispatcher rd = request.getRequestDispatcher("/recipe/recipes.re?r_category=밥·죽&page=1");
			rd.forward(request, response);
		}
		else if (command.equals("/recipe/delrecipe.re")) {
			dao.delrecipe(request);
			RequestDispatcher rd = request.getRequestDispatcher("/recipe/recipes.re?r_category=밥·죽&page=1");
			rd.forward(request, response);
		}
		else if (command.equals("/recom.re")) {
			dao.recom(request);
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}
	
}

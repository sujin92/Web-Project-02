package filter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class filtertest implements Filter{
	PrintWriter pw = null;
	@Override
	public void destroy() {
		System.out.println("필터 소멸");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		System.out.println("접속한 클라이언트 IP : "+ request.getRemoteAddr());
		System.out.println("접근한 URL 경로 : "+ getURLPath(request));
		System.out.println("요청 처리 시작 시간 : "+ getCurrentTime());
		pw.println("접속한 클라이언트 IP : "+ request.getRemoteAddr());
		pw.println("접근한 URL 경로 : "+ getURLPath(request));
		pw.println("요청 처리 시작 시간 : "+ getCurrentTime());
		long start = System.currentTimeMillis();
		
		chain.doFilter(request, response);
		
		long end = System.currentTimeMillis();
		System.out.println("요청 처리 종료 시간 : "+ getCurrentTime());
		System.out.println("요청 처리 소요 시간 : "+ (end-start) + "ms");
		System.out.println();
		pw.println("요청 처리 종료 시간 : "+ getCurrentTime());
		pw.println("요청 처리 소요 시간 : "+ (end-start) + "ms");
		pw.println();
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("필터 초기화");
		String filename = filterConfig.getInitParameter("filename");
		try {
			pw = new PrintWriter(new FileWriter(filename, true), true);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private String getCurrentTime() {
		DateFormat fomatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(System.currentTimeMillis());
		String time = fomatter.format(cal.getTime());
		return time;
	}
	
	private String getURLPath(ServletRequest request) {
		HttpServletRequest req;
		String currentPath = "";
		String queryString = "";
		if (request instanceof HttpServletRequest) {
			req = (HttpServletRequest)request;
			currentPath = req.getRequestURI();
			queryString = req.getQueryString();
			queryString = queryString == null ? "" : "?" + queryString;
		}
		return currentPath + queryString;
	}
	
}

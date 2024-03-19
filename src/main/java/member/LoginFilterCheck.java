package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class LoginFilterCheck implements Filter {
	private FilterConfig filterConfig=null;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException { 
		this.filterConfig=filterConfig;		//초기화. web 에서 값 가져오는 역할 
	}

	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String id = request.getParameter("id");					//입력값 가져오기 
		String passwd = request.getParameter("password");
		
		String wid = filterConfig.getInitParameter("id");			//web.xml 에서 값 가져오기 
		String wpasswd = filterConfig.getInitParameter("password");
		
		
		String message; 										//출력문 사용 
		response.setCharacterEncoding("UTF-8");					//한글 변환 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		HttpServletResponse httpResponse = (HttpServletResponse)response;		//response.sendRedirect 사용을 위해 선언
		
		
		if(id.equals(wid) && passwd.equals(wpasswd)) {		//두 값 비교하기  
			message="";
		} else {
			message="아이디 혹은 비밀번호 확인";
			httpResponse.sendRedirect("http://localhost:8080//restart//member//login.jsp");		
		}
		
		writer.println(message);
		
		chain.doFilter(request, response);
		
	}

	
	@Override
	public void destroy() {
		
	}

}

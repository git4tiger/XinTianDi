package cn.yl.filter;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionFilter implements Filter {

	public void destroy() {}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest)req;
		HttpServletResponse response=(HttpServletResponse)resp;
		
		String uri=request.getRequestURI();
		String filename=null;
		int dot=uri.lastIndexOf("/");
		if(dot!=-1){
			filename=uri.substring(dot+1);
		}
		if(!"index.jsp".equals(filename) && !"checkLogin".equals(filename) && !"index".equals(filename) && !filename.endsWith(".gif") && filename.endsWith(".css") && filename.endsWith(".png"))
		{
			HttpSession session=request.getSession();
			Object o=session.getAttribute("user");
			if(o==null){
				response.sendRedirect("index.jsp");
				return;
			}			
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig arg0) throws ServletException {}
}

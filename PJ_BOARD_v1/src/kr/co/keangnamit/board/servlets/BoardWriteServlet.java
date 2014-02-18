package kr.co.keangnamit.board.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.keangnamit.board.dao.*;
import kr.co.keangnamit.board.model.*;

public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public BoardWriteServlet() {
        super();
    }

    public static String getClientIpAddr(HttpServletRequest request){
    	String ip = request.getHeader("X-FORWARED-FOR");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        return ip;
    	
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get이면 다시 write.jsp로 감
		RequestDispatcher rd = request.getRequestDispatcher("write.jsp");
			rd.forward(request, response);	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 파라미터
		String id = request.getParameter("userId");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		
		String ip = getClientIpAddr(request);
		// 모델
		BoardDo board = new BoardDo();
		board.setGroupSeq(0);//
		board.setGroupDep(1);//
		board.setCases("A");//
		board.setTitle(title);
		board.setContents(contents);
		board.setRealFile("");//
		board.setSaveFile("");//
		board.setUserId(id);
		board.setIpAddress(ip);
		
		// 게시물 등록
		BoardDao boardDao = new BoardDao();
		try {
			boardDao.BoardInsert(board);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 페이지 이동
		RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
		rd.forward(request, response);
		//response.sendRedirect("list.jsp");
	}

}

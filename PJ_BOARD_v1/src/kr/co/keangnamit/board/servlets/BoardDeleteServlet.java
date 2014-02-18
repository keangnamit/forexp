package kr.co.keangnamit.board.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.keangnamit.board.dao.BoardDao;


public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public BoardDeleteServlet() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		this.doPost(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String numS = request.getParameter("num");
		String pageNum = request.getParameter("pageNum");
		
		int seqnum = Integer.parseInt(numS);
		
		BoardDao board = new BoardDao();
		
		try {
			board.boardDelete(seqnum);
			
			RequestDispatcher rd = request.getRequestDispatcher("list.jsp?pageNum="+ pageNum);
			rd.forward(request, response);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}

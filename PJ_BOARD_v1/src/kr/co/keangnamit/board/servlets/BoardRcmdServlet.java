package kr.co.keangnamit.board.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.keangnamit.board.dao.BoardDao;
import kr.co.keangnamit.board.dao.BoardDaoImpl;
import kr.co.keangnamit.board.dao.BoardMyBatisDao;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class BoardRcmdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    

    public BoardRcmdServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String num = request.getParameter("seqNum");
		
		//System.out.println("get_seqnum" + num);
		
	    response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
	    response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
	    response.setHeader("Cache-Control", "no-cache");
	    
	    int seqNum = Integer.parseInt(num);
		
		//BoardDao boardDo = new BoardDao();
		BoardDaoImpl boardDao = new BoardMyBatisDao();

		
		int rcmdNo = boardDao.getRecmdNum(seqNum);
		
		//System.out.println("recmm" + rcmdNo);
		
		if ( rcmdNo >= 0 ) {
			//System.out.println("0 > ÃßÃµÈ½¼ö" + rcmdNo);
			JSONObject obj = new JSONObject();
			obj.put("recomm",rcmdNo);
			obj.put("2","22222");
			obj.put("3","33333");
			String outObj = obj.toString();
						
			//System.out.println(obj.toJSONString());
			

			
			response.getWriter().write(outObj);
			
			//String text = Integer.toString(rcmdNo);
			//response.getWriter().write(text);       // Write response body.
			
		    //response.getWriter().flush();
		    //boolean error = response.getWriter().checkError();
		    //System.out.println(error);
		}
	    
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		request.setCharacterEncoding("UTF-8");
	
		String seqnum = request.getParameter("seqNum");
		
		System.out.println("POST" + seqnum);

		int seqNum = Integer.parseInt(seqnum);
		
		BoardDao boardDo = new BoardDao();
		
		int rcmdNo = boardDo.getRecmdNum(seqNum);
		if ( rcmdNo >= 0 ) {
			System.out.println(rcmdNo);
			
			request.setAttribute("", rcmdNo);
			
			//ServletContext sc = getServletContext();
			//sc.getRequestDispatcher("view.jsp").forward(request, response);
			//or
			RequestDispatcher rd = request.getRequestDispatcher("view.jsp");
			rd.forward(request, response);	
		}

		String taxt1 = "POST : " + seqnum; 
	    response.getWriter().write(taxt1);       // Write response body.
	    response.getWriter().flush();
*/
	}
	
}

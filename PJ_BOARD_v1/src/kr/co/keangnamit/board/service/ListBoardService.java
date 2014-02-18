package kr.co.keangnamit.board.service;

import java.util.List;

import kr.co.keangnamit.board.dao.BoardDaoImpl;
import kr.co.keangnamit.board.dao.BoardMyBatisDao;
import kr.co.keangnamit.board.model.BoardDo;
import kr.co.keangnamit.board.model.BoardListModel;

public class ListBoardService {

	private static final int COUNT_PER_PAGE = 10;
	
	private int totalPageCount;
	private int firstRow;
	private int endRow;
	
	public BoardListModel getBoardList(int reqPageNum) throws ClassNotFoundException{
		if(reqPageNum < 0){
			throw new IllegalArgumentException("Page Number < 0 : + " + reqPageNum);
		}
		//BoardDao boardDao = new BoardDao();
		//Connection conn = null;
		
		try{
			/*
			Statement stmt = null;
			ResultSet rs = null;
			conn = SimpleConnection.getConnection();
			stmt = conn.createStatement();
			//rs = stmt.executeQuery("SELECT BOARD_SEQNO.CURRVAL FROM DUAL");
			rs = stmt.executeQuery("SELECT count(*) FROM BOARD");
			rs.next();
			int totalBoardCount = rs.getInt(1);
			*/
			//BoardMyBatisDao boardMyBatisDao = new BoardMyBatisDao();
			BoardDaoImpl boardMyBatisDao = new BoardMyBatisDao();
			
			int totalBoardCount = boardMyBatisDao.BoardTotalCnt();
			if(totalBoardCount == 0){
				return new BoardListModel();
			}
			
			totalPageCount = calcTotalPageCount(totalBoardCount);
			firstRow = (reqPageNum - 1) * COUNT_PER_PAGE + 1;
			endRow = firstRow + COUNT_PER_PAGE - 1;
						
			if (endRow > totalBoardCount){
				endRow = totalBoardCount;
			}
			
			//List<BoardDo> boardList = boardDao.listBoard(conn, firstRow, endRow);
			// Mybatis 利侩 start
			//BoardMyBatisDao boardMyBatisDao = new BoardMyBatisDao();
			List<BoardDo> boardList = boardMyBatisDao.listBoard(firstRow, endRow);
			// Mybatis 利侩 end 
			
			BoardListModel boardListView = new BoardListModel(boardList, reqPageNum, totalPageCount, firstRow,endRow);	
			
			return boardListView;
			
		}finally{
			
		}
		
	}
	
	public BoardListModel getBoardList(int reqPageNum, String type, String words) throws ClassNotFoundException{
		if(reqPageNum < 0){
			throw new IllegalArgumentException("Page Number < 0 : + " + reqPageNum);
		}
		
		try{
			BoardMyBatisDao boardMyBatisDao = new BoardMyBatisDao();
			
			int totalBoardCount = boardMyBatisDao.BoardTotalCnt(type, words);
			
			if(totalBoardCount == 0){
				return new BoardListModel();
			}
			
			totalPageCount = calcTotalPageCount(totalBoardCount);
			firstRow = (reqPageNum - 1) * COUNT_PER_PAGE + 1;
			endRow = firstRow + COUNT_PER_PAGE - 1;
						
			if (endRow > totalBoardCount){
				endRow = totalBoardCount;
			}
			

			// Mybatis 利侩 start
			//BoardMyBatisDao boardMyBatisDao = new BoardMyBatisDao();
			//List<BoardDo> boardList = boardMyBatisDao.listBoard(firstRow, endRow);
			List<BoardDo> boardList = boardMyBatisDao.listBoard(firstRow, endRow, type, words);
			// Mybatis 利侩 end 
			
			BoardListModel boardListView = new BoardListModel(boardList, reqPageNum, totalPageCount, firstRow,endRow);	
			
			return boardListView;
			
		}finally{
			
		}
		
	}

	public int calcTotalPageCount(int totalBoardCount){
		if(totalBoardCount == 0 ){
			return 0;
		}
		int pageCount = totalBoardCount / COUNT_PER_PAGE;
		if(totalBoardCount % COUNT_PER_PAGE > 0){
			pageCount++;
		}
		return pageCount;
	}
	
}

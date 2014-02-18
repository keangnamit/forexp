package kr.co.keangnamit.board.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.keangnamit.board.model.BoardDo;

public interface BoardDaoImpl {
	public int BoardInsert(Connection conn, BoardDo BoardDo) throws SQLException;
	public int BoardInsert(BoardDo BoardDo) throws SQLException;
	public int BoardEdit(Connection conn, BoardDo BoardDo) throws SQLException;
	public int totalBoardCount(Connection conn) throws SQLException;
	public List<BoardDo> listBoard(Connection conn, int firstRow, int endRow) throws SQLException;
	public BoardDo boardView(Connection conn, int seqnum) throws SQLException;
	public void boardDelete(Connection conn, int seqnum) throws SQLException;
	public void boardDelete(int seqnum) throws SQLException;
	public String getClientIpAddr(HttpServletRequest request);
	public int getRecmdNum(int seqNum);
	
	public List<BoardDo> listBoard(int firstRow, int endRow);
	public List<BoardDo> listBoard(int firstRow, int endRow, String type, String words);
	public int BoardTotalCnt();
	public int BoardTotalCnt(String type, String words);
	public BoardDo boardView(int seqnum);

}

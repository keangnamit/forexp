package kr.co.keangnamit.board.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.keangnamit.board.model.*;
import kr.co.keangnamit.jdbc.*;

public class BoardDao implements BoardDaoImpl{

	public BoardDao() {
	}

	public int BoardInsert(Connection conn, BoardDo BoardDo)
			throws SQLException {
		PreparedStatement ps = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

			ps = conn
					.prepareStatement("INSERT INTO BOARD (SEQNO, GROUPSEQ, GROUPDEP, CASE, TITLE,"
							+ " CONTENTS, REALFILE, SAVEFILE, USERID, INSERTDT, UPDATEDT, IPADDRESS)"
							+ " values (BOARD_SEQNO.nextval, ?, ?,?,?,?,?,?,?,sysdate,?,?)");
			ps.setInt(1, BoardDo.getGroupSeq());
			ps.setInt(2, BoardDo.getGroupDep());
			ps.setString(3, BoardDo.getCases());
			ps.setString(4, BoardDo.getTitle());
			ps.setString(5, BoardDo.getContents());
			ps.setString(6, BoardDo.getRealFile());
			ps.setString(7, BoardDo.getSaveFile());
			ps.setString(8, BoardDo.getUserId());
			ps.setTimestamp(9, new Timestamp(BoardDo.getUpdateDt().getTime()));
			ps.setString(10, BoardDo.getIpAddress());

			int insertedCount = ps.executeUpdate();

			if (insertedCount > 0) {
				stmt = conn.createStatement();
				rs = stmt.executeQuery("SELECT count(*) FROM Board");
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
			return -1;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;

		} finally {
			JdbcUtil.close(stmt);
			JdbcUtil.close(rs);
		}
	}

	public int BoardInsert(BoardDo BoardDo) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

				conn = SimpleConnection.getConnection();

			ps = conn
					.prepareStatement("INSERT INTO BOARD (SEQNO, GROUPSEQ, GROUPDEP, CASE, TITLE,"
							+ " CONTENTS, REALFILE, SAVEFILE, USERID, INSERTDT, UPDATEDT, IPADDRESS)"
							+ " values (BOARD_SEQNO.nextval, ?, ?,?,?,?,?,?,?,sysdate,sysdate,?)");
			ps.setInt(1, BoardDo.getGroupSeq());
			ps.setInt(2, BoardDo.getGroupDep());
			ps.setString(3, BoardDo.getCases());
			ps.setString(4, BoardDo.getTitle());
			ps.setString(5, BoardDo.getContents());
			ps.setString(6, BoardDo.getRealFile());
			ps.setString(7, BoardDo.getSaveFile());
			ps.setString(8, BoardDo.getUserId());
			// ps.setTimestamp(9, new
			// Timestamp(BoardDo.getUpdateDt().getTime()));
			ps.setString(9, BoardDo.getIpAddress());

			int insertedCount = ps.executeUpdate();

			if (insertedCount > 0) {
				stmt = conn.createStatement();
				rs = stmt.executeQuery("SELECT count(*) FROM Board");
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
			return -1;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;

		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
			JdbcUtil.close(conn);
		}
	}

	public int BoardEdit(Connection conn, BoardDo BoardDo) throws SQLException {
		PreparedStatement ps = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

			ps = conn
					.prepareStatement("UPDATE BOARD SET TITLE = ?, "
							+ " CONTENTS = ? , REALFILE = ?, SAVEFILE = ?, USERID = ?, "
							+ " UPDATEDT = sysdate , IPADDRESS = ? "
							+ " WHERE SEQNO = ? ");

			ps.setString(1, BoardDo.getTitle());
			ps.setString(2, BoardDo.getContents());
			ps.setString(3, BoardDo.getRealFile());
			ps.setString(4, BoardDo.getSaveFile());
			ps.setString(5, BoardDo.getUserId());
			ps.setString(6, BoardDo.getIpAddress());
			ps.setInt(7, BoardDo.getSeqNo());

			int insertedCount = ps.executeUpdate();

			if (insertedCount > 0) {
				return insertedCount;
			}
			return -1;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;

		} finally {
			JdbcUtil.close(stmt);
			JdbcUtil.close(rs);
		}
	}

	public int totalBoardCount(Connection conn) throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT count(*) FROM BOARD");
			rs.next();
			return rs.getInt(1);

		} finally {
			JdbcUtil.close(stmt);
			JdbcUtil.close(rs);
		}
	}

	public List<BoardDo> listBoard(Connection conn, int firstRow, int endRow)
			throws SQLException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn
					.prepareStatement("select SEQNO, GROUPSEQ, GROUPDEP, CASE, TITLE, CONTENTS, REALFILE, SAVEFILE, USERID, INSERTDT, UPDATEDT, IPADDRESS "
							+ " from "
							+ " (SELECT rownum rn , SEQNO, GROUPSEQ, GROUPDEP, CASE, TITLE,"
							+ " CONTENTS, REALFILE, SAVEFILE, USERID, INSERTDT, UPDATEDT, IPADDRESS"
							+ "  FROM BOARD order by seqno desc ) WHERE rn >= ? and rn <= ? ");
			ps.setInt(1, firstRow);
			ps.setInt(2, endRow);
			rs = ps.executeQuery();

			if (!rs.next()) {
				return Collections.emptyList();
			}
			List<BoardDo> boardList = new ArrayList<BoardDo>();
			do {
				BoardDo board = new BoardDo();
				board.setSeqNo(rs.getInt(1));
				board.setGroupSeq(rs.getInt(2));
				board.setGroupDep(rs.getInt(3));
				board.setCases(rs.getString(4));
				board.setTitle(rs.getString(5));
				board.setContents(rs.getString(6));
				board.setRealFile(rs.getString(7));
				board.setSaveFile(rs.getString(8));
				board.setUserId(rs.getString(9));
				board.setInsertDt(rs.getTimestamp(10));
				board.setUpdateDt(rs.getTimestamp(11));
				board.setIpAddress(rs.getString(12));

				boardList.add(board);
			} while (rs.next());
			return boardList;
		} finally {
			JdbcUtil.close(ps);
			JdbcUtil.close(rs);
		}
	}

	public BoardDo boardView(Connection conn, int seqnum) throws SQLException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {

			ps = conn
					.prepareStatement("SELECT SEQNO, GROUPSEQ, GROUPDEP, CASE, TITLE,"
							+ " CONTENTS, REALFILE, SAVEFILE, USERID, INSERTDT, UPDATEDT, IPADDRESS , RECOMMENDNO"
							+ "  FROM BOARD where seqno = ? ");

			ps.setInt(1, seqnum);
			rs = ps.executeQuery();
			rs.next();
			BoardDo board = new BoardDo();
			board.setSeqNo(rs.getInt(1));
			board.setGroupSeq(rs.getInt(2));
			board.setGroupDep(rs.getInt(3));
			board.setCases(rs.getString(4));
			board.setTitle(rs.getString(5));
			board.setContents(rs.getString(6));
			board.setRealFile(rs.getString(7));
			board.setSaveFile(rs.getString(8));
			board.setUserId(rs.getString(9));
			board.setInsertDt(rs.getTimestamp(10));
			board.setUpdateDt(rs.getTimestamp(11));
			board.setIpAddress(rs.getString(12));
			board.setRecommendNo(rs.getInt(13));

			return board;
		} finally {
			JdbcUtil.close(ps);
			JdbcUtil.close(rs);
		}
	}

	public void boardDelete(Connection conn, int seqnum) throws SQLException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("DELETE FROM BOARD WHETE SEQNO = ?");

			ps.setInt(1, seqnum);
			ps.executeUpdate();

		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(ps);
		}
	}

	public void boardDelete(int seqnum) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;

		try {

			conn = SimpleConnection.getConnection();

			ps = conn.prepareStatement("DELETE FROM BOARD WHERE SEQNO = ?");

			ps.setInt(1, seqnum);
			ps.executeUpdate();

		} finally {
			JdbcUtil.close(ps);
			JdbcUtil.close(conn);
		}
	}
    public String getClientIpAddr(HttpServletRequest request){
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
    
    public int getRecmdNum(int seqNum) {
    	Connection conn = null;
    	PreparedStatement ps = null;
    	ResultSet rs = null;
    	int oldRcmNo = 0;
    	int newRcmNo = 0;
    	
    	try{
    		conn  = SimpleConnection.getConnection();

    		ps = conn.prepareStatement("SELECT NVL(RECOMMENDNO, 0) FROM BOARD WHERE SEQNO = ?");
    		ps.setInt(1, seqNum);
    		rs = ps.executeQuery();
    		rs.next();
    		oldRcmNo = rs.getInt(1);

    		ps = conn.prepareStatement("UPDATE BOARD SET RECOMMENDNO = nvl(RECOMMENDNO,0) + 1 WHERE SEQNO = ?");
    		ps.setInt(1, seqNum);
    		rs = ps.executeQuery();
    		newRcmNo = oldRcmNo + 1;
    		BoardDo board = new BoardDo();
    		board.setRecommendNo(newRcmNo);
    		//conn.commit();
    		
    		return newRcmNo;

    		
    	} catch (SQLException e) {
			e.printStackTrace();
		}finally{
    		JdbcUtil.close(rs);
    		JdbcUtil.close(ps);
    		JdbcUtil.close(conn);
    	}
		return newRcmNo;
    }

	@Override
	public List<BoardDo> listBoard(int firstRow, int endRow) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardDo> listBoard(int firstRow, int endRow, String type,
			String words) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int BoardTotalCnt() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int BoardTotalCnt(String type, String words) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public BoardDo boardView(int seqnum) {
		// TODO Auto-generated method stub
		return null;
	}

}

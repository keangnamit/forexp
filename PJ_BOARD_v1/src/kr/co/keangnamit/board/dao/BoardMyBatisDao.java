package kr.co.keangnamit.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.keangnamit.board.model.BoardDo;
import kr.co.keangnamit.jdbc.JdbcUtil;
import kr.co.keangnamit.jdbc.SimpleConnection;
import kr.co.keangnamit.sql.MyBatis;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class BoardMyBatisDao implements BoardDaoImpl{
	private SqlSessionFactory sesstioFactory = null;
	
	public BoardMyBatisDao(){
		this.sesstioFactory = MyBatis.getSqlSessionFactory();
	}
	
	
	public List<BoardDo> listBoard(int firstRow, int endRow){
		SqlSession session = this.sesstioFactory.openSession();
		
		try{
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("first", firstRow);
			map.put("end", endRow);
			return session.selectList("boardMapper.selectList",map);

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(session != null) session.close();
		}
		return null;
	}
	
	public List<BoardDo> listBoard(int firstRow, int endRow, String type, String words){
		SqlSession session = this.sesstioFactory.openSession();
		
		try{
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("first", firstRow);
			map.put("end", endRow);
			map.put("type", type);
			map.put("words", words);
			//return session.selectList("boardMapper.selectList",map);
			return session.selectList("boardMapper.selectFindList",map);

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(session != null) session.close();
		}
		return null;
	}
	
	public int BoardTotalCnt(){
		SqlSession session = this.sesstioFactory.openSession();
		
		try{
			return session.selectOne("boardMapper.selectTotalCnt");

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(session != null) session.close();
		}
		return 0;		
	}
	
	public int BoardTotalCnt(String type, String words){
		SqlSession session = this.sesstioFactory.openSession();
		
		try{
			//return session.selectOne("boardMapper.selectTotalCnt");
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("type", type);
			map.put("words", words);
			return session.selectOne("boardMapper.selectSearchTotalCnt",map);

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(session != null) session.close();
		}
		return 0;		
	}
	
	public BoardDo boardView(int seqnum) {
		SqlSession session = this.sesstioFactory.openSession();
		try {
			return session.selectOne("boardMapper.selectView",seqnum);
		}catch(Exception e){
			e.printStackTrace();
		} 
		finally {
			if(session != null) session.close();
		}
		return null;
	}
	@Override
	public int getRecmdNum(int seqNum) {
    	int oldRcmNo = 0;
    	int newRcmNo = 0;
    	SqlSession session = this.sesstioFactory.openSession();
    	try{

    		oldRcmNo = session.selectOne("boardMapper.selectRecomm",seqNum);
    		
    		session.update("boardMapper.updateRecomm", seqNum);
    		
    		newRcmNo = oldRcmNo + 1;
    		
    		BoardDo board = new BoardDo();
    		board.setRecommendNo(newRcmNo);
    		session.commit();
  		
    		return newRcmNo;

    		
    	} catch (Exception e) {
			e.printStackTrace();
		}finally{
    		if(session != null) session.close();
    	}
		return newRcmNo;
	}	

	@Override
	public int BoardInsert(Connection conn, BoardDo BoardDo)
			throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public int BoardInsert(BoardDo BoardDo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public int BoardEdit(Connection conn, BoardDo BoardDo) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public int totalBoardCount(Connection conn) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public List<BoardDo> listBoard(Connection conn, int firstRow, int endRow)
			throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public BoardDo boardView(Connection conn, int seqnum) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void boardDelete(Connection conn, int seqnum) throws SQLException {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void boardDelete(int seqnum) throws SQLException {
		// TODO Auto-generated method stub
		
	}


	@Override
	public String getClientIpAddr(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

}

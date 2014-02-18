package kr.co.keangnamit.board.model;

import java.util.Date;


public class BoardDo {
	private int seqNo;
	private int groupSeq;
	private int groupDep;
	private String cases;
	private String title;
	private String contents;
	private String realFile;
	private String saveFile;
	private String userId;
	private Date insertDt;
	private Date updateDt;
	private String ipAddress;
	private int RecommendNo;
	
	public int getSeqNo() {
		return seqNo;
	}
	public int getGroupSeq() {
		return groupSeq;
	}
	public int getGroupDep() {
		return groupDep;
	}
	public String getCases() {
		return cases;
	}
	public String getTitle() {
		return title;
	}
	public String getContents() {
		return contents;
	}
	public String getRealFile() {
		return realFile;
	}
	public String getSaveFile() {
		return saveFile;
	}
	public String getUserId() {
		return userId;
	}
	public Date getInsertDt() {
		return insertDt;
	}
	public Date getUpdateDt() {
		return updateDt;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public int getRecommendNo(){
		return RecommendNo;
	}
	
	public void setSeqNo(int seqNo) {
		this.seqNo = seqNo;
	}
	public void setGroupSeq(int groupSeq) {
		this.groupSeq = groupSeq;
	}
	public void setGroupDep(int groupDep) {
		this.groupDep = groupDep;
	}
	public void setCases(String cases) {
		this.cases = cases;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public void setRealFile(String realFile) {
		this.realFile = realFile;
	}
	public void setSaveFile(String saveFile) {
		this.saveFile = saveFile;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public void setInsertDt(Date insertDt) {
		this.insertDt = insertDt;
	}
	public void setUpdateDt(Date updateDt) {
		this.updateDt = updateDt;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public void setRecommendNo(int recommendNo){
		this.RecommendNo = recommendNo;
	}
}

package com.project.mj.manager.domain;


public class SearchVO {
	private String searchKey;
	private String searchStatus;
	private String searchKeyword;
	private String startdate;
	private String enddate;
	private String manager;
	private String name;
	private String dbstartdate;
	private String dbenddate;
	private String depositstartdate;
	private String depositenddate;
	private String searchWriter;
	private String searchTitle;
	private Criteria cri;
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchStatus() {
		return searchStatus;
	}
	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public Criteria getCri() {
		return cri;
	}
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDbstartdate() {
		return dbstartdate;
	}
	public void setDbstartdate(String dbstartdate) {
		this.dbstartdate = dbstartdate;
	}
	public String getDbenddate() {
		return dbenddate;
	}
	public void setDbenddate(String dbenddate) {
		this.dbenddate = dbenddate;
	}
	public String getDepositstartdate() {
		return depositstartdate;
	}
	public void setDepositstartdate(String depositstartdate) {
		this.depositstartdate = depositstartdate;
	}
	public String getDepositenddate() {
		return depositenddate;
	}
	public void setDepositenddate(String depositenddate) {
		this.depositenddate = depositenddate;
	}
	public String getSearchWriter() {
		return searchWriter;
	}
	public void setSearchWriter(String searchWriter) {
		this.searchWriter = searchWriter;
	}
	public String getSearchTitle() {
		return searchTitle;
	}
	public void setSearchTitle(String searchTitle) {
		this.searchTitle = searchTitle;
	}
	
}

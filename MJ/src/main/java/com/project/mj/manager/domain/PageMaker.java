package com.project.mj.manager.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private Criteria cri;
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

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public boolean isPrev() {
		return prev;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	
	public Criteria getCri() {
		return cri;
	}
	 
	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
	  
		int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}
	
	
	
	public String makeQuery(int page) {
		UriComponents uriComponents =
		UriComponentsBuilder.newInstance()
						    .queryParam("page", page)
							.queryParam("perPageNum", cri.getPerPageNum())
							.queryParam("searchStatus", searchStatus)
							.queryParam("searchKeyword", searchKeyword)
							.queryParam("startdate", startdate)
							.queryParam("enddate", enddate)
							.queryParam("searchKey", searchKey)
							.build();
		String uri = uriComponents.toUriString();
		   
		return uri;
	}
	public String makeLogQuery(int page) {
		UriComponents uriComponents =
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("name", name)
				.queryParam("manager", manager)
				.queryParam("dbstartdate", dbstartdate)
				.queryParam("dbenddate", dbenddate)
				.queryParam("depositstartdate", depositstartdate)
				.queryParam("depositenddate", depositenddate)
				.queryParam("searchStatus", searchStatus)
				.build();
		String uri = uriComponents.toUriString();
		
		return uri;
	}
	
	public String makeBoardQuery(int page) {
		UriComponents uriComponents =
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchWriter", searchWriter)
				.queryParam("searchTitle", searchTitle)
				.queryParam("startdate", startdate)
				.queryParam("enddate", enddate)
				.build();
		String uri = uriComponents.toUriString();
		
		return uri;
	}
	
	public String makeManagerQuery(int page) {
		UriComponents uriComponents =
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchStatus", searchStatus)
				.queryParam("searchKey", searchKey)
				.queryParam("searchKeyword", searchKeyword)
				.build();
		String uri = uriComponents.toUriString();
		
		return uri;
	}
}
